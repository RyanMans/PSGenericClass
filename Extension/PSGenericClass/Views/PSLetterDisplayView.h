//
//  PSLetterDisplayView.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/9.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSLetterDisplayView : UIView
+ (PSLetterDisplayView * )letterDisplayWithCenter:(CGPoint)center;
- (void)animationsLetterDisplay:(NSString*)letter;

@end
