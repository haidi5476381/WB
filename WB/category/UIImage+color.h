//
//  UIImage+color.h
//  HHNMobileFramework
//
//  Created by huhmf on 15/7/30.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (color)
///< 根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color;

///< 根据颜色、图片大小 生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
///< 根据颜色、图片大小 生成圆角图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius;

@end
