//
//  PSBaseViewController.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/4/15.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSBaseViewController.h"

@interface PSBaseViewController ()

@end

@implementation PSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =  RGB(238, 247, 254);
    UIImage * image =  [UIImage imageColor:RGB(32, 177, 232) size:CGSizeMake(SCREEN_WIDTH, 64)];

//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    LogFunctionName();
}
- (void)didReceivedMessage:(NSString *)type msgDispatcher:(PSMsgCenter *)sender userParam:(id)param
{
    PSLog(@"type : %@  sender: %@  param:  %@",type,sender,param);
}

@end
