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
    self.tipLabel.numberOfLines = 0;

    self.tipLabel.text =  @"接通电源，长按设备按键，直到指示灯处于红灯快状态";

    if (self.tag == 1) {
        self.tipBigImageView.image = [UIImage imageNamed:@"banner_img_socket"];
    }else{
        
        
    }
    self.tipImageView.layer.cornerRadius = 5.0f;
    self.tipImageView.layer.masksToBounds = YES;
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
