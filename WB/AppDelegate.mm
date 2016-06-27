//
//  AppDelegate.m
//  WB
//
//  Created by 余海华 on 16/6/6.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "AppDelegate.h"
#import <YTKNetwork/YTKNetworkConfig.h>
#import "YTKUrlArgumentsFilter.h"
#import "DHNavigationViewController.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupRequestFilters];
  
    ViewController *vc = [[ViewController alloc] init];
    DHNavigationViewController *navVc = [[DHNavigationViewController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navVc;
    return YES;
}


/**
 *  设置请求配置
 */
- (void)setupRequestFilters {
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    YTKUrlArgumentsFilter *urlFilter = [YTKUrlArgumentsFilter filterWithArguments:@{@"platform":@"ios",@"appVersion": [HHNUtility appVersion]}];
    [config addUrlFilter:urlFilter];
    config.baseUrl= @"http://api.easylink.io";//所有的网络请求都会默认使用 YTKNetworkConfig 中baseUrl参数指定的地址
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
