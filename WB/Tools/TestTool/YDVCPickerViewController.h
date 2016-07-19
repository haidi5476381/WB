//
//  YDTestControllerPickerViewController.h
//  YunDiTrip
//
//  Created by 席萍萍 on 16/3/24.
//  Copyright © 2016年 shenzhen yundi technology co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

// 工具类，用此类搜索和选择你想要跳转的控制器

@interface YDVCPickerViewController : UIViewController

/**
 *  获取当前工程内所有带有特定前缀prefix的控制器，在Release模式下该方法失效
 *
 *  @param prefixArray 前缀数组，比如// @[@"YD",@"YDB"]
 */
+ (void)showFinderWithClassPrefix:(NSArray <NSString *> *)prefixArray;

@end
