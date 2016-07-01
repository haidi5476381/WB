//
//  PersonInfoTableViewCell.h
//  hehenianMobile
//
//  Created by 余海华 on 16/4/7.
//  Copyright © 2016年 huihu. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *KPersonInfoTableViewCell = @"PersonInfoTableViewCell";

typedef void(^TouchSwitchSett)(UISwitch *aSwitch);
typedef void(^TouchSwitchSelect)(UISwitch *aSwitch);
@interface PersonInfoTableViewCell : UITableViewCell
+(PersonInfoTableViewCell *) personInfoTableViewCell;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *touchIdSwitch;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView2;
@property (nonatomic,copy) TouchSwitchSett touchSwitchSett;
@property (nonatomic,copy) TouchSwitchSelect touchSwitchSelect;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headImageView2Constraint;

-(void) updateTitle;
-(void) updateHeadImagView2;
@end
