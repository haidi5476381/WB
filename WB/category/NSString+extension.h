//
//  NSString+extension.h
//  HHNMobileFramework
//
//  Created by huhmf on 15/7/31.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (extension)

/**
 *  for ios7 包含某个字符串
 */
-(BOOL)myContainsString:(NSString*)other;

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 最大尺寸
 *
 *  @return CGSize
 */
-(CGSize)sizeWithfont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  计算文字尺寸
 *
 *  @param attributes 文字的attributes
 *  @param maxSize    最大尺寸
 *
 *  @return CGSize
 */
-(CGSize)sizeWithAttributes:(NSDictionary *)attributes maxSize:(CGSize)maxSize;
@end
