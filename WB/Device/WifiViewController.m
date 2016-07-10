//
//  WifiViewController.m
//  WB
//
//  Created by 余海华 on 16/7/4.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "WifiViewController.h"
#import "ConfigViewController.h"

@interface WifiViewController ()

@end

@implementation WifiViewController

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.configButton.layer.cornerRadius = 5.0f;
    self.configButton.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)config:(id)sender {
    
    ConfigViewController *configVc = [[ConfigViewController alloc] initWithNibName:@"ConfigViewController" bundle:nil];
    [self.navigationController pushViewController:configVc animated:YES];
}
@end
