//
//  DHTabBarController.m
//  hehenianMobile
//
//  Created by huihu on 15/4/26.
//  Copyright (c) 2015年 huihu. All rights reserved.
//

#import "DHTabBarViewController.h"
#import "DHTabBar.h"
#import "AppDelegate.h"
#import "DHNavigationViewController.h"
#import "DHTabBarButton.h"
#import "DevicesViewController.h"
#import "SettingViewController.h"
#import "AboutViewController.h"
#import "LoginViewController.h"
#import "UIImage+MJ.h"
#import "AppDelegate.h"

@interface DHTabBarViewController() <DHTabBarDelegate>
@property (nonatomic,strong) DevicesViewController *deviceVc;
@property (nonatomic,strong) SettingViewController *settingVc;
@property (nonatomic, strong) AboutViewController *aboutVc;

@end

@implementation DHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backHome:) name:@"backHome" object:nil];
    
    // 初始化tabbar
    [self setupTabbar];
    [self setupLogin];
    // 初始化所有的子控制器
    //    [self setupAllChildViewControllers];
}

-(void)setupLogin {
    
    LoginViewController *loginVc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.view.window.rootViewController presentViewController:loginVc animated:YES completion:nil];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


/**
 *  使用popToViewController导致的UITabBarButton重叠的问题
 *
 */
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    for (UIView *child in self.tabBar.subviews) {
        
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [child removeFromSuperview];
        }
    }
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"backHome" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  返回首页
 */
-(void)backHome:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.selectedIndex = 0;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}


/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    
    DHTabBar *customTabBar = [[DHTabBar alloc] init];
    customTabBar.frame =self.tabBar.bounds;
    customTabBar.delegate = self;
    
    CGRect rect=customTabBar.frame;
    rect.size.height=TabbarHeight;
    rect.origin.y-=TabbarHeight-50;
    customTabBar.frame=rect;
    
    [self.tabBar setShadowImage:[UIImage new]];//设置shadowimage 为一张空图片
    self.tabBar.backgroundImage=[UIImage imageNamed:@"home_bottom"];
    [self.tabBar addSubview:customTabBar];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, -1, rect.size.width, 1)];
    topView.backgroundColor = [UIColor colorWithRed:((float)((0xdcdcdc & 0xFF0000) >> 16))/255.0 green:((float)((0xdcdcdc & 0xFF00) >> 8))/255.0 blue:((float)(0xdcdcdc & 0xFF))/255.0 alpha:0.5];
    [self.tabBar addSubview:topView];
    
    self.customTabBar = customTabBar;
    
}
#pragma mark - tabbar的代理方法
/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(DHTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
    
    //        //[self.HomePageVC refresh];
    //    }else
    if(to==1)
    {
    }else if(to==2)
    {//更多
        
    }else if (to == 3) {
        
    }
    
    
}
#pragma mark 实现委托LoginViewControllerDelegate
-(void)loginViewLoginSucceed:(LoginViewController *)loginView
{
    NSNumber *login_tag=[NSNumber numberWithInteger:loginView.view.tag];
    //登录成功,
    NSDictionary *dict=@{@"index":login_tag};
    //创建  发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"itemSelected" object:nil userInfo:dict];
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) loginViewDidDisappear:(LoginViewController *)loginView {
    
    [self.tabBarController setSelectedIndex:0];
    //登录成功,
    NSDictionary *dict=@{@"index":@"0"};
    //创建  发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"itemSelected" object:nil userInfo:dict];
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    
    
    DevicesViewController *HomePageVC = [[DevicesViewController alloc] initWithNibName:@"DevicesViewController" bundle:nil];
    [self setupChildViewController:HomePageVC title:@"设备" imageName:@"tab_home_normal" selectedImageName:@"tab_home_sel"];
    self.deviceVc = HomePageVC;
    
    SettingViewController *baoVc = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    [self setupChildViewController:baoVc title:@"设置" imageName:@"shop_normal" selectedImageName:@"shop_select"];
    self.settingVc = baoVc;
    
    
    AboutViewController *assistantVc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    [self setupChildViewController:assistantVc title:@"关于" imageName:@"tab_help_nor" selectedImageName:@"tab_help_sel"];
    self.aboutVc = assistantVc;
    
    
    
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (iOS7_OR_LATER) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    DHNavigationViewController *nav = [[DHNavigationViewController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

@end
