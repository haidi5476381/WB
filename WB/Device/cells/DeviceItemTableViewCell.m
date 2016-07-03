//
//  DeviceItemTableViewCell.m
//  WB
//
//  Created by deng-HaiDi on 16/7/3.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "DeviceItemTableViewCell.h"

@implementation DeviceItemTableViewCell

+(DeviceItemTableViewCell *) deviceItemTableViewCell {
    
    DeviceItemTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:KDeviceItemTableViewCell owner:self options:nil] objectAtIndex:0];
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
