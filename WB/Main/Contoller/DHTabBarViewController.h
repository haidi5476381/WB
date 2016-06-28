//
//  DHTabBarController.h
//  hehenianMobile
//
//  Created by huihu on 15/4/26.
//  Copyright (c) 2015年 huihu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHTabBar.h"

@interface DHTabBarViewController : UITabBarController

/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) DHTabBar *customTabBar;

@end
