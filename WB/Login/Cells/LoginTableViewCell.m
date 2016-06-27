//
//  LoginTableViewCell.m
//  hehenianMobile
//
//  Created by 余海华 on 16/4/14.
//  Copyright © 2016年 huihu. All rights reserved.
//

#import "LoginTableViewCell.h"

@implementation LoginTableViewCell

+(LoginTableViewCell *) loginTableViewCell {
    
    LoginTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:KLoginTableViewCell owner:self options:nil] objectAtIndex:0];
    cell.yanCodeButton.backgroundColor = IWColor(243, 209, 155);
    [cell.yanCodeButton setTitleEdgeInsets:UIEdgeInsetsMake(0,5,0 , 5)];
    cell.yanCodeButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.yanCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    cell.yanCodeButton.layer.cornerRadius = 5.0f;
    cell.yanCodeButton.titleLabel.textColor = IWColor(81, 80, 80);
    cell.yanCodeButton.hidden = YES;
    [cell.yanCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    cell.titleLabel.textColor = IWColor(99, 99, 99);
    cell.titleContextTextField.textColor = [UIColor blackColor];
    cell.imageCodeImageView.hidden = YES;
    cell.imageCodeImageView.userInteractionEnabled = YES;
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    backView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = backView;
    return cell;
}





-(void) textFieldChange:(UITextField *) textField {
    
    
    self.textFieldBlock(textField);
    
    
}



-(void) setBlock:(SettingBlock)block {
    
    _block = block;
    [self.titleContextTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    self.block(self.titleContextTextField);
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
