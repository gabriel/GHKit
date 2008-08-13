//
//  GHNSFileManager+Utils.h
//
//  Created by Gabe on 3/23/08.
//  Copyright 2008 ducktyper.com. All rights reserved.
//

@interface NSFileManager (GHUtils)

+ (NSNumber *)gh_fileSize:(NSString *)filePath;
+ (BOOL)gh_isDirectory:(NSString *)filePath;
+ (BOOL)gh_exist:(NSString *)filePath;
+ (NSString *)gh_temporaryFile:(NSString *)basePath deleteIfExists:(BOOL)deleteIfExists;

+ (NSString *)gh_uniquePathWithNumber:(NSString *)path;

@end
