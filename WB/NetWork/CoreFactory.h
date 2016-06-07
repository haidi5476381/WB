//
//  CoreFactory.h
//  HHNMobileFramework
//
//  Created by huhmf on 15/7/17.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreFactory : NSObject

+ (void)registerClass:(Class)cls forProtocol:(Protocol *)protocol;
+ (Class)classForProtocol:(Protocol *)protocol;
+ (BOOL)hasRegisteredProtocol:(Protocol *)protocol;

+ (id)getCoreFromClass:(Class)cls;
+ (id)getCoreFromProtocol:(Protocol *)protocol;
@end
