//
//  UIImage+PS.m
//  EJY
//
//  Created by admin on 16/4/6.
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
