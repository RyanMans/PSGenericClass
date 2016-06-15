//
//  PSTabBarController.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/4/15.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSTabBarController.h"
#import "PSNavigationController.h"

#import "PSlistViewController.h"
#import "PSContactViewController.h"
#import "PSAppViewController.h"
@interface PSTabBarController ()
@property (nonatomic,weak)PSlistViewController * listVC;
@property (nonatomic,weak)PSContactViewController * secondVC;
@property (nonatomic,weak)PSAppViewController * thirdVC;
@end

@implementation PSTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PSlistViewController * listVC = NewClass(PSlistViewController);
    [self addChildVC:listVC WithTitle:@"首页" WithImageName:@"tabbar_item_msg" WithSelectedImageName:@"tabbar_item_msg"];
    self.listVC = listVC;
    self.listVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:(UITabBarSystemItemBookmarks) tag:0];
    
/*
    PSContactViewController * vc = [[PSContactViewController alloc] init];
    [self addChildVC:vc WithTitle:@"联系人" WithImageName:@"tabbar_item_contact" WithSelectedImageName:@"tabbar_item_contact2"];
    self.secondVC = vc;
    
    
    PSAppViewController * appVC = [[PSAppViewController alloc] init]; 
    [self addChildVC:appVC WithTitle:@"应用" WithImageName:@"tabbar_item_app" WithSelectedImageName:@"tabbar_item_app2"];
    self.thirdVC = appVC;
    
  */
}

/**
 *  添加子控制器
 */
-(void)addChildVC:(UIViewController*)childVC WithTitle:(NSString*)title WithImageName:(NSString*)imageName WithSelectedImageName:(NSString*)selectedImageName
{
    LogFunctionName();
    //标题
    childVC.title = title;
    
    //图片
    childVC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    childVC.tabBarItem.selectedImage = selectedImage;
    
    //基类导航
    PSNavigationController * navigationVC = [[PSNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:navigationVC];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
