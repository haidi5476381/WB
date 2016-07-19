//
//  DHNavigationViewController.m
//  hehenianMobile
//
//  Created by huihu on 15/4/26.
//  Copyright (c) 2015年 huihu. All rights reserved.
//

#import "DHNavigationViewController.h"
#import "AppDelegate.h"
#import "UIBarButtonItem+Extension.h"
#import "UIImage+color.h"

@interface DHNavigationViewController ()

@end

@implementation DHNavigationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    //如果现在push的不是栈顶控制器，那么久隐藏tabbar工具条
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
        
        viewController.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
        //拦截push操作，设置导航栏的左上角和右上角按钮
        //viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
        viewController.navigationItem.rightBarButtonItem=nil;
        
       viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImageName:@"navbar_btn_Back" highImageName:@"navbar_btn_Back" target:self action:@selector(back:)];

        
    }
    [super pushViewController:viewController animated:YES];
}


-(void)back:(id)sender
{
    [self popViewControllerAnimated:YES];
}

-(void)more
{
    [self popToRootViewControllerAnimated:YES];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    

    UIColor *barColor = IWColor(0, 177.0, 255.0);
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:barColor] forBarMetrics:UIBarMetricsDefault];
    //设置导航默认标题的颜色及字体大小
    
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                         NSForegroundColorAttributeName:[UIColor blackColor]};
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

@end
