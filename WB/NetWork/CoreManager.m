//
//  CoreManager.m
//  HHNMobileFramework
//
//  Created by huhmf on 15/7/20.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import "CoreManager.h"
#import "CoreFactory.h"

//#import "AuthCore.h"
//#import "homeCore.h"
//#import "SplashCore.h"
//#import "Share/ShareCore.h"
//#import "SetUp/SetupCore.h"
//#import "Account/AccountCore.h"
//#import "MoreCore.h"
//#import "../../hehenianMobile/UI/Home/HomeServices/HomeService.h"
//#import "../../hehenianMobile/UI/Home/HomeServices/IHomeServiceClient.h"


@implementation CoreManager

+ (void)initialize
{
    if (self == [CoreManager self]) {
        // Register all core classes
        [self _registerProtocols];
    }
}

+ (void)initCoreWithDBKey:(NSString *)dbKey beforeInitCore:(void (^)(void))blcok
{
    HHLog(@"initCore");
   
    //TODO:初始化数据库 DbManager
//    
//    GetCore(AuthCore);
//    GetCore(homeCore);
//    GetCore(SplashCore);
//    GetCore(ShareCore);
//    GetCore(SetupCore);
//    GetCore(AccountCore);
//    GetCore(MoreCore);
//    GetCore(HomeService);
//    
    //TODO: 初始化数据库
}

+ (id)getCore:(Class)cls
{
     //   return [[CommonServiceCenter sharedServiceCenter] getService:cls];
    return [CoreFactory getCoreFromClass:cls];
}

+ (id)getCoreFromProtocol:(Protocol *)protocol
{
    return [CoreFactory getCoreFromProtocol:protocol];
}

+ (void)addClient:(id)obj for:(Protocol *)protocol
{
    [[CommonServiceCenter sharedServiceCenter] addServiceClient:obj withKey:protocol];
}

+ (void)removeClient:(id)obj for:(Protocol *)protocol
{
    [[CommonServiceCenter sharedServiceCenter] removeServiceClient:obj withKey:protocol];
}

+ (void)removeClient:(id)obj
{
    [[CommonServiceCenter sharedServiceCenter] removeServiceClient:obj];
}

+ (void)_registerProtocols
{
#define REGISTER_CORE_PROTOCOL(c, p) [CoreFactory registerClass:([c class]) forProtocol:(@protocol(p))]
    
//    //:注册核心协议
//    //REGISTER_CORE_PROTOCOL(UserCore, IUserCore);
//    REGISTER_CORE_PROTOCOL(homeCore, IHomeClient);
//    REGISTER_CORE_PROTOCOL(AuthCore, IAuthClient);
//    REGISTER_CORE_PROTOCOL(AuthCore, IAuthQuery);
//    REGISTER_CORE_PROTOCOL(SplashCore, ISplash);
//    REGISTER_CORE_PROTOCOL(ShareCore, IShareQuery);
//    REGISTER_CORE_PROTOCOL(SetupCore, ISetUpClient);
//    REGISTER_CORE_PROTOCOL(AccountCore, IAccount);
//    REGISTER_CORE_PROTOCOL(MoreCore, IMore);
//    
//    // 新的首页接口
//    REGISTER_CORE_PROTOCOL(HomeService, IHomeServiceClient);
    
    
//#if TRAFFIC_DATA
//    REGISTER_CORE_PROTOCOL(CarrierService, ICarrierService);
//#endif
//    
//#undef REGISTER_CORE_PROTOCOL
}



@end
