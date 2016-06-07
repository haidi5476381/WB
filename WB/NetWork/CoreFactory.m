//
//  CoreFactory.m
//  HHNMobileFramework
//
//  Created by huhmf on 15/7/17.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import "CoreFactory.h"

static NSMapTable *coreClassMap()
{
    static NSMapTable *table =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        table=[NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
    });
    return table;
}

static NSMapTable *coresMap(){
    static NSMapTable *table=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        table=[NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
    });
    return table;
}

@implementation CoreFactory

+(void)registerClass:(Class)cls forProtocol:(Protocol *)protocol
{
    if (![cls conformsToProtocol:protocol]) {
        NSParameterAssert(0);// class 未实现protocol
        return;
    }
    [coreClassMap() setObject:cls forKey:protocol];
}

+(Class)classForProtocol:(Protocol *)protocol
{
    return [coreClassMap() objectForKey:protocol];
}


+(BOOL)hasRegisteredProtocol:(Protocol *)protocol
{
    NSParameterAssert(protocol);
    
    return [coreClassMap() objectForKey:protocol]!=nil;
}

+(id)getCoreFromClass:(Class)cls
{
    id obj=[coresMap() objectForKey:cls];
    
    if (nil==obj) {
        obj=[[cls alloc]init];
        
        [coresMap() setObject:obj forKey:cls];
    }
    return obj;
}

+(id)getCoreFromProtocol:(Protocol *)protocol
{
    id obj;
   Class impClass=[coreClassMap() objectForKey:protocol];
    if (impClass) {
       obj=[coresMap() objectForKey:impClass];
        [coresMap() setObject:obj forKey:impClass];
    }
    
    return obj;
}
@end
