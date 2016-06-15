//
//  PSNavigationController.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/4/15.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSNavigationController.h"
#define UseCustomType  0 //push 动画采用自定义时，开启手势代理

@interface PSNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation PSNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //设置标题
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor],NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar  appearance] setBarTintColor:NavigationBarBGColor];
    [[UINavigationBar  appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar  appearance] setTintColor:WhiteColor];
//    [[UINavigationBar  appearance] setTranslucent:NO];
    
#if UseCustomType
    // 设置手势识别器的代理
    self.interactivePopGestureRecognizer.delegate = self;
#endif
    
    
    //去除bar底部黑线
    for (UIView * subView in self.navigationBar.subviews)
    {
        for (UIView * child in subView.subviews)
        {
            if (IsKindOfClass(child, UIImageView))
            {
                child.backgroundColor = ClearColor;
                [child removeFromSuperview];
                break;
            }
        }
    }
    
}

#pragma mark -拦截所有PUSH进来的控制器-
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    //add by sam
    [viewController openSideslipNavigationFunction];
    
    if (self.viewControllers.count>0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
#if 0
        //设置导航返回按钮 一般用于自定义按钮 ，全局的
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(backPress:)];
        item.tintColor = [UIColor whiteColor];
        viewController.navigationItem.leftBarButtonItem = item;
#endif
        
    }
    [super pushViewController:viewController animated:animated];
    
}

-(void)backPress:(UIBarButtonItem*)sender
{
    [self popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return(UIStatusBarStyleLightContent);
}

- (BOOL)shouldAutorotate {
    return NO;
}

#pragma mark -设置手势代理-
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}


@end
