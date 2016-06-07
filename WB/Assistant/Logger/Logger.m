//
//  Logger.m
//  HHNMobileFramework
//
//  Created by huihu on 15/8/7.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import "Logger.h"
#import "ZipUtil.h"
#import "LoggerUtil.h"


@implementation LogConfig

- (instancetype)init
{
//TODO: 日志文件的相关配置
    if (self = [super init])
    {
        NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _dir = [cachesDirectory stringByAppendingPathComponent:@"Logs"];
        _policy =LogFilePolicyNoLogFile;//LogFilePolicyPerLaunch;// TODO:文件策略配置
        _outputLevel = LogLevelDebug;
        _fileLevel = LogLevelInfo;
    }
    return self;
}

@end

@interface Logger ()
{
    NSString *_tag;
}
@end
@implementation Logger

static LogConfig *logConfig=nil;

+(void)Config:(LogConfig *)conf
{
    if (conf) {
        logConfig=conf;
    }else{
        logConfig =[[LogConfig alloc]init];
    }
}

+(instancetype)getLogger:(NSString *)tag
{
    static NSMutableDictionary *loggerDict=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loggerDict=[[NSMutableDictionary alloc]init];
    });
    if (tag.length==0) {
        tag=@"Default";
    }
    
    Logger *logger=nil;
    @synchronized(loggerDict){
        logger=[loggerDict objectForKey:tag];
        if (logger==nil) {
            logger=[[Logger alloc]initWithTag:tag];
            
            [loggerDict setObject:logger forKey:tag];
        }
    }
    
    return logger;
}

static bool isLoggable(LogLevel level)
{
    return level>=logConfig.outputLevel;
}

static NSString *logLevelToString(LogLevel level)
{
    NSString *str;
    switch (level) {
        case LogLevelDebug:
            str=@"Debug";
            break;
        case LogLevelInfo:
            str=@"Info";
            break;
        case LogLevelWarn:
            str=@"Warn";
            break;
        case LogLevelError:
            str=@"Error";
            break;
        default:
            str = @"Unknown";
            break;
    }
    return str;
}

static NSString *logFilePath=nil;
static NSFileHandle *logFileHandle=nil;

+(NSString *)logFilePath
{
    return logFilePath;
}

+ (NSString *)logFileDir
{
    return logConfig.dir;
}

//对文件的操作=====BEGIN=======

static void createLogFile(){
    NSString *dir=logConfig.dir;
    NSError *error=nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir]) {
        if(![[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error]){
            HHLog(@"Error occurred while creating log dir(%@):%@",dir,error);
        };
    }
    
    if (!error) {
        NSDate *date=[NSDate date];
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        if (logConfig.policy==LogFilePolicyPerDay) {
            [formatter setDateFormat:@"yyyy-MM-dd"];
        }else{
            [formatter setDateFormat:@"yyyy-MM-dd_HH_mm_ss"];
        }
        logFilePath=[NSString stringWithFormat:@"%@/%@.log",dir,[formatter stringFromDate:date]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:logFilePath]) {
            [[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil];
        }
        
        logFileHandle=[NSFileHandle fileHandleForWritingAtPath:logFilePath];
        
        [logFileHandle seekToEndOfFile];//第一次打开的时候要move to end
        [Logger info:TLogUpload message:@"log file:%@",logFilePath];
    }
}

