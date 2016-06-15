//
//  PSAppViewController.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/4/15.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSAppViewController.h"
#import "PSIntroduceCell.h"
#import "PSIntroduceModel.h"
@interface PSAppViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * displayTableView;
@property (nonatomic,strong)NSMutableArray * allDataSource;
@end

@implementation PSAppViewController
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
    SetNaviTitle(@"app框架设计");
    
    [self  loadAllAppDataSource];
    
    [self.view addSubview:self.displayTableView];
}

- (void)loadAllAppDataSource
{
    LogFunctionName();
    
    //基类

    //1.UITabBarController
    
    PSIntroduceModel * tabModel = [self setAppModelWithText:@"UITabBarController - PSTabBarController " detailText:@"框架主体，管理全局导航控制器及tabbar样式"];
    [self.allDataSource addObject:tabModel];
    
    //2.UINavigationController
    PSIntroduceModel * navModel = [self setAppModelWithText:@"UINavigationController - PSNavigationController" detailText:@"管理全局子控制器及导航样式"];
    [self.allDataSource addObject:navModel];
    
    //3.UIViewController
    PSIntroduceModel * baseVCModel = [self setAppModelWithText:@"UIViewController - PSBaseViewController" detailText:@"控制器基类，须继承。管理控制器的基本事件和ui"];
    [self.allDataSource addObject:baseVCModel];
    
    //4.NSObject
    PSIntroduceModel * objectModel = [self  setAppModelWithText:@"NSObject - PSBaseModel" detailText:@"数据模型基类，须继承。管理数据模型的基本转换"];
    [self.allDataSource addObject:objectModel];
    
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
    
    PSIntroduceModel * appModel = _allDataSource[indexPath.row];
    appCell.introduceModel = appModel;
  
    return appCell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
