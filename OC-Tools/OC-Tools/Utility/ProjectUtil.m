//
//  ProjectUtil.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/25.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "ProjectUtil.h"

@implementation ProjectUtil

/** app沙盒中 Documents 文件目录 */
+ (NSURL *)documentsURL{
    return [[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
}
+ (NSString *)documentsPath{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
}
/** app沙盒中 Caches 文件目录 */
+ (NSURL *)cachesURL{
    return [[NSFileManager defaultManager]URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].lastObject;
}
+ (NSString *)cachesPath{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
}
/** app沙盒中 library 文件目录 */
+ (NSURL *)libraryURL{
    return [[NSFileManager defaultManager]URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask].lastObject;
}
+ (NSString *)libraryPath{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
};

+ (NSString *)temporaryPath{
    return NSTemporaryDirectory();
}

/** 项目名称 */
+ (NSString *)appName{
    return [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleName"];
}
+ (NSString *)appDisplayName{
    return [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

/** CFBundleIdentifier,APP 唯一标识符 */
+ (NSString *)appIdentifier{
    return [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

/** CFBundleShortVersionString，APP 版本号 */
+ (NSString *)appVersion{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

/** 根据文件路径获取文件属性 */
+(NSDictionary *)getFileAttributesAtPath:(NSString *)filePath{
    //filePath 是否为空
    if(filePath.fc_isEmpty){ return nil; }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //filePath 目录是否存在
    if([fileManager fileExistsAtPath:filePath] == NO){ return nil;}
    return [fileManager attributesOfItemAtPath:filePath error:nil];
}

/** 文件复制 */
+ (BOOL)copySourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath{
    if (sourceFile.fc_isEmpty) {
        NSException *exception = [NSException exceptionWithName:@"PathUtility 异常" reason:@"sourceFile 不能为空" userInfo:nil];
        @throw exception;
    }
    if (desPath.fc_isEmpty) {
        NSException *exception = [NSException exceptionWithName:@"PathUtility 异常" reason:@"desPath 不能为空" userInfo:nil];
        @throw exception;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:sourceFile]) {
        NSException *exception = [NSException exceptionWithName:@"PathUtility 异常" reason:[NSString stringWithFormat:@"%@ 文件不存在",sourceFile] userInfo:nil];
        @throw exception;
    }
    //读取文件
    NSData *sourceData = [NSData dataWithContentsOfFile:sourceFile];
    BOOL result = [fileManager createFileAtPath:desPath contents:sourceData attributes:nil];
    //    NSError *error;
    //    BOOL result = [fileManager copyItemAtPath:sourceFile toPath:desPath error:&error];
    return result;
}
+ (BOOL)moveSourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath{
    if (sourceFile.fc_isEmpty) {
        NSException *exception = [NSException exceptionWithName:@"PathUtility 异常" reason:@"sourceFile 不能为空" userInfo:nil];
        @throw exception;
    }
    if (desPath.fc_isEmpty) {
        NSException *exception = [NSException exceptionWithName:@"PathUtility 异常" reason:@"desPath 不能为空" userInfo:nil];
        @throw exception;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:sourceFile]) {
        NSException *exception = [NSException exceptionWithName:@"PathUtility 异常" reason:[NSString stringWithFormat:@"%@ 文件不存在",sourceFile] userInfo:nil];
        @throw exception;
    }
    NSError *error = nil;
    [fileManager moveItemAtPath:sourceFile toPath:desPath error:&error];
    if (error) {
        return NO;
    }else{
        return YES;
    }
}

@end
