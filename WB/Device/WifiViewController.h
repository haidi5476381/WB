//
//  WifiViewController.h
//  WB
//
//  Created by 余海华 on 16/7/4.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "BaseViewController.h"

@interface WifiViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *wifiNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *configButton;
- (IBAction)config:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *wifiPasswordTextField;
@end
