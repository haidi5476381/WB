//
//  ActionTableViewCell.m
//  WB
//
//  Created by deng-HaiDi on 16/7/15.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "ActionTableViewCell.h"

@implementation ActionTableViewCell

+(ActionTableViewCell *) actionTableViewCell {
    
    
    ActionTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:KActionTableViewCell owner:self options:nil] objectAtIndex:0];
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