static void clearLogFile()
{
    if (logConfig.dir) {
        NSArray *cachedFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:logConfig.dir error:nil];
        
        if (nil == cachedFiles || ([cachedFiles count] < 1)) {
            return;
        }
        
        // 合法日志文件名
        NSDateFormatter* ymdhmsDateFormatter = [[NSDateFormatter alloc] init];
        [ymdhmsDateFormatter setDateFormat:@"yyyy-MM-dd_HH-mm-ss"];
        NSDateFormatter* ymdDateFormatter = [[NSDateFormatter alloc] init];
        [ymdDateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate* (^dateFromFileName)(NSString* fileName) = ^NSDate* (NSString* fileName) {
            // parse date
            NSRange range = [fileName rangeOfString:@"\\d{4}-\\d{2}-\\d{2}_\\d{2}-\\d{2}-\\d{2}" options:NSRegularExpressionSearch];
            NSDate* logDate = nil;
            if (range.location != NSNotFound) {
                NSString* dateStr = [fileName substringWithRange:range];
                logDate = [ymdhmsDateFormatter dateFromString:dateStr];
            } else {
                NSRange range = [fileName rangeOfString:@"\\d{4}-\\d{2}-\\d{2}" options:NSRegularExpressionSearch];
                if (range.location != NSNotFound) {
                    NSString* dateStr = [fileName substringWithRange:range];
                    logDate = [ymdDateFormatter dateFromString:dateStr];
                }
            }
            
            return logDate;
        };
        
        __block NSMutableArray* zipLogFiles = [NSMutableArray arrayWithCapacity:[cachedFiles count]];
        __block NSMutableArray* rawLogFiles = [NSMutableArray arrayWithCapacity:[cachedFiles count]];
        // 最少要保留2个未压缩日志
        __block int min_raw_logs = 2;
        
        // 只保留最近30天的
        NSTimeInterval expire_interval = (30 * 24 * 3600);
        NSDate* expireDate = [NSDate dateWithTimeIntervalSinceNow:-expire_interval];
        
        NSString* const RAW_LOG_EXTENSION = @"log";
        NSString* const ZIP_LOG_EXTENSION = @"zip";
        
        // 删除不需要的文件
        [cachedFiles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (![obj isKindOfClass:[NSString class]]) {
                return ;
            }
            
            NSString* fileName = obj;
            // 原始log文件或者压缩后的log文件
            if (fileName && [[fileName pathExtension] isEqualToString:RAW_LOG_EXTENSION]) {
                NSDate* logDate = dateFromFileName(fileName);
                if (logDate != nil) {
                    NSString* fullPath = [logConfig.dir stringByAppendingPathComponent:fileName];
                    if (logFilePath != nil && [fullPath isEqualToString:logFilePath]) {
                        --min_raw_logs;
                    } else {
                        [rawLogFiles addObject:@[logDate, fullPath]];
                    }
                }
            } else if (fileName && [[fileName pathExtension] isEqualToString:ZIP_LOG_EXTENSION]) {
                NSDate* logDate = dateFromFileName(fileName);
                if (logDate != nil) {
                    [zipLogFiles addObject:@[logDate, [logConfig.dir stringByAppendingPathComponent:fileName]]];
                }
            }
        }];
        
        //删除过期的压缩日志文件
        [zipLogFiles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (![obj isKindOfClass:[NSArray class] ]) {
                return ;
            }
            
            NSDate* logDate = [obj firstObject];
            if ([logDate compare:expireDate] == NSOrderedAscending) {
                NSString* fullPath = [obj lastObject];
                
                if ([[NSFileManager defaultManager] isDeletableFileAtPath:fullPath]) {
                    [[NSFileManager defaultManager] removeItemAtPath:fullPath error:NULL];
                }
            }
        }];
        
        // 未压缩日志文件按日期排序
        [rawLogFiles sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSDate* logDate1 = [obj1 firstObject];
            NSDate* logDate2 = [obj2 firstObject];
            
            return [logDate1 compare:logDate2];
        }];
        
        // 留下不需压缩的日志文件
        while (([rawLogFiles count] > 0) && (min_raw_logs > 0)) {
            [rawLogFiles removeLastObject];
            --min_raw_logs;
        }
        
        //删除过期的日志文件，并将其余日志文件压缩
        [rawLogFiles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSDate* logDate = [obj firstObject];
            NSString* fullPath = [obj lastObject];
            
            BOOL shouldDelete = YES;
            if ([logDate compare:expireDate] != NSOrderedAscending) {
                NSString* zipFilePath = [[fullPath stringByDeletingPathExtension] stringByAppendingPathExtension:ZIP_LOG_EXTENSION];
                if ([[NSFileManager defaultManager] fileExistsAtPath:zipFilePath]) {
                    // error
                    if ([[NSFileManager defaultManager] isDeletableFileAtPath:zipFilePath]) {
                        [[NSFileManager defaultManager] removeItemAtPath:zipFilePath error:NULL];
                    }
                }
                
                // 对日志文件进行压缩，减少流量
                shouldDelete = [ZipUtil gzipCompressFile:fullPath
                                             zipFilePath:zipFilePath
                                              withHeader:YES];
                
            }
            
            if (shouldDelete && [[NSFileManager defaultManager] isDeletableFileAtPath:fullPath]) {
                [[NSFileManager defaultManager] removeItemAtPath:fullPath error:NULL];
            }
        }];
        
    }
}


static void logToFile(NSString* text)
{
    static dispatch_once_t onceToken;
    static dispatch_queue_t logQueue;
    static NSDateFormatter *dateFormatter;
    dispatch_once(&onceToken, ^{
        logQueue = dispatch_queue_create("logQueue", DISPATCH_QUEUE_SERIAL);
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        dispatch_async(logQueue, ^{
            createLogFile();
            clearLogFile();
        });
        
    });
    
    dispatch_async(logQueue, ^{
        
        NSString *date = [dateFormatter stringFromDate:[NSDate date]];
        NSString *logText = [NSString stringWithFormat:@"%@ %@\r\n", date, text];
        
        @try {
            [[LoggerUtil shareInstance] addLog:logText];
            
            [logFileHandle writeData:[logText dataUsingEncoding:NSUTF8StringEncoding]];
        } @catch(NSException *e) {
            HHLog(@"Error: cannot write log file with exception %@", e);
        }
        
    });
}

static NSString *formatLogStr(NSString *tag, LogLevel level, NSString *format, va_list args)
{
    NSString *input = [[NSString alloc] initWithFormat:format arguments:args];
    NSString *thread;
    if ([[NSThread currentThread] isMainThread]) {
        thread = @"Main";
    } else {
        thread = [NSString stringWithFormat:@"%p", [NSThread currentThread]];
    }
    
    NSString *logString = [NSString stringWithFormat:@"[%@][%@][%@] %@", thread, tag, logLevelToString(level), input];
    return logString;
}

