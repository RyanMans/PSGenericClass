//
//  PSMobileBookViewController.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/9.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSMobileBookViewController.h"
#import "PSLetterDisplayView.h"
#import "PSHeaderInSectionView.h"
#import "PSMobileContactCell.h"
#import "PSContactAccessoryView.h"
#import "PSMobileBookUtil.h"
#import "PSInfoViewController.h"

/**
 *  适用本地手机录的读取，来展现我类库的具体使用
 
    主要有
    1.本地手机通讯录读取 （有条件 可以真机 测试下，加载速度）
    2.异步线程处理大数据
    3.数据缓存
    4.通知中心
 
    这里模拟网络环境。手机通讯录假设为 ‘网络获取’
   
    读取本地数据 －>刷新页面 －>
 
      ->  网络获取数据 －> 网络数据存入本地数据库 －> 读取本地数据 －>刷新页面缓存
 
 */


@interface PSMobileBookViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger _runNumber;
    
    NSMutableArray	* _allMobileContacts;
    NSMutableArray  * _capSectionLists;
    // 索引
    PSLetterDisplayView * _letterView;
    PSContactAccessoryView * _accessoryView;
    
    
    //显示的
    UITableView * _displayTableView;
    NSMutableArray * _displayDataSource;
    
    BOOL _isfirstRun;
}
@end

@implementation PSMobileBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    SetNaviTitle(@"手机通讯录");
    
    [self  setupTableView];
    [self  addLetterDisplayView];
    
    [PSMsgCenterInstance addReceiver:self type:MsgTypeMobileContactNeedReload];
    [PSMsgCenterInstance addReceiver:self type:MsgTypeMobileContactNeedRedownload];
}

//消息响应处理是在异步线程，所以响应操作 须回归到主线程。当然有两种格式 本地 和网络，命名规范自己定义也可以
- (void)didReceivedMessage:(NSString *)type msgDispatcher:(PSMsgCenter *)sender userParam:(id)param
{
    LogFunctionName();
    WeakSelf(ws);
    if (IsSameString(type, MsgTypeMobileContactNeedReload))
    {
        runBlockWithMain(^{
            //本地刷新
            [ws loadAllMobileContacts];
            PSLog(@"本地刷新");
        });
    }
    else if (IsSameString(type, MsgTypeMobileContactNeedRedownload))
    {
        runBlockWithMain(^{
            
            //网络刷新
            [ws getNetDataSourceList];
            PSLog(@"网络刷新");
        });
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isfirstRun == NO)
    {
        _isfirstRun = YES;
        [self loadAllMobileContacts];
        
        [self getNetDataSourceList];
    }
}

- (void)setupTableView
{
    _displayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStyleGrouped)];
    _displayTableView.delegate = self;
    _displayTableView.dataSource = self;
    _displayTableView.showsVerticalScrollIndicator = NO;
    _displayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _displayTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    _displayTableView.sectionIndexColor = RGB(102, 102, 102);
    [self.view addSubview:_displayTableView];
    
    UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineV.backgroundColor = RGB(248, 248, 248);
    _displayTableView.tableFooterView = lineV;
    
}

- (void)addLetterDisplayView
{
    _letterView = [PSLetterDisplayView letterDisplayWithCenter:CGPointMake(HalfF(SCREEN_WIDTH), HalfF(VALID_VIEW_HEIGHT))];
    [_letterView setLayerWithCr:10];
    [self.view addSubview:_letterView];
}

