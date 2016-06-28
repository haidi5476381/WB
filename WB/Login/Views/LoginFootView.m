//
//  LoginFootView.m
//  WB
//
//  Created by 余海华 on 16/6/27.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "LoginFootView.h"

@implementation LoginFootView
+(LoginFootView *) loginFootView {
    
    LoginFootView *view = [[[NSBundle mainBundle] loadNibNamed:@"LoginFootView" owner:self options:nil] objectAtIndex:0];
    view.loginButton.layer.cornerRadius = 5.0f;
    view.loginButton.layer.masksToBounds = YES;
    view.forgetButton.userInteractionEnabled = YES;
    view.registerButton.userInteractionEnabled = YES;
    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
