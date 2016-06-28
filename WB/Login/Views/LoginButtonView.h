//
//  LoginButtonView.h
//  WB
//
//  Created by 余海华 on 16/6/28.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginButtonView : UIView
+(LoginButtonView *) loginButtonView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
