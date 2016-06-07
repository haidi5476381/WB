//
//  Logger.h
//  HHNMobileFramework
//
//  Created by huihu on 15/8/7.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum:NSUInteger
{
    LogLevelDebug,
    LogLevelInfo,
    LogLevelWarn,
    LogLevelError
}LogLevel;//log 级别

typedef enum :NSUInteger
{
    LogFilePolicyNoLogFile,
    LogFilePolicyPerDay,
    LogFilePolicyPerLaunch
}LogFilePolicy;//log文件策略


@interface LogConfig : NSObject

@property(nonatomic,strong) NSString *dir;//log文件目录
@property(assign,nonatomic) LogFilePolicy policy;//log文件策略
@property(assign,nonatomic) LogLevel outputLevel;//输出级别，大于等于此级别的log才会输出
@property(assign,nonatomic) LogLevel fileLevel;//输出到文件的级别，大于等于此级别的log才会写入文件

@end


@interface Logger : NSObject

+(void)Config:(LogConfig *)conf;

+(instancetype)getLogger:(NSString *)tag;

+(NSString *)logFilePath;
+ (NSString *)logFileDir;

+(void)log:(NSString *)tag level:(LogLevel)level message:(NSString *)format,...NS_FORMAT_FUNCTION(3, 4);

+ (void)debug:(NSString *)tag message:(NSString *)format, ...NS_FORMAT_FUNCTION(2, 3);

+ (void)info:(NSString *)tag message:(NSString *)format, ...NS_FORMAT_FUNCTION(2, 3);

+ (void)warn:(NSString *)tag message:(NSString *)format, ...NS_FORMAT_FUNCTION(2, 3);

+ (void)error:(NSString *)tag message:(NSString *)format, ...NS_FORMAT_FUNCTION(2, 3);

+ (void)cleanLogFiles;

- (void)log:(LogLevel)level message:(NSString *)format, ...NS_FORMAT_FUNCTION(2, 3);

- (void)debug:(NSString *)format, ...NS_FORMAT_FUNCTION(1, 2);

- (void)info:(NSString *)format, ...NS_FORMAT_FUNCTION(1, 2);

- (void)warn:(NSString *)format, ...NS_FORMAT_FUNCTION(1, 2);

- (void)error:(NSString *)format, ...NS_FORMAT_FUNCTION(1, 2);

+ (NSArray *)sortedLogFileArray;
@end

//非类形式的另一个打Log函数，为方便使用
#define LogDebug(tag, format, arg...)  [Logger debug:tag message:format, ##arg]
#define LogInfo(tag, format, arg...)  [Logger info:tag message:format, ##arg]
#define LogWarn(tag, format, arg...)  [Logger warn:tag message:format, ##arg]
#define LogError(tag, format, arg...)  [Logger error:tag message:format, ##arg]
