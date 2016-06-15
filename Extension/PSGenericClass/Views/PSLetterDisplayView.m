//
//  PSLetterDisplayView.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/9.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSLetterDisplayView.h"
@interface PSLetterDisplayView ()
{
    UILabel * _letterLabel;
}
@end
@implementation PSLetterDisplayView
+ (PSLetterDisplayView *)letterDisplayWithCenter:(CGPoint)center
{
    PSLetterDisplayView * letterView  = [[PSLetterDisplayView alloc] initWithFrame:CGRectMake(0, 0, HalfF(100), HalfF(100))];
    letterView.center = center;
    return letterView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.hidden = YES;
        
        _letterLabel = [UILabel new];
        _letterLabel.frame = self.bounds;
        _letterLabel.textColor = WhiteColor;
        _letterLabel.textAlignment = NSTextAlignmentCenter;
        _letterLabel.backgroundColor = ClearColor;
        [self addSubview:_letterLabel];
        
    }
    return self;
}
- (void)animationsLetterDisplay:(NSString*)letter
{
    self.hidden = NO;
    _letterLabel.text = letter;
    [UIView beginAnimations:@"LetterDisplayView" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.alpha = 1.0;
    self.alpha = 0.0;
    [UIView commitAnimations];
}

@end
