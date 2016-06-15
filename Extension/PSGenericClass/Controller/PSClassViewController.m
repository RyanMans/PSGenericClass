//
//  PSClassViewController.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/8.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSClassViewController.h"
#import "PSIntroduceCell.h"
#import "PSIntroduceModel.h"

@interface PSClassViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * displayTableView;
@property (nonatomic,strong)NSMutableArray * allDataSource;
@end

@implementation PSClassViewController
- (void)dealloc
{
    _displayTableView = nil;
    _allDataSource = nil;
}

- (UITableView*)displayTableView
{
    if (!_displayTableView) {
        _displayTableView  = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _displayTableView.delegate = self;
        _displayTableView.dataSource = self;
        [_displayTableView setContentInset:UIEdgeInsetsMake(-20, 0, 0, 0)];
        
    }
    return _displayTableView;
}
- (NSMutableArray*)allDataSource
{
    if (!_allDataSource) {
        _allDataSource = NewClass(NSMutableArray);
    }
    return _allDataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    SetNaviTitle(@"底层类库设计");
    
    [self  loadAllAppDataSource];
    
    [self.view addSubview:self.displayTableView];
}

- (void)loadAllAppDataSource
{
    LogFunctionName();
    
    //基类
    
    //1.网络类库
    PSIntroduceModel * httpModel = [self setAppModelWithText:@"网络类库 - HttpBaseServe " detailText:@"网路基类，管理整个app的后台接口"];
    [self.allDataSource addObject:httpModel];
    
    
    //2.数据库
    PSIntroduceModel * dataModel = [self setAppModelWithText:@"数据库 - PSLocalDataStorage" detailText:@"数据类库，管理数据缓存"];
    [self.allDataSource addObject:dataModel];
    
    
    //3.广播中心
    PSIntroduceModel * msgModel = [self setAppModelWithText:@"广播中心 - PSMsgCenter" detailText:@"广播中心，消息发送 、监听 和 事件响应"];
    [self.allDataSource addObject:msgModel];
    
    
    //4.文件管理
    PSIntroduceModel * fileModel = [self  setAppModelWithText:@"文件管理 - PSFileManager" detailText:@"文件管理的工具类"];
    [self.allDataSource addObject:fileModel];
    
    
    //5.图片缓存
    PSIntroduceModel * imageModel = [self  setAppModelWithText:@"图片管理类库 - PSImgCacheTools" detailText:@"图片管理的工具类"];
    [self.allDataSource addObject:imageModel];
    

    
}

- (PSIntroduceModel*)setAppModelWithText:(NSString*)text detailText:(NSString*)detailText
{
    NSDictionary * dict = @{@"text":IsSafeString(text),@"detailText":IsSafeString(detailText)};
    PSIntroduceModel * appModel = [PSIntroduceModel modelWithDictionary:dict];
    return appModel;
}

#pragma mark -代理-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [PSIntroduceCell cellHeight];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PSIntroduceCell * appCell = [PSIntroduceCell cellWithTableView:tableView];
    
    PSIntroduceModel * classModel = _allDataSource[indexPath.row];
    appCell.introduceModel = classModel;
    
    return appCell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
