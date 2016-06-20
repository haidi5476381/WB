//
//  HHNUtility.h
//  hehenian-mobile
//
//  Created by huhmf on 15/7/9.
//  Copyright (c) 2015年 huihu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHNUtility : NSObject

+(instancetype)sharedHHNInstance;
/**
 *  从Info.plist中读取字段
 *
 *  @param key 键
 *
 *  @return 值
 */
+ (id)valueInPlistForKey:(NSString *)key;

/**
 *  获取当前网络状态
 */
+ (void)networkStatus;
/**
 *  当前网络是否已经连接
 */
+(BOOL)ConnectionAvailable;

/**
 *  设置HTTP请求的头 包括Cookie等
 */
- (NSDictionary *)setHttpHeaderWithUrl:(NSString *)hostURL Request:(NSMutableURLRequest *)request;

+(void)showTestDescription;
@end

/**
 *##########################
 * Utilities app 信息      #
 *##########################
 */
@interface HHNUtility(app)
/**
 *  获取App版本号, 从plist从读取CFBundleShortVersion
 */
+ (NSString *)appVersion;

/**
 *  获取AppBuild号, 从plist中读取CFBundleVersion
 */
+ (NSString *)appBuild;

/**
 *  初始化appName
 *
 *  @return app name
 */
+ (NSString *)appName;
@end

/**
 *##########################
 * Utilities Device 信息   #
 *##########################
 */
@interface HHNUtility(Device)
/**
 *  获取DeviceVersion, 如iPhone5,2
 */
+ (NSString *)DeviceVersion;

/**
 *  获取设备型号，如iPhone 5s
 */
+ (NSString *)PlatformString;

/**
 *  获取系统名称
 */
+ (NSString *)systemName;
/**
 *  获取系统版本
 */
+ (NSString *)systemVersion;

/**
 *  获取当前设备的 IDFV，IDFV 在某些情况下会变，不建议将其作为设备标识
 */
+ (NSString *)identifierForVendor NS_AVAILABLE_IOS(6_0);

/**
 *  获取当前IP地址
 */
+ (NSString *)ipAddress;
@end

/**
 *##########################
 * Utilities Device 信息   #
 *##########################
 */
@interface HHNUtility(Locale)
/**
 *  本地配置语言
 *
 *  @return NSString
 */
+(NSString *)LocaleLanguage;

/**
 *  本地配置国家
 *
 *  @return NSString
 */
+(NSString *)LocaleCountry;

/**
 *  User-Agent
 *
 *  @return 
 */
-(NSString *) getUserAgent;
@end

