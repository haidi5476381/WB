//
//  HHNUtility+Locale.m
//  HHNMobileFramework
//
//  Created by huhmf on 15/8/4.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import "HHNUtility.h"

@implementation HHNUtility (Locale)
/**
 *  本地配置语言
 *
 *  @return NSString
 */
+(NSString *)LocaleLanguage{
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray objectAtIndex:0];
}

/**
 *  本地配置国家
 *
 *  @return NSString
 */
+(NSString *)LocaleCountry{
    NSLocale *locale = [NSLocale currentLocale];
    return [locale localeIdentifier];
}
@end
