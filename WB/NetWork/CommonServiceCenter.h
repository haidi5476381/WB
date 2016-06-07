//
//  CommonServiceCenter.h
//  HHNMobileFramework
//
//  Created by huhmf on 15/7/17.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef Protocol * CommonServiceClientKey;

// 持久对象中心。 用来存放为全局服务的对象。
@interface CommonServiceCenter : NSObject

+(instancetype)sharedServiceCenter;

/**
 *  获取对象，如果对象不存在，会自动创建对象
 */
-(id)getService:(Class)cls;

-(void)removeService:(Class)cls;

-(void)setNotifyingClientsWithKey:(CommonServiceClientKey)key isNotifying:(BOOL)isNofitying;

-(BOOL)isNotifyingClientsWithKey:(CommonServiceClientKey)key;

- (NSArray *)serviceClientsWithKey:(CommonServiceClientKey)key;

-(void)addServiceClient:(id)client withKey:(CommonServiceClientKey)key;

-(void)removeServiceClient:(id)client withKey:(CommonServiceClientKey)key;

-(void)removeServiceClient:(id)client;
@end


/// 为了client不被增加引用计数，引入一个包装类。
@interface CommonServiceClient : NSObject

@property (nonatomic, weak) id object;
- (id)initWithObject:(id)object;

@end

#define ADD_SERVICE_CLIENT(protocolName, object) [[CommonServiceCenter sharedServiceCenter] addServiceClient:object withKey:@protocol(protocolName)]
#define REMOVE_SERVICE_CLIENT(protocolName, object) [[CommonServiceCenter sharedServiceCenter] removeServiceClient:object withKey:@protocol(protocolName)]
#define REMOVE_ALL_SERVICE_CLIENT(object) [[CommonServiceCenter sharedServiceCenter] removeServiceClient:object]
#define NOTIFY_SERVICE_CLIENT(protocolName, selector, func) \
{ \
NSAssert(![[CommonServiceCenter sharedServiceCenter] isNotifyingClientsWithKey:@protocol(protocolName)], @"recusively call the same service clients."); \
[[CommonServiceCenter sharedServiceCenter] setNotifyingClientsWithKey:@protocol(protocolName) isNotifying:YES]; \
NSArray *__clients__ = [[CommonServiceCenter sharedServiceCenter] serviceClientsWithKey:@protocol(protocolName)]; \
for (CommonServiceClient *client in __clients__) \
{ \
id obj = client.object; \
if ([obj respondsToSelector:selector]) \
{ \
[obj func]; \
} \
} \
[[CommonServiceCenter sharedServiceCenter] setNotifyingClientsWithKey:@protocol(protocolName) isNotifying:NO]; \
}