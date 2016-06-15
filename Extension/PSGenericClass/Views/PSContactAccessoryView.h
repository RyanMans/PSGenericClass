//
//  PSContactAccessoryView.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/9.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSContactAccessoryView : UIView
@property (nonatomic,copy)NSString * waittext;

- (instancetype)initWithSize:(CGSize)size OriginY:(CGFloat)y;
- (void)show;
- (void)disAppear;
@end
