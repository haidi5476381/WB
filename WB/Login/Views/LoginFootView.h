//
//  LoginFootView.h
//  WB
//
//  Created by 余海华 on 16/6/27.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginFootView : UIView

+(LoginFootView *) loginFootView;
@property (weak, nonatomic) IBOutlet UIButton *rememberButton;
@property (weak, nonatomic) IBOutlet UIButton *autoButton;
@property (weak, nonatomic) IBOutlet UILabel *registerButton;
@property (weak, nonatomic) IBOutlet UILabel *forgetButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end
