//
//  PSContactAccessoryView.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/9.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSContactAccessoryView.h"
@interface PSContactAccessoryView()
{
    UILabel * waitLabel;
}
@end
@implementation PSContactAccessoryView
- (instancetype)initWithSize:(CGSize)size OriginY:(CGFloat)y
{
    self = [super initWithFrame:CGRectMake( 0, y, size.width, size.height )];
    if (self) {
        
        self.clipsToBounds = YES;
        self.hidden = YES;
        self.backgroundColor = WhiteColor;
        UIImage * headImage = [UIImage imageNamed:@"search_contact-1"];
        UIImageView * headView = [UIImageView new];
        headView.contentMode = UIViewContentModeScaleToFill;
        headView.image = headImage;
        headView.size = headImage.size;
        headView.y = 90;
        headView.x = (SCREEN_WIDTH - headImage.size.width) / 2;
        [self addSubview:headView];
        
        
        waitLabel = [UILabel new];
        waitLabel.textAlignment = NSTextAlignmentCenter;
        waitLabel.textColor = RGB(102, 102, 102);
        waitLabel.font = FontOfSize(14);
        waitLabel.width = self.width;
        waitLabel.height = 30;
        waitLabel.y = CGRectGetMaxY(headView.frame) + 23;
        waitLabel.x = 0 ;
        waitLabel.text = @"请输入姓名、手机号进行搜索";
        [self addSubview:waitLabel];
        
    }
    return self;
}

- (void)show
{
    self.hidden = NO;
}

- (void)disAppear
{
    self.hidden = YES;
}
- (void)setWaittext:(NSString *)waittext
{
    _waittext = waittext;
    if (waitLabel) {
        waitLabel.text = _waittext;
    }
}



@end
