//
//  UIViewController+PS.m
//  aaa
//
//  Created by ibos on 16/2/26.
//  Copyright © 2016年 ibos. All rights reserved.
//

#import "UIViewController+PS.h"

@implementation UIViewController (PS)

- (void)setViewBackGroundColor:(UIColor *)color
{
    self.view.backgroundColor = color;
}
#pragma mark -导航-
- (void)setNavigationTitle:(NSString *)title
{
    if (title == nil || title.length == 0) return;
    self.navigationItem.title = title;
}

- (void)setNavigationTitleView:(UIView *)titleView
{
    self.navigationItem.titleView = titleView;
}

- (void)setNavigationTitleColor:(UIColor *)color
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName,nil]];
    
}

- (void)setNaviBarTintColor:(UIColor *)color
{
    [self.navigationController.navigationBar setBarTintColor:color];
}

- (void)setNaviBarBackgroundColor:(UIColor *)color
{
    [self.navigationController.navigationBar setBackgroundColor:color];
}

- (void)setNaviBarBackgroundImage:(NSString *)image
{
    if (image.length == 0 || image == nil)return;
    UIImage * backgroundImage = [UIImage imageNamed:image];
    if (iOS7)
    {
        backgroundImage = [backgroundImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    }
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:(UIBarMetricsDefault)];
    
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)item
{
    [self.navigationItem setLeftBarButtonItem:item];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)item
{
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)setLeftBarButtonItems:(NSArray *)items
{
    [self.navigationItem setLeftBarButtonItems:items];
}

- (void)setRightBarButtonItems:(NSArray *)items
{
    [self.navigationItem setRightBarButtonItems:items];
}

- (void)setDefaultBackItem:(NSString *)title
{
    if (iOS7)
    {
        UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = title;
        self.navigationItem.backBarButtonItem = returnButtonItem;
    }
}
- (void)setBackBarButtonItem:(UIBarButtonItem *)barItem
{
    if (!iOS7)
    {
        [self.navigationItem setBackBarButtonItem:barItem];
    }
}

- (void)setLeftBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:selector];
    [self setLeftBarButtonItem:btn];
}

- (void)setRightBarButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:selector];
    [self setRightBarButtonItem:btn];
}

- (void)setLeftBarCustomImage:(NSString *)image title:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIButton * button= [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:0];
    UIImage * btnImg  = [UIImage imageNamed:image];
    if (iOS7) {
        btnImg = [btnImg imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    }
    [button setImage:btnImg forState:0];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button.frame = CGRectMake(-20, 0, 64, 64);
    UIBarButtonItem *  leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    if((iOS7?20:0))
    {
        // 7.0 系统之后
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -15;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftButtonItem];
    }
    else{
        
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    }
    
}

- (void)hideToolbar:(BOOL)hide
{
    self.navigationController.toolbar.hidden = hide;
}

- (void)hideNavigationbar:(BOOL)hidden
{
    self.navigationController.navigationBar.hidden = hidden;
}

- (void)openSideslipNavigationFunction
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)closeSideslipNavigationFunction
{
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (UINavigationController*)createNavigationController
{
    return [[UINavigationController alloc] initWithRootViewController:self];
}

#pragma mark -UITabBarItem-
- (void)setTabBarItem:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    if (title != nil && title.length != 0)
    {
        self.tabBarItem.title = title;
    }
    UIImage * img;
    UIImage * selectImg;
    
    if (image != nil && image.length !=0)
    {
        img = [UIImage imageNamed:image];
    }
    if (selectImage != nil && selectImage.length != 0)
    {
        selectImg = [UIImage imageNamed:selectImage];
    }
    
    if (iOS7)
    {
        img = [img imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        selectImg = [selectImg imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    }
    self.tabBarItem.image = img;
    self.tabBarItem.selectedImage = selectImg;
    
}
@end
