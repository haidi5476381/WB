//
//  Constant.h
//  WB
//
//  Created by 余海华 on 16/6/6.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#ifndef Constant_h
#define Constant_h


/**
 *  登录用的block
 */
typedef void(^KCancelBlock)(void);
typedef void (^KSuccessBlock)(void);
typedef void (^KFaileBlock)(void);

#define huiSheCg [UIColor colorWithRed:95.0/255 green:125.0/255 blue:137.0/255   alpha:1.0].CGColor;
#define huiShe [UIColor colorWithRed:95.0/255 green:125.0/255 blue:137.0/255   alpha:1.0];
// 2.获得RGB颜色
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// rgb颜色转换（16进制->10进制）such as red:0xFF0000
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define grayColor_1 UIColorFromRGB(0x999999)
#define line_seprate UIColorFromRGB(0xdddddd)
#define bgColor UIColorFromRGB(0xf2f2f2)
#define huiseColor UIColorFromRGB(0x999999)
#define huiseColor2 UIColorFromRGB(0x666666)
#define huiseColor3 UIColorFromRGB(0x444444)
#define placeholderColor_u UIColorFromRGB(0xcacaca)

#define ScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define ScreenHeight     CGRectGetHeight([UIScreen mainScreen].applicationFrame)

//#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
//#define IS_WIDESCREEN (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568)<DBL_EPSILON )
#define IS_IPHONE ([[[UIDevice currentDevice] model] isEqualToString: @"iPhone" ])
#define IS_IPHONE_SIMULATOR ([[[UIDevice currentDevice]mode ] isEqualToString: @"iPhone Simulator"])
#define IS_IPOD   ([[[UIDevice currentDevice] model] isEqualToString: @"iPod touch"])
#define IS_IPad   ([[[UIDevice currentDevice] model] isEqualToString: @"iPad"])
#define IS_IPHONE_6 ([[UIScreen mainScreen]bounds].size.width==375)
#define IS_IPHONE_6_PLUS ([[UIScreen mainScreen]bounds].size.width==414)
#define IS_IPHONE_5 ([[UIScreen mainScreen]bounds].size.height==568)
#define IS_IPHONE_4s ([[UIScreen mainScreen]bounds].size.height==480)
#define autoSizeScaleW CGRectGetWidth([UIScreen mainScreen].applicationFrame)/375.0
#define autoSizeScaleH CGRectGetHeight([UIScreen mainScreen].applicationFrame)/647.0
#define autoSizeScaleH2 (CGRectGetHeight([UIScreen mainScreen].applicationFrame)==460?548/647.0:CGRectGetHeight([UIScreen mainScreen].applicationFrame)/647.0)

// 1.判断是否为iOS7
#define iOS7_OR_LATER ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8_OR_LATER ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

#define appBaseURL @"http://capi.hehenian.com"//@"http://mobileapi.hehenian.com"
#define registerUrl @"http://m.hehenian.com/account/regIndex.do"
#define KCheckUrl @"http://"
#define requestSetUserAgent @"peanut"
#define isOnPath @"Notification_isOn"  //判断接受推送消息路劲

#define TabbarHeight 50

// 正文的字体
#define DHTextFont [UIFont systemFontOfSize:13]

#ifdef DEBUG

#define HHLog(...) NSLog(__VA_ARGS__)

#else

#define HHLog(...) /* */

#endif

#endif /* Constant_h */
