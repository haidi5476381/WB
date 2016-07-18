//
//  ActionTableViewCell.h
//  WB
//
//  Created by deng-HaiDi on 16/7/15.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *KActionTableViewCell = @"ActionTableViewCell";

@interface ActionTableViewCell : UITableViewCell

+(ActionTableViewCell *) actionTableViewCell;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (weak, nonatomic) IBOutlet UILabel *selectTitleLabel;
@end
