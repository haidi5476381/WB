//
//  ZipUtils.h
//  HHNMobileFramework
//
//  Created by huihu on 15/8/7.
//  Copyright (c) 2015年 huhmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZipUtil : NSObject

+ (NSData *)gzipData:(NSData *)pUncompressedData withGZipHeader:(BOOL)withGZipHeader;
+ (BOOL)gzipCompressFile:(NSString *)filePath
             zipFilePath:(NSString *)zipFilePath
              withHeader:(BOOL)withHeader;

+ (NSData *)uncompressZippedData:(NSData *)compressedData;

@end
