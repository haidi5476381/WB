//
//  DeviceItemTableViewCell.h
//  WB
//
//  Created by deng-HaiDi on 16/7/3.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *KDeviceItemTableViewCell = @"DeviceItemTableViewCell";
@interface DeviceItemTableViewCell : UITableViewCell

+(DeviceItemTableViewCell *) deviceItemTableViewCell;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;

@end
