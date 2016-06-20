//
//  NSString+extension.m
//  HHNMobileFramework
//
//  Created by huhmf on 15/7/31.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import "NSString+extension.h"

@implementation NSString (extension)

- (BOOL)myContainsString:(NSString*)other {
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0){
    return [self containsString:other];
    }
    else{
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
    }
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 最大尺寸
 *
 *  @return CGSize
 */
-(CGSize)sizeWithfont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attributes = @{NSFontAttributeName:font};//文字的字体
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;//文字的尺寸
}

/**
 *  计算文字尺寸
 *
 *  @param attributes 文字的attributes
 *  @param maxSize    最大尺寸
 *
 *  @return CGSize
 */
-(CGSize)sizeWithAttributes:(NSDictionary *)attributes maxSize:(CGSize)maxSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;//文字的尺寸
}
@end
