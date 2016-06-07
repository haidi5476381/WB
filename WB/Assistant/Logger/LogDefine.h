//
//  LogDefine.h
//  HHNMobileFramework
//
//  Created by huihu on 15/8/9.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogDefine : NSObject

@end

static NSString* const TLogUpload = @"logUpload"; //日志上传相关

static NSString* const TApp = @"App"; // Appdelegate等
static NSString* const TBaseWeb = @"BaseWeb"; // basewebController
static NSString* const THome = @"Home"; //首页页面相关
static NSString* const TShare = @"Share"; //分享页面相关
static NSString* const TAccount = @"Account"; //账户页面
static NSString* const TMsgCenter = @"MsgCenter"; //消息中心


//拼接多个Log Tag
#define TAG(tag1,tag2) ([[tag1 stringByAppendingString:@"|"]stringByAppendingString:tag2])