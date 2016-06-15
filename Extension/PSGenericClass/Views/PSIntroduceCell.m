//
//  PSIntroduceCell.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/8.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSIntroduceCell.h"
#define Cell_Row_Height 70

@interface PSIntroduceCell ()
{
    UILabel * _textLabel;
    
    UILabel * _detailTextLabel;
    
}
@end
@implementation PSIntroduceCell
+ (PSIntroduceCell*)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellIdentity = @"PSIntroduceCellID";
    
    PSIntroduceCell * appCell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!appCell) {
        appCell = [[PSIntroduceCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentity];
    }
    return appCell;
}
+ (CGFloat)cellHeight
{
    return Cell_Row_Height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _textLabel = NewClass(UILabel);
        _textLabel.x = HalfF(30);
        _textLabel.y = HalfF(20);
        _textLabel.height = HalfF(34);
        _textLabel.width = SCREEN_WIDTH - 2 * _textLabel.x;
        _textLabel.textColor = RedColor;
        _textLabel.font = FontOfSize(15);
        _textLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_textLabel];
        
        _detailTextLabel = NewClass(UILabel);
        _detailTextLabel.x = _textLabel.x;
        _detailTextLabel.y = CGRectGetMaxY(_textLabel.frame) + HalfF(12);
        _detailTextLabel.width = _textLabel.width;
        _detailTextLabel.height = HalfF(30);
        _detailTextLabel.font = FontOfSize(13);
        _detailTextLabel.textColor = RGB(102, 102, 102);
        _detailTextLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_detailTextLabel];
        
        
    }
    return self;
}
- (void)setIntroduceModel:(PSIntroduceModel *)introduceModel
{
    _introduceModel = introduceModel;
    
    _textLabel.text = _introduceModel.text;
    
    NSDictionary * attributeDict = @{NSForegroundColorAttributeName:RGB(32,177,232)};
    NSString * detailText = [NSString stringWithFormat:@"%@(见详细类库 注释)",_introduceModel.detailText];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:detailText];
    [string setAttributes:attributeDict range:[detailText rangeOfString:@"(见详细类库 注释)"]];
    
    _detailTextLabel.attributedText = string;

}
@end
