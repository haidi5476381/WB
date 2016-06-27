//
//  UIBarButtonItem+Extension.h
//
//  Created by apple on 14-5-6.
//  Copyright (c) 2014年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  快速创建一个显示图片的item
 *
 *  @param action   监听方法
 */
+(UIBarButtonItem *)itemWithImageName:(NSString *)ImageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
@end
