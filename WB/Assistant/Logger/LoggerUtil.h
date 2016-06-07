//
//  LoggerUtil.h
//  HHNMobileFramework
//
//  Created by huihu on 15/8/7.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoggerUtil : NSObject
//单例
+ (LoggerUtil *) shareInstance;

/**
 * 初始化方法,设置保留的最小log记录数量和最大数量
 * @param splitSymbol 每条log之间的分隔符 可以设置为@"",@"\n"等
 * @param keepCount 当log超过设置最大数量时,保留的最小记录数
 * @param maxCount  log记录的最大数量,超过这个数量,会删除log数量到keepCount大小
 */
- (void)setInitSplitSymbol:(NSString *) splitSymbol KeepCount:(NSInteger)keepCount maxCount:(NSInteger)maxCount;

/**
 * 添加log
 * content  log的内容
 */
- (void)addLog:(NSString *) content;

//获取log
- (NSString *)getLog;



@end
