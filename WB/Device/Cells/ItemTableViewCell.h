//
//  ItemTableViewCell.h
//  WB
//
//  Created by 余海华 on 16/7/4.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * KItemTableViewCell = @"ItemTableViewCell";

@interface ItemTableViewCell : UITableViewCell

+(ItemTableViewCell *) itemTableViewCell;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemSubTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemStatuImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@end
