//
//  PSIntroduceCell.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/8.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSIntroduceModel.h"
@interface PSIntroduceCell : UITableViewCell
@property (nonatomic,strong)PSIntroduceModel * introduceModel;
+ (PSIntroduceCell*)cellWithTableView:(UITableView*)tableView;
+ (CGFloat) cellHeight;
@end
