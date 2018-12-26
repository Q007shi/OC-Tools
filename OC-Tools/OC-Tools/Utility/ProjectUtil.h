//
//  ProjectUtil.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/25.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 项目中常用信息 */
@interface ProjectUtil : NSObject

/** app沙盒中 Documents 文件目录 */
+(NSURL *)documentsURL;
+(NSString *)documentsPath;

/** app沙盒中 Caches 文件目录 */
+(NSURL *)cachesURL;
+(NSString *)cachesPath;

/** app沙盒中 library 文件目录 */
+(NSURL *)libraryURL;
+(NSString *)libraryPath;

/** app沙盒中 tmp 文件目录 */
+ (NSString *)temporaryPath;

/** 项目名称 */
+ (NSString *)appName;

/** 项目发布名称 */
+ (NSString *)appDisplayName;

/** CFBundleIdentifier,APP 唯一标识符 */
+ (NSString *)appIdentifier;

/** CFBundleShortVersionString，APP 版本号 */
+ (NSString *)appVersion;

/** 根据文件路径获取文件属性 */
+(NSDictionary *)getFileAttributesAtPath:(NSString *)filePath;

/** 文件复制 */
+ (BOOL)copySourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath;
+ (BOOL)moveSourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath;


@end

