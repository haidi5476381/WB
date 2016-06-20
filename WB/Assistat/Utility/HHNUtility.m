//
//  HHNUtility.m
//  hehenian-mobile
//
//  Created by huhmf on 15/7/9.
//  Copyright (c) 2015年 huihu. All rights reserved.
//

#import "HHNUtility.h"
#import <AFNetworking.h>
#import "NSString+extension.h"

@interface HHNUtility()
{
    NSMutableArray *objects;
}
@end
@implementation HHNUtility

static HHNUtility *_instance;

-(instancetype)init{
    if (self=[super init]) {
        objects=[NSMutableArray array];
    }
    return self;
}

/**第2步: 分配内存孔家时都会调用这个方法. 保证分配内存alloc时都相同*/
+(id)allocWithZone:(struct _NSZone *)zone{
    //调用dispatch_once保证在多线程中也只被实例化一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


/**第3步: 保证init初始化时都相同*/
+(instancetype)sharedHHNInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

/**第4步: 保证copy时都相同*/
-(id)copyWithZone:(NSZone *)zone{
    return _instance;
}

+ (id)valueInPlistForKey:(NSString *)key
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:key];
}

+(void)networkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        HHLog(@"%ld", (long)status);
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                HHLog(@"%@",@"网络不通");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查网络连接" delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                HHLog(@"%@",@"网络通过WIFI连接");
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                HHLog(@"%@",@"网络通过流量连接..");
                break;
            }
            default:
                break;
        }
        
        
    }];
    
}
+(BOOL)ConnectionAvailable
{
   return [AFNetworkReachabilityManager sharedManager].isReachable;
}
-(BOOL)isLogin
{
    BOOL isExist_msid=NO;
    NSHTTPCookieStorage *CookieStorage=[NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [CookieStorage cookies]) {
        HHLog(@"COOKIE{name: %@, value: %@,domain:%@}", [cookie name], [cookie value],[cookie domain]);
        if([[cookie name] isEqualToString:@"msid"]){
            isExist_msid=[[cookie value] length]>0;break ;
        }
    }
    
    
    BOOL bool_isLogin=(BOOL)[CommonFileUtils readObjectFromDocumentPath:@"isLogin"];
    
    //HHLog(@"islogin: %d,%d",isExist_msid,bool_isLogin);
    
    if([CommonFileUtils readObjectFromUserDefaultWithKey:@"userName"]&&isExist_msid&&bool_isLogin){
        return YES;
    }
    
    return NO;
}

-(NSDictionary *)setHttpHeaderWithUrl:(NSString *)hostURL Request:(NSMutableURLRequest *)request {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSURL *url = [NSURL URLWithString:hostURL];
//    for (NSHTTPCookie *cookie in [cookieStorage cookies]){
//        HHLog(@"COOKIE{name: %@, value: %@,domain:%@}", [cookie name], [cookie value],[cookie domain]);
//    }
    if (url==nil) {
        return nil;
    }
    NSArray *cookies = [cookieStorage cookiesForURL:url];//找到属于自己的cookie
    
    NSDictionary *headers =[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    NSMutableDictionary *headers_M=[NSMutableDictionary dictionary];
    NSMutableDictionary *newHeaders = [NSMutableDictionary dictionary];
    if ([headers valueForKey:@"Cookie"] != nil) {
        NSString *cookiesVaule = [headers valueForKey:@"Cookie"];
        if (cookiesVaule.length > 1) {
           [newHeaders setValue:[NSString stringWithFormat:@"%@",cookiesVaule] forKey:@"Cookie"];
        }
    }
//    [headers_M setDictionary:headers];
    [headers_M setDictionary:newHeaders];
    [headers_M setValue:[NSString stringWithFormat:@"%@",[self getUserAgent]] forKey:@"User-Agent"];
//    qianshenghua
    [request setAllHTTPHeaderFields:headers_M];//加入到request中
    
    return headers_M;
}



-(NSString *) getUserAgent {
    
    
    
    NSString *userAgent = nil;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
#if TARGET_OS_IOS
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f;%@;iv/%@)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale],[HHNUtility PlatformString],@"1.8"];
#elif TARGET_OS_WATCH
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    userAgent = [NSString stringWithFormat:@"%@/%@ (%@; watchOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[WKInterfaceDevice currentDevice] model], [[WKInterfaceDevice currentDevice] systemVersion], [[WKInterfaceDevice currentDevice] screenScale]];
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
    userAgent = [NSString stringWithFormat:@"%@/%@ (Mac OS X %@)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictio                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            nary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[NSProcessInfo processInfo] operatingSystemVersionString]];
#endif
#pragma clang diagnostic pop
    if (userAgent) {
        if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                userAgent = mutableUserAgent;
            }
        }
    }
    return userAgent;
}


/**
 *  测试方法
 */
+(void)showTestDescription
{
    NSString *description=@"This is my huhui library";
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"hey" message:description delegate:nil cancelButtonTitle:@"cool" otherButtonTitles:nil, nil];
    
    [alertView show];
}
@end
