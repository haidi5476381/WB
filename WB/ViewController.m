//
//  ViewController.m
//  WB
//
//  Created by 余海华 on 16/6/6.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutLoginViewVc];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void) layoutLoginViewVc {
    
    LoginViewController *loginVc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    [self.view addSubview:loginVc.view];
    [self addChildViewController:loginVc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
