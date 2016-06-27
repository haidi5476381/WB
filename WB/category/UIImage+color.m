//
//  UIImage+color.m
//  HHNMobileFramework
//
//  Created by huhmf on 15/7/30.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import "UIImage+color.h"

@implementation UIImage (color)
#define kImageWidth  1
#define kImageHeight 1

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [[self class] imageWithColor:color size:CGSizeMake(kImageWidth, kImageHeight)];
}

///< 根据颜色、图片大小 生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // 画图开始
    UIGraphicsBeginImageContext(size);
    // 获取图形设备上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置填充颜色
    CGContextSetFillColorWithColor(context, color.CGColor);
    // 用所设置的填充颜色填充
    CGContextFillRect(context, rect);
    // 得到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 画图结束，解释资源
    UIGraphicsEndImageContext();
    
    return image;
}

///< 根据颜色、图片大小 生成圆角图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius {
    CGFloat width = size.width;
    CGFloat height = size.height;
    // 画图开始
    UIGraphicsBeginImageContext(size);
    
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 移动到初始点
    CGContextMoveToPoint(context, radius, 0);
    
    // 绘制第1条线和第1个1/4圆弧
    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArc(context, width - radius, radius, radius, -0.5 * M_PI, 0.0, 0);
    
    // 绘制第2条线和第2个1/4圆弧
    CGContextAddLineToPoint(context, width, height - radius);
    CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
    
    // 绘制第3条线和第3个1/4圆弧
    CGContextAddLineToPoint(context, radius, height);
    CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
    
    // 绘制第4条线和第4个1/4圆弧
    CGContextAddLineToPoint(context, 0, radius);
    CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
    
    // 闭合路径
    CGContextClosePath(context);
    // 设置填充颜色
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    // 得到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 画图结束，解释资源
    UIGraphicsEndImageContext();
    
    return image;
}

@end
