//
//  SettingItemTableViewCell.h
//  WB
//
//  Created by 余海华 on 16/7/4.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* KSettingItemTableViewCell = @"SettingItemTableViewCell";

@interface SettingItemTableViewCell : UITableViewCell
+(SettingItemTableViewCell *) settingItemTableViewCell;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;

@end
