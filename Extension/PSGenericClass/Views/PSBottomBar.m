//
//  PSBottomBar.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/14.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSBottomBar.h"

@implementation PSBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        
        UIButton * originalButton = [self instanceButton];
        originalButton.backgroundColor = [UIColor orangeColor];
        originalButton.x = 0;
        originalButton.tag = BottomBarType_Original;
        [originalButton setTitle:@"导航恢复原样" forState:(UIControlStateNormal)];
        [self addSubview:originalButton];
        
        UIButton * upButton = [self instanceButton];
        upButton.tag = BottomBarType_Up;
        upButton.backgroundColor = NavigationBarBGColor;
        upButton.x = CGRectGetMaxX(originalButton.frame);
        [upButton setTitle:@"导航上移" forState:(UIControlStateNormal)];
        [self addSubview:upButton];
    }
    return self;
}
- (UIButton*)instanceButton
{
    UIButton * customButton = NewButton();
    customButton.userInteractionEnabled = YES;
    customButton.y = 0;
    customButton.size = CGSizeMake(self.width / 2, self.height);
    [customButton setTitleColor:WhiteColor forState:(UIControlStateNormal)];
    [customButton addTarget:self action:@selector(clickEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return customButton;
}
- (void)clickEvent:(UIButton*)sender
{
    if (self.block) {
        _block ((BottomBarType)sender.tag);
    }
}
@end
