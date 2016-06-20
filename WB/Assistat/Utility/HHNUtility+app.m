//
//  HHNUtility+app.m
//  HHNMobileFramework
//
//  Created by huhmf on 15/8/4.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import "HHNUtility.h"

@implementation HHNUtility (app)
/**
 *  获取App版本号, 从plist从读取CFBundleShortVersion
 */
+ (NSString *)appVersion
{
   return [self valueInPlistForKey:@"CFBundleShortVersionString"];
}

/**
 *  获取AppBuild号, 从plist中读取CFBundleVersion
 */
+ (NSString *)appBuild{
  return [self valueInPlistForKey:(NSString *)kCFBundleVersionKey];
}

/**
 *  初始化appName
 *
 *  @return app name
 */
+ (NSString *)appName{
   return [self valueInPlistForKey:@"CFBundleDisplayName"];
}
@end
