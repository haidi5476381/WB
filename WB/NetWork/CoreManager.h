//
//  CoreManager.h
//  HHNMobileFramework
//
//  Created by huhmf on 15/7/20.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceCenter/CommonServiceCenter.h"

#define GetCore(className) ((className *)[CoreManager getCore:[className class]])
#define GetCoreI(InterfaceName) ((id<InterfaceName>)[CoreManager getCoreFromProtocol:@protocol(InterfaceName)])

#define AddCoreClient(protocolName, client) ([CoreManager addClient:client for:@protocol(protocolName)])

#define RemoveCoreClient(protocolName, client) ([CoreManager removeClient:client for:@protocol(protocolName)])

#define RemoveCoreClientAll(client) ([CoreManager removeClient:client])

#define NotifyCoreClient(protocolName, selector, func) NOTIFY_SERVICE_CLIENT(protocolName, selector, func)

@interface CoreManager : NSObject

+ (void)initCoreWithDBKey:(NSString *)dbKey beforeInitCore:(void (^)(void))blcok;

+ (id)getCore:(Class)cls;
+ (id)getCoreFromProtocol:(Protocol *)protocol;

+ (void)addClient:(id)obj for:(Protocol *)protocol;

+ (void)removeClient:(id)obj for:(Protocol *)protocol;

+ (void)removeClient:(id)obj;

@end

