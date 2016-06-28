//
//  DHTabBar.h
//  hehenianMobile
//
//  Created by huihu on 15/4/26.
//  Copyright (c) 2015年 huihu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHTabBar;

@protocol DHTabBarDelegate <NSObject>

@optional
- (void)tabBar:(DHTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
//- (void)tabBarDidClickedPlusButton:(DHTabBar *)tabBar;

@end

@interface DHTabBar : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<DHTabBarDelegate> delegate;


@end
