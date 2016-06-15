//
//  PSlistViewController.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/8.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSlistViewController.h"

#import "PSAppViewController.h"
#import "PSClassViewController.h"
#import "PSMobileBookViewController.h"

@interface PSListModel :PSBaseModel
@property (nonatomic,copy)NSString * text;
@property (nonatomic,assign)NSNumber * type;
@end
@implementation PSListModel
@end


@interface PSlistViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * displayTableView;
@property (nonatomic,strong)NSMutableArray * allDataSource;
@end

@implementation PSlistViewController
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
    
    [self  loadAllListDataSource];
    
    [self.view   addSubview:self.displayTableView];
}

- (void)loadAllListDataSource
{
    LogFunctionName();
    
    //1. app框架设计
    PSListModel * appModel = [self setListModelWithText:@"app框架设计" type:@0];
    [self.allDataSource addObject:appModel];
    
    //2. 底层类库设计
    
    PSListModel * classModel = [self setListModelWithText:@"底层类库设计" type:@1];
    [self.allDataSource addObject:classModel];
    
    //3. 列子介绍
    PSListModel * exampleModel = [self setListModelWithText:@"列子介绍" type:@2];
    [self.allDataSource  addObject:exampleModel];
    
}

- (PSListModel*)setListModelWithText:(NSString*)text type:(NSNumber*)type
{
    NSDictionary * dict = @{@"text":IsSafeString(text),@"type":type?type:@0};
    PSListModel * listModel = [PSListModel modelWithDictionary:dict];
    return listModel;
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
    
    return HalfF(100);
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentity = @"PSListCellId";
    
    UITableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    
    if (!listCell) {
        listCell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentity];
        listCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    PSListModel * listModel = _allDataSource[indexPath.row];
    listCell.textLabel.text = listModel.text;
    return listCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PSListModel * listModel = _allDataSource[indexPath.row];
    switch (listModel.type.integerValue) {
        case 0:
        {
            PSAppViewController * appVC = NewClass(PSAppViewController);
            [self.navigationController pushViewController:appVC animated:YES];
        }
        break;
        case 1:
        {
            PSClassViewController * classVC = NewClass(PSClassViewController);
            [self.navigationController pushViewController:classVC animated:YES];
        }
        break;
        case 2:
        {
            //手机通讯录 
            PSMobileBookViewController * mobileVC = NewClass(PSMobileBookViewController);
            [self.navigationController pushViewController:mobileVC animated:YES];
            
        }
        break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
