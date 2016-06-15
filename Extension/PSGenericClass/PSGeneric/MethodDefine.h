//
//  MethodDefine.h
//  aaa
//
//  Created by ibos on 16/2/26.
//  Copyright © 2016年 ibos. All rights reserved.
//

#ifndef MethodDefine_h
#define MethodDefine_h

// 方法宏
#define IsHasSelector(x)         [x respondsToSelector:selector]
#define IsSubclassOfClass(x, y)  [x isSubclassOfClass: [y class]]
#define IsKindOfClass(x, y)      [x isKindOfClass:[y class]]
#define IsMemberOfClass(x, y)    [x isMemberOfClass:[y class]]
#define IsRangeOfString(x, y)    ([x rangeOfString:y].length)
#define IsSafeString(x)          ((x != nil && x.length != 0)? x : @"")
#define IsSameString(x, y)       ([x isEqualToString:y])


// 计算文本 size
#define HalfF(x) ((x)/2.0f)
#define SizeWithAttributes(t,f)      [t sizeWithAttributes:@{NSFontAttributeName:f}]

#define BoundingRectWithSize(t,s,f)  [t boundingRectWithSize:s options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:f} context:nil]


//  打印方法名
#define LogFunctionName()  NSLog(@"%s",__func__);

// 初始设置宏
#define MinMutableCount 4UL

// 简写宏
#define CopyAsWeak(x, y)    __weak typeof(x) y = x
#define WeakSelf(x)         __weak typeof (self) x = self

#define WEAKESELF        __weak __typeof(self) weakSelf = self;
#define STRONGSELF       __strong __typeof(weakSelf)strongSelf = weakSelf;
#define ClassName(x)     NSStringFromClass([x class])


#define NewRectButton() [UIButton buttonWithType:UIButtonTypeRoundedRect]
#define NewButton() [UIButton buttonWithType:UIButtonTypeCustom]
#define NewClass(x) [[x alloc] init]
#define NewMutableArray() [NSMutableArray arrayWithCapacity:MinMutableCount]
#define NewMutableDictionary() [NSMutableDictionary dictionaryWithCapacity:MinMutableCount]

// 颜色宏

// 获取RGB颜色
#define RGBA(r,g,b,a)        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)           RGBA(r,g,b,1.0f)
#define Arc4randomColor      RGBA(arc4random() % 256,arc4random() % 256,arc4random() % 256,1.0f)  //获取随机色

#define HEXCOLOR(rgbValue)   HEXCOLORAlpha(rgbValue, 1.0)

#define HEXCOLORAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]



//颜色16进制用法
#define Color_eaeaea  HEXCOLOR(0xEAEAEA) // 分割线
#define Color_b3b3b3  HEXCOLOR(0xB3B3B3)
#define Color_21b3e9  HEXCOLOR(0x21B3E9) //高亮篮


#define ClearColor [UIColor clearColor]
#define WhiteColor [UIColor whiteColor]
#define BlackColor [UIColor blackColor]
#define RedColor   [UIColor redColor]
#define BlueColor  [UIColor blueColor]
#define GreenColor [UIColor greenColor]
#define GrayColor  [UIColor grayColor]

#define NavigationBarBGColor  RGB(32,177,232)

//获取屏幕 宽度、高度 statusbar 高度
#define SCREEN_SCALE    [UIScreen mainScreen].scale
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)
#define Statur_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVIBAR_HEIGHT  (self.navigationController.navigationBar.frame.size.height)
#define TabBarHeight    (self.tabBarController.tabBar.frame.size.height)
#define INVALID_VIEW_HEIGHT (Statur_HEIGHT + NAVIBAR_HEIGHT)

/**
 *  可用高度
 */
#define VALID_VIEW_HEIGHT (SCREEN_HEIGHT - INVALID_VIEW_HEIGHT)


// 字体宏
#define FontOfSize(x)   [UIFont systemFontOfSize:x]


// 线程宏
#define IsMainThread()     [NSThread isMainThread]
#define GCDBackgroundQueue  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
#define GCDDefaultQueue    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define GCDHighQueue    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
#define GCDMainQueue    dispatch_get_main_queue()
#define MinSleep()     [NSThread sleepForTimeInterval:0.01]






//
#define ApplicationKeyWindow  [[UIApplication sharedApplication] keyWindow]
//展现在窗口的loading
#define ShowKWWaitProgress()  runBlockWithMain(^{[MBProgressHUD showHUDAddedTo:ApplicationKeyWindow animated:NO];})
#define HideKWWaitProgress()  runBlockWithMain(^{[MBProgressHUD hideAllHUDsForView:ApplicationKeyWindow animated:NO];})

//展现在控制器的loading
#define ShowWaitProgress() runBlockWithMain(^{[MBProgressHUD showHUDAddedTo:self.view animated:NO];})
#define HideWaitProgress() runBlockWithMain(^{[MBProgressHUD hideAllHUDsForView:self.view animated:YES];})

#endif /* MethodDefine_h */
