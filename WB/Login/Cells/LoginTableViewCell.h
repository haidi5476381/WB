//
//  LoginTableViewCell.h
//  hehenianMobile
//
//  Created by 余海华 on 16/4/14.
//  Copyright © 2016年 huihu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerButton.h"

static NSString *KLoginTableViewCell = @"LoginTableViewCell";
typedef  void(^SettingBlock)(UITextField *textField);
typedef void(^TextFieldBlock)(UITextField *contextField);
typedef void (^ImageViewBlock)(UIImageView *imageView);
@interface LoginTableViewCell : UITableViewCell
+(LoginTableViewCell *) loginTableViewCell;
@property (nonatomic,copy) SettingBlock block;
@property (nonatomic,copy) TextFieldBlock textFieldBlock;
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleContextTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet TimerButton *yanCodeButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageCodeImageView;
@end
