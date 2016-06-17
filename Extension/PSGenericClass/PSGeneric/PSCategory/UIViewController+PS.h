//
//  UIViewController+PS.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/14.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//


#import <UIKit/UIKit.h>

#define iOS7    ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

#define SetViewBackGroundColor(x)   ([self setViewBackGroundColor:x])

#define HideToolbar(x)   ([self hideToolbar:x])

#define HideNavibar(x)   ([self hideNavigationbar:x])

#define SetNaviTitle(x)   ([self setNavigationTitle:x])

#define SetNaviTitleColor(x)   ([self setNavigationTitleColor:x])

#define SetNaviBarckGround(x)   ([self setNaviBarBackgroundImage:x])

#define SetDefaultBackItem(x)   ([self setDefaultBackItem:x])

#define CloseSideslipNaviFun   ([self closeSideslipNavigationFunction])

@interface UIViewController (PS)

/**
 *  设置背景颜色
 *
 *  @param color
 */
- (void)setViewBackGroundColor:(UIColor*)color;

/**
 *   设置导航栏标题
 *
 *  @param title
 */
- (void)setNavigationTitle:(NSString*)title;

/**
 *  自定义导航 titleview
 *
 *  @param titleView
 */
- (void)setNavigationTitleView:(UIView*)titleView;

/**
 *  设置导航标题颜色
 *
 *  @param color
 */
- (void)setNavigationTitleColor:(UIColor *)color;

/**
 *  设置导航的BarTintColor
 *
 *  @param color
 */
- (void)setNaviBarTintColor:(UIColor*)color;

/**
 *  设置Bar背景颜色
 *
 *  @param color
 */
- (void)setNaviBarBackgroundColor:(UIColor*)color;

/**
 *  设置背景颜色
 *
 *  @param image
 */
- (void)setNaviBarBackgroundImage:(NSString*)image;

/**
 *  设置左边按钮
 *
 *  @param item
 */
- (void)setLeftBarButtonItem:(UIBarButtonItem*)item;

/**
 *  设置左边多按钮
 *
 *  @param item
 */
- (void)setLeftBarButtonItems:(NSArray *)items;

/**
 *  设置右边按钮
 *
 *  @param item
 */
- (void)setRightBarButtonItem:(UIBarButtonItem*)item;

/**
 *  设置右边多按钮
 *
 *  @param item
 */
- (void)setRightBarButtonItems:(NSArray *)items;

/**
 *  设置默认返回按钮  （iOS 7 之后）
 *
 *  @param title
 */
- (void)setDefaultBackItem:(NSString*)title;

/**
 *  设置导航栏 返回按钮 io7之前
 *
 *  @param barItem
 */
- (void)setBackBarButtonItem:(UIBarButtonItem *)barItem;

/**
 *  设置左边按钮
 *
 *  @param title
 *  @param target
 *  @param selector
 */
- (void)setLeftBarButtonItemWithTitle: (NSString *)title target: (id)target selector: (SEL)selector;

/**
 *   设置右边按钮
 *
 *  @param title
 *  @param target
 *  @param selector
 */
- (void)setRightBarButtonItemWithTitle: (NSString *)title target: (id)target selector: (SEL)selector;

/**
 *  设置带图片的左边按钮
 *
 *  @param title
 *  @param target
 *  @param selector
 */
- (void)setLeftBarCustomImage:(NSString*)image title:(NSString*)title target:(id)target selector:(SEL)selector;

/**
 *   隐藏toolBar
 *
 *  @param hide
 */
- (void)hideToolbar:(BOOL)hide;

/**
 *  隐藏导航栏
 *
 *  @param hidden
 */
- (void)hideNavigationbar:(BOOL)hidden;

/**
 *  打开 导航侧滑功能 (默认打开)
 */
- (void)openSideslipNavigationFunction;

/**
 *  关闭 导航侧滑功能
 */
- (void)closeSideslipNavigationFunction;

/**
 *  创建一个自身的导航控制器
 *
 *  @return
 */
- (UINavigationController*)createNavigationController;

#pragma mark -TabBarItem-

/**
 *  设置TabBarItem
 *
 *  @param title   名字
 *  @param image   图片
 *  @param selectImage  选中时图片
 */
- (void)setTabBarItem:(NSString*)title image:(NSString*)image selectImage:(NSString*)selectImage;
@end
