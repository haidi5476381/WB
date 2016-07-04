//
//  YaokongViewController.m
//  WB
//
//  Created by 余海华 on 16/7/4.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "YaokongViewController.h"
#import "WifiViewController.h"

@interface YaokongViewController ()

@end

@implementation YaokongViewController

-(void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)nextButton:(id)sender {
    
    WifiViewController *wifiVc = [[WifiViewController alloc] initWithNibName:@"WifiViewController" bundle:nil];
    [self.navigationController pushViewController:wifiVc animated:YES];
}
@end
