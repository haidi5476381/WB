//
//  SettingItemTableViewCell.m
//  WB
//
//  Created by 余海华 on 16/7/4.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "SettingItemTableViewCell.h"

@implementation SettingItemTableViewCell
+(SettingItemTableViewCell *) settingItemTableViewCell{
    
    SettingItemTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:KSettingItemTableViewCell owner:self options:nil] objectAtIndex:0];
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
