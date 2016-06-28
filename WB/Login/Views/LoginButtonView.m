//
//  LoginButtonView.m
//  WB
//
//  Created by 余海华 on 16/6/28.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "LoginButtonView.h"

@implementation LoginButtonView
+(LoginButtonView *) loginButtonView{
    
    LoginButtonView *view = [[[NSBundle mainBundle] loadNibNamed:@"LoginButtonView" owner:self options:nil] objectAtIndex:0];
    view.loginButton.layer.cornerRadius = 5.0f;
    view.loginButton.layer.masksToBounds = YES;
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
