//
//  GHNSFileManager+Utils.h
//
//  Created by Gabe on 3/23/08.
//  Copyright 2008 Gabriel Handford
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

/*!
 Utilities for NSFileManager, for example, file size, exists, generating temporary or unique
 file paths.
 */
@interface NSFileManager(GHUtils)

/*!
 Get size of file.
 
 @param filePath Path
 @param error Out error
 @result File size
 */
+ (NSNumber *)gh_fileSize:(NSString *)filePath error:(NSError **)error;

/*!
 Check if path is a directory.
 
 @param filePath Path
 @result YES if directory, NO otherwise
 */
+ (BOOL)gh_isDirectory:(NSString *)filePath;

/*!
 Check if path exists.
 
 @param filePath Path
 @result YES if exists, NO otherwise
 */
+ (BOOL)gh_exist:(NSString *)filePath;

/*!
 Get path to temporary file.
 
 @param appendPath Path to append to temporary directory name, if not nil
 @param deleteIfExists Will delete existing file if it is in the way
 @param error If not nil, will be set if an error occurs
 @result Path for temporary file
 */
+ (NSString *)gh_temporaryFile:(NSString *)appendPath deleteIfExists:(BOOL)deleteIfExists error:(NSError **)error;

/*!
 Get unique filename based on the specified path. 
 If file does not exist, the same object is returned.
 If file does exist a unique variation is returned.
 
 @param path Path
 @result If, for example, foo.txt already exists, will return foo-1.txt, and if that exists foo-2.txt, and so on.
 */
+ (NSString *)gh_uniquePathWithNumber:(NSString *)path;

/*!
 Ensure directory exists.
 
 @param directory Directory
 @param created Set if was created
 @param error If not nil, will set if error occurs
 @result YES If directory exists or was created
 */
+ (BOOL)gh_ensureDirectoryExists:(NSString *)directory created:(BOOL *)created error:(NSError **)error;

/*!
 Path to resource in main bundle.
 
 @param path Path
 @result Full path in resource in main bundle.
 */
+ (NSString *)gh_pathToResource:(NSString *)path;

@end
