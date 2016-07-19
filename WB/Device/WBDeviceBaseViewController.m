//
//  WBDeviceBaseViewController.m
//  WB
//
//  Created by leihuiwu on 16/7/19.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "WBDeviceBaseViewController.h"

@interface WBDeviceBaseViewController ()

@property (nonatomic, strong) UIView *viewLine;


@end

@implementation WBDeviceBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
        if (!_viewLine) {
            NSArray *list1 = self.navigationController.navigationBar.subviews;
            for (UIImageView *obj in list1) {
                if ([obj isKindOfClass:[UIImageView class]]) {
                    NSArray *list2 = obj.subviews;
                    for (UIView *obj2 in list2) {
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            _viewLine = obj2;
                        }
                    }
                }
            }
        }
        _viewLine.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
     _viewLine.hidden = NO;
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

@end