static void logInternal(NSString *tag, LogLevel level, NSString *format, va_list args)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (logConfig==nil) {
            logConfig=[[LogConfig alloc]init];
        }
    });
    if (isLoggable(level)) {
        NSString *logString=formatLogStr(tag, level, format, args);
        
#ifdef DEBUG
        NSLog(@"%@",logString);
#endif
        if (level>=logConfig.fileLevel&&logConfig.policy!=LogFilePolicyNoLogFile) {
            logToFile(logString);
        }
        
    }
}
//对文件的操作=====END=======

+(void)log:(NSString *)tag level:(LogLevel)level message:(NSString *)format, ...NS_FORMAT_FUNCTION(3, 4)
{
    va_list args;
    va_start(args, format);
    logInternal(tag, level, format, args);
    va_end(args);
    
}

+(void)debug:(NSString *)tag message:(NSString *)format, ...NS_FORMAT_FUNCTION(2, 3)
{

    va_list args;
    va_start(args, format);
    logInternal(tag, LogLevelDebug, format, args);
    va_end(args);

}

+(void)info:(NSString *)tag message:(NSString *)format, ...NS_FORMAT_FUNCTION(2, 3)
{
    va_list args;
    va_start(args, format);
    logInternal(tag, LogLevelInfo, format, args);
    va_end(args);
}

+(void)warn:(NSString *)tag message:(NSString *)format, ...NS_FORMAT_FUNCTION(2, 3)
{
    va_list args;
    va_start(args, format);
    logInternal(tag, LogLevelWarn, format, args);
    va_end(args);

}

+(void)error:(NSString *)tag message:(NSString *)format, ...NS_FORMAT_FUNCTION(2, 3)
{
    va_list args;
    va_start(args, format);
    logInternal(tag, LogLevelError, format, args);
    va_end(args);

}

static void clearLogFileWithoutRecent()
{
    if (logConfig.dir) {
        NSArray *cachedFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:logConfig.dir error:nil];
        
        if (nil == cachedFiles) {
            return;
        }
        
        [cachedFiles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                NSString* fullPath = [logConfig.dir stringByAppendingPathComponent:obj];
                if ([[NSFileManager defaultManager] isDeletableFileAtPath:fullPath]
                    && !((nil != logFilePath) && [fullPath isEqualToString:logFilePath])) {
                    [[NSFileManager defaultManager] removeItemAtPath:fullPath error:NULL];
                }
            }
        }];
    }
}

+(void)cleanLogFiles
{
   clearLogFileWithoutRecent();
}

-(void)log:(LogLevel)level message:(NSString *)format, ...
{
    va_list args;
    va_start(args, format);
    logInternal(_tag, level, format, args);
    va_end(args);
}

-(void)debug:(NSString *)format, ...NS_FORMAT_FUNCTION(1, 2)
{
    va_list args;
    va_start(args, format);
    logInternal(_tag, LogLevelDebug, format, args);
    va_end(args);
}
-(void)info:(NSString *)format, ...NS_FORMAT_FUNCTION(1, 2)
{
    va_list args;
    va_start(args, format);
    logInternal(_tag, LogLevelInfo, format, args);
    va_end(args);
}

-(void)warn:(NSString *)format, ...NS_FORMAT_FUNCTION(1, 2)
{
    va_list args;
    va_start(args, format);
    logInternal(_tag, LogLevelWarn, format, args);
    va_end(args);
}
-(void)error:(NSString *)format, ...NS_FORMAT_FUNCTION(1, 2)
{
    va_list args;
    va_start(args, format);
    logInternal(_tag, LogLevelError, format, args);
    va_end(args);
}


+ (NSArray *)sortedLogFileArray
{
    NSArray *sortedLogFileArray = nil;
    if (logConfig.dir) {
        NSArray *logFileArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:logConfig.dir
                                                                                    error:nil];
        // 过滤掉 SDK 的日志，只保留yyyy-MM-x...x.log
        NSMutableArray *logFileTempArray = [logFileArray mutableCopy];
        for (NSString *log in logFileArray) {
            if (![log hasPrefix:@"20"] || ![log hasSuffix:@".log"]) {
                [logFileTempArray removeObject:log];
            }
        }
        
        if ([logFileTempArray count] > 0) {
            logFileArray = [logFileTempArray sortedArrayUsingComparator:^NSComparisonResult(id log1, id log2) {
                return [log1 compare:log2 options:NSNumericSearch];
            }];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            [logFileArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [tempArray addObject:[logConfig.dir stringByAppendingPathComponent:obj]];
            }];
            
            sortedLogFileArray = ([tempArray count] > 0) ? [tempArray copy] : nil;
        }
    }
    
    return sortedLogFileArray;
}


- (id)initWithTag:(NSString *)tag
{
    if (self = [super init])
    {
        _tag = tag;
    }
    return self;
}
@end