// 默认是先加载本地数据
- (void)loadAllMobileContacts
{
    if ([NSThread isMainThread] == YES)
    {
        runBlockWithAsync(^{
           
            [self loadAllMobileContacts];
        });
        return;
    }
    
    NSArray * aaa = [PSLocalDataStorageInstance getAllMobileContactList];
 
//    NSMutableArray * _tempMobileContacts = [PSMobileBookUtil getAllMobileContacts];
    
    if (aaa.count == 0 || !aaa) return;
    //同名 多个手机号码
    
    NSArray *  _tempMobileContacts = [PSMobileContactModel modelWithKeyValuesArrays:aaa];
    
    NSMutableArray * _newTemp = NewMutableArray();
    
    NSInteger count = _tempMobileContacts.count;
    
    for (NSUInteger i = 0; i < count; i++)
    {
        PSMobileContactModel * mobileMobel = _tempMobileContacts[i];
        mobileMobel.mobile = mobileMobel.mobileArr[0];
        mobileMobel.mobile = [mobileMobel.mobile onlyNumbers];

#if DEBUG
        mobileMobel.mobile  =  mobileMobel.mobile ;
#else
        mobileMobel.mobile  = [mobileMobel.mobile isEffectiveMobileNumber];
#endif
        [_newTemp addObject:mobileMobel];
        
        if (mobileMobel.mobileArr.count <=1)continue;
        
        for (NSUInteger j = 1; j < mobileMobel.mobileArr.count; j ++)
        {
            PSMobileContactModel * m = [PSMobileContactModel modelWithDictionary:[mobileMobel dictionary]];
            m.mobile = mobileMobel.mobileArr[j];
            m.mobile = [m.mobile onlyNumbers];
#if DEBUG
            m.mobile  =  m.mobile ;
#else
            m.mobile  = [m.mobile isEffectiveMobileNumber];
#endif
            [_newTemp addObject:m];
        }
    }
    
    _allMobileContacts = NewMutableArray();
    
    for (PSMobileContactModel * model in _newTemp)
    {
        if (model.mobile.length) {
            [_allMobileContacts addObject:model];
        }
    }

    [self sortWithDataSource:_allMobileContacts];

}
- (void)sortWithDataSource:(NSArray*)temp
{
    if (temp.count == 0) {
        [self refreshDataSourceToUi:nil iNames:nil];
        return;
    }
    if ([NSThread isMainThread])
    {
        runBlockWithAsync(^{
            [self sortWithDataSource:temp];
        });
        return;
    }
    NSMutableDictionary *dSource = NewMutableDictionary();
    for (PSMobileContactModel *model in temp)
    {
        NSString *key = model.firstPY;
        if (0 == key.length) key = @"";
        NSMutableArray *buffer = dSource[key];
        if (nil == buffer)
        {
            buffer = NewMutableArray();
            dSource[key] = buffer;
        }
        [buffer addObject:model];
    }
    
    for (NSString *key in dSource.allKeys)
    {
        NSArray *temp = dSource[key];
        temp = [temp sortedArrayUsingComparator:^NSComparisonResult(PSMobileContactModel *obj1, PSMobileContactModel * obj2) {
            return [obj1.name compare:obj2.name];
        }];
        dSource[key] = temp;
    }
    
    NSArray *iNames = [dSource.allKeys sortedArrayUsingSelector:@selector(compare:)];
    {
        NSString *obj = iNames.firstObject;
        if ([obj isEqualToString:@"#"])
        {
            NSMutableArray *temp = [iNames mutableCopy];
            [temp removeObject:obj];
            [temp addObject:obj];
            iNames = temp;
        }
    }
    [self refreshDataSourceToUi:dSource iNames:iNames];
    
}
- (void)refreshDataSourceToUi:(NSDictionary*)dict iNames:(NSArray*)iNames
{
    LogFunctionName();
    if (NO == [NSThread isMainThread])
    {
        runBlockWithMain(^{[self refreshDataSourceToUi:dict iNames:iNames];});
        return;
    }
    _displayDataSource = [@[] mutableCopy];
    if (dict == nil && iNames == nil)
    {
        [_displayTableView reloadData];
        return;
    }
    for (NSString  * key in iNames)
    {
        NSArray *temp = dict[key];
        temp= [temp sortedArrayUsingComparator:^NSComparisonResult(PSMobileContactModel *obj1, PSMobileContactModel * obj2) {
            return [obj1.name compare:obj2.name];
        }];
        [_displayDataSource addObject:temp];
    }
    _capSectionLists = [iNames mutableCopy];
    if (_capSectionLists.count)[_capSectionLists insertObject:UITableViewIndexSearch atIndex:0];
    [_displayTableView reloadData];
    
}
#pragma mark -代理-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _displayDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = _displayDataSource[section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PSMobileContactCell cellHeight];
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PSHeaderInSectionView * sectionView = [PSHeaderInSectionView viewForHeaderInSectionH:HalfF(40)];
    NSArray * arr = _displayDataSource[section];
    sectionView.flag = 2 + 8;
    if (arr && arr.count != 0)
    {
        PSMobileContactModel * model = [arr firstObject];
        sectionView.text = model.firstPY;
    }
    return sectionView;
}
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _capSectionLists;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    LogFunctionName();
    if (IsSameString(title, UITableViewIndexSearch))return index;
    [_letterView animationsLetterDisplay:title];
    return index;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * arr = _displayDataSource[indexPath.section];

    PSMobileContactModel * model = arr [indexPath.row];
    PSMobileContactCell * mCell = [PSMobileContactCell cellWithTableView:tableView];
    mCell.name = model.name;
    mCell.mobile = model.mobile;
    mCell.lineView.hidden = indexPath.row == arr.count - 1;
    return mCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray * arr = _displayDataSource[indexPath.section];
    PSMobileContactModel * model = arr [indexPath.row];
    PSInfoViewController * infoVC = NewClass(PSInfoViewController);
    infoVC.contactModel= model;
    [self.navigationController pushViewController:infoVC animated:YES];

}


#pragma mark -获取网络数据-
- (void)getNetDataSourceList
{
    //获取网络数据
    
    WeakSelf(ws);
    [HttpServerInstance getAllMobileContactListWithToken:@"xxx" block:^(NSDictionary *respone, NSError *error, id userParam) {
        
        runBlockWithMain(^{
            
            //处理网络数据 respone
            if (respone == nil) {
                
                //数据异常
                
                return ;
            }
            if (getNetCode(respone) == 0) {
                
                //请求成功
                //在这里 就先 用本地手机通讯录 做个列子 （由于类库里面 已经转化成模型，所以在这里 也多此一举下，换成字典）
                
                NSMutableArray * _tempMobileContacts = [PSMobileBookUtil getAllMobileContacts];
                NSArray * dicts = [PSMobileContactModel keyValuesArrayWithObjectArray:_tempMobileContacts];
                
                [PSLocalDataStorageInstance removeAllMobileContactList];
                [PSLocalDataStorageInstance addAllMobileContactList:dicts];
                
                [ws loadAllMobileContacts];
                
            }
            else
            {
                //请求失败
                
            }
            
        });

    }];
    
}


@end
