//
//  UIView+PS.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/14.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (PS)
@property (nonatomic,assign)CGFloat x ;
@property (nonatomic,assign)CGFloat y ;
@property (nonatomic,assign)CGFloat width ;
@property (nonatomic,assign)CGFloat height ;
@property (nonatomic,assign)CGFloat centerX ;
@property (nonatomic,assign)CGFloat centerY;
@property (nonatomic,assign)CGPoint origin;
@property (nonatomic,assign)CGSize size;

//Method
- (void)setLayerWithCr:(CGFloat)cornerRadius;
- (void)setBorderWithColor: (UIColor *)color width: (CGFloat)width;
@end
