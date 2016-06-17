//
//  PSBaseViewController.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/4/15.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSBaseModel.h"

/**
 *  作为整个app 控制器的一个基类，所有新创建的控制器须继承该类。所有特殊变化，在当前控制器再自定义修改。 
    此类 主要 是管理整个项目 的 控制器 基本的UI样式 以及 事件响应
 */
@interface PSBaseViewController : UIViewController<PSMsgDispatcherDelegate>

@end



