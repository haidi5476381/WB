//
//  PersonInfoTableViewCell.m
//  hehenianMobile
//
//  Created by 余海华 on 16/4/7.
//  Copyright © 2016年 huihu. All rights reserved.
//

#import "PersonInfoTableViewCell.h"

@implementation PersonInfoTableViewCell


+(PersonInfoTableViewCell *) personInfoTableViewCell {
    
    PersonInfoTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:KPersonInfoTableViewCell owner:self options:nil] objectAtIndex:0];
    cell.bottomLineView.backgroundColor = IWColor(220, 220, 220);
    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    cell.titleLabel.textColor = IWColor(84, 66, 54);
    cell.titleLabel.font = [UIFont systemFontOfSize:16];
    cell.detailLabel.textColor=  IWColor(193, 192, 192);
    cell.detailLabel.font = [UIFont systemFontOfSize:16];
    cell.subTitleLabel.textColor = IWColor(153, 153, 153);
    cell.subTitleLabel.font = [UIFont systemFontOfSize:16];
    cell.autoresizesSubviews = YES;
    cell.touchIdSwitch.hidden = YES;
    cell.headImageView2.hidden = YES;
    cell.headImageView2.layer.cornerRadius = 20.0f;
    cell.headImageView2.layer.masksToBounds = YES;
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}


-(void) setTouchSwitchSett:(TouchSwitchSett)touchSwitchSett {
    
    _touchSwitchSett = touchSwitchSett;
    _touchSwitchSett(self.touchIdSwitch);
    [self.touchIdSwitch addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
 
}

-(void) updateTitle {
    self.titleConstraint.constant = 10;
    [self.titleLabel updateConstraints];
}

-(void) updateHeadImagView2 {
    
    self.headImageView2Constraint.constant = 70;
    [self.headImageView2 updateConstraints];
}

-(void) valueChange:(UISwitch *) aSwitch {
    
    self.touchSwitchSelect(aSwitch);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
