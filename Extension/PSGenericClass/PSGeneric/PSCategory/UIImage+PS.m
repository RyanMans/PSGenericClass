//
//  UIImage+PS.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/14.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "UIImage+PS.h"

@implementation UIImage (PS)
+ (UIImage*)imageColor:(UIColor*)color size:(CGSize)size
{
    CGRect rect = (CGRect){{0 ,0},size};
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
