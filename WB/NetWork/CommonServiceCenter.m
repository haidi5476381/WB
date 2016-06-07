//
//  CommonServiceCenter.m
//  HHNMobileFramework
//
//  Created by huhmf on 15/7/17.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import "CommonServiceCenter.h"
#import <objc/runtime.h>

#define MULTI_THREAD_SAFE 0

static CommonServiceCenter *_serviceCenter=nil;
@interface CommonServiceCenter()
{
    NSMutableDictionary *_serviceDictionary;
    NSMutableDictionary *_clientDictionary;
    NSMutableDictionary *_notifyingKeys;//用于记录当前正在遍历中得service
}
@end
@implementation CommonServiceCenter

-(instancetype)init
{
    if (self=[super init]) {
        _serviceDictionary=[[NSMutableDictionary alloc]init];
        _clientDictionary=[[NSMutableDictionary alloc]init];
        _notifyingKeys=[[NSMutableDictionary alloc]init];
    }
    
    return self;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    //调用dispatch_once保证在多线程中也只被实例化一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _serviceCenter=[super allocWithZone:zone];
    });
    
    return _serviceCenter;
}
/**第3步: 保证init初始化时都相同*/
+(instancetype)sharedServiceCenter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _serviceCenter=[[CommonServiceCenter alloc]init];
    });
    return _serviceCenter;
}

/**第4步: 保证copy时都相同*/
-(id)copyWithZone:(NSZone *)zone{
    return _serviceCenter;
}

-(id)getService:(Class)cls
{
    NSString *key=[NSString stringWithUTF8String:class_getName(cls)];
    id obj=nil;
#if MULTI_THREAD_SAFE
    @synchronized(self)
#endif
    {
        obj=[_serviceDictionary objectForKey:key];
        if (obj==nil) {
            obj=[[cls alloc]init];
            
            [_serviceDictionary setObject:obj forKey:key];
            LogInfo(@"serviceCenter::",@"create service object: %@",obj);
        }
    }
    
    return obj;
}

-(void)removeService:(Class)cls
{
   NSString *key=[NSString stringWithUTF8String:class_getName(cls)];
#if MULTI_THREAD_SAFE
    @synchronized(self)
#endif
    {
        LogInfo(@"serviceCenter::",@"remove service object %@",key);
        [_serviceDictionary removeObjectForKey:key];
    }
}

-(void)setNotifyingClientsWithKey:(CommonServiceClientKey)key isNotifying:(BOOL)isNofitying
{
    NSString *strKey=NSStringFromProtocol(key);
    if (isNofitying) {
        [_notifyingKeys setObject:strKey forKey:strKey];
    }else{
        [_notifyingKeys removeObjectForKey:strKey];
    }
}

-(BOOL)isNotifyingClientsWithKey:(CommonServiceClientKey)key
{
    NSString *strKey=NSStringFromProtocol(key);
    return ([_notifyingKeys objectForKey:strKey]!=nil);
}
- (NSArray *)serviceClientsWithKey:(CommonServiceClientKey)key
{
    NSMutableArray *result = [self _getClientsWithKey:key];
    
    return [NSArray arrayWithArray:result];
}

-(void)addServiceClient:(id)client withKey:(CommonServiceClientKey)key
{
    if (client) {
        if (![client conformsToProtocol:key]) {
            LogInfo(@"serviceCenter::",@"client does not conforms to protocol :%@",NSStringFromProtocol(key));
            //return;
        }
#if MULTI_THREAD_SAFE
        @synchronized(self)
#endif
        {
            NSMutableArray *clients=[self _getClientsWithKey:key];
            for (CommonServiceClient *obj in clients) {
                if (obj.object == client)
                {
                    return;
                }
            }
             LogInfo(@"serviceCenter::",@"add client %@ for protocol %@", client, NSStringFromProtocol(key));
            [clients addObject:[[CommonServiceClient alloc] initWithObject:client]];
        }
    }
}

- (NSMutableArray *)_getClientsWithKey:(CommonServiceClientKey)key
{
    NSString *strKey = NSStringFromProtocol(key);
    NSMutableArray *clients = nil;
#if MULTI_THREAD_SAFE
    @synchronized(self)
#endif
    {
        clients = [_clientDictionary objectForKey:strKey];
        if (!clients)
        {
            clients = [[NSMutableArray alloc] init];
            [_clientDictionary setObject:clients forKey:strKey];
        }
    }
    return clients;
}

-(void)removeServiceClient:(id)client withKey:(CommonServiceClientKey)key
{
    
    if (client)
    {
#if MULTI_THREAD_SAFE
        @synchronized(self)
#endif
        {
            NSMutableArray *clients = [self _getClientsWithKey:key];
            CommonServiceClient *found = nil;
            for (CommonServiceClient *clientObj in clients)
            {
                if (clientObj.object == client)
                {
                    found = clientObj;
                    break;
                }
            }
            if (found)
            {
                LogInfo(@"serviceCenter::",@"remove client %p for protocol %@", client, NSStringFromProtocol(key));
                found.object = nil;
                [clients removeObject:found];
            }
            
            //检查为空的，因为dealloc的时候weak已经被置空
            NSArray *temp = [NSArray arrayWithArray:clients];
            for (CommonServiceClient *clientObj in temp)
            {
                if (clientObj.object == nil)
                {
                    [clients removeObject:temp];
                }
            }
        }
    }

}

-(void)removeServiceClient:(id)client
{
    LogInfo(@"serviceCenter::",@"(%s)remove all client protocol for %p",__FUNCTION__,client);
    if (client)
    {
#if MULTI_THREAD_SAFE
        @synchronized(self)
#endif
        {
            for (NSMutableArray *clients in [_clientDictionary allValues])
            {
                CommonServiceClient *found = nil;
                for (CommonServiceClient *clientObj in clients)
                {
                    if (clientObj.object == client)
                    {
                        found = clientObj;
                        break;
                    }
                }
                if (found)
                {
                    found.object = nil;
                    [clients removeObject:found];
                }
            }
        }
    }

}
@end

@implementation CommonServiceClient

- (id)initWithObject:(id)object
{
    if (self = [super init]) {
        self.object = object;
    }
    return self;
}
@end
