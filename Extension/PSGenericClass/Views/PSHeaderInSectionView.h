//
//  PSHeaderInSectionView.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/9.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSHeaderInSectionView : UIView
@property (nonatomic,copy)NSString * text ;
@property (nonatomic,strong)UIColor * textColor;
@property (nonatomic,strong)UIFont * textFont ;
@property (nonatomic,assign)NSInteger flag;
@property (nonatomic,assign)CGFloat leftInsetsX;
@property (nonatomic,assign)CGFloat textHeight;
+ (PSHeaderInSectionView*)viewForHeaderInSectionH:(CGFloat)height;
@end
