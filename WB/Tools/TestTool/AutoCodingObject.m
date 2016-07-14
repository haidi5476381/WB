//
//  NSObject+Archiver.m
//  YunDiTrip
//
//  Created by zoro on 8/4/16.
//  Copyright © 2016年 shenzhen yundi technology co.,Ltd. All rights reserved.
//

#import "AutoCodingObject.h"
#import <objc/runtime.h>

@implementation AutoCodingObject
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
//    unsigned int count;
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    for (NSInteger i = 0; i<count; i++) {
//        const char *name = property_getName(properties[i]);
//        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
//        id value = [aDecoder decodeObjectForKey:propertyName];
//        [self setValue:value forKey:propertyName];
//    }
//    free(properties);
//    return self;
    unsigned int numberOfIvars = 0;
    Ivar *ivars = class_copyIvarList([self class], &numberOfIvars);
    for(const Ivar *p = ivars; p < ivars+numberOfIvars; p++) {
        Ivar const ivar = *p;
        const char *name = ivar_getName(ivar);
        //        NSLog(@"-----name = %s ", name);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        id value = [aDecoder decodeObjectForKey:propertyName];
        
        [self setValue:value forKey:propertyName];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
//    unsigned int count;
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    for (NSInteger i=0; i<count; i++) {
//        const char *name = property_getName(properties[i]);
//        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
//        id propertyValue = [self valueForKey:propertyName];
//        [aCoder encodeObject:propertyValue forKey:propertyName];
//    }
//    
//    free(properties);
    unsigned int numberOfIvars = 0;
    Ivar *ivars = class_copyIvarList([self class], &numberOfIvars);
    for(const Ivar *p = ivars; p < ivars+numberOfIvars; p++) {
        Ivar const ivar = *p;
        const char *name = ivar_getName(ivar);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        id propertyValue = [self valueForKey:propertyName];
        [aCoder encodeObject:propertyValue forKey:propertyName];
        
    }
    
}

//TODO: 有bug
-(id)copyWithZone:(NSZone *)zone{
    id copyId = [[self class]init];
    if (copyId) {
        unsigned int count;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (NSInteger i=0; i<count; i++) {
            const char *name = property_getName(properties[i]);
            NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id propertyValue = [self valueForKey:propertyName];
            [propertyValue copyWithZone:zone];
        }
        free(properties);
    }
    return copyId;
}

@end
