/*Copyright (c) 2007 Extendmac, LLC. <support@extendmac.com>
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */

#import "EMKeychainProxy.h"

@implementation EMKeychainProxy

static EMKeychainProxy* sharedProxy;

+ (id)sharedProxy
{
	if (!sharedProxy)
	{
		sharedProxy = [[EMKeychainProxy alloc] init];
	}
	return sharedProxy;
}
- (void)lockKeychain
{
	SecKeychainLock(NULL);
}
- (void)unlockKeychain
{
	SecKeychainUnlock(NULL, 0, NULL, NO);
}
- (void)setLogsErrors:(BOOL)flag
{
	_logErrors = flag;
}

#pragma mark -
#pragma mark Getting Keychain Items
- (EMGenericKeychainItem *)genericKeychainItemForService:(NSString *)serviceNameString withUsername:(NSString *)usernameString
{
	if (!usernameString || [usernameString length] == 0)
	{
		return nil;
	}
	
	const char *serviceName = [serviceNameString UTF8String];
	const char *username = [usernameString UTF8String];
	
	UInt32 passwordLength = 0;
	char *password = nil;
	
	SecKeychainItemRef item = nil;
	OSStatus returnStatus = SecKeychainFindGenericPassword(NULL, (UInt32)strlen(serviceName), serviceName, (UInt32)strlen(username), username, &passwordLength, (void **)&password, &item);
	if (returnStatus != noErr || !item)
	{
		if (_logErrors)
		{
#if !TARGET_OS_IPHONE
			NSLog(@"Error (%@) - %s", NSStringFromSelector(_cmd), GetMacOSStatusErrorString(returnStatus));
#endif
		}
		return nil;
	}
	
	NSString *passwordString = nil;

	if (password != NULL) {
		char passwordBuffer[1024];
		if (passwordLength > 1023) passwordLength = 1023; // Ensure room for the NULL character.
		strncpy(passwordBuffer, password, passwordLength);
		passwordBuffer[passwordLength] = '\0';
		passwordString = [NSString stringWithUTF8String:passwordBuffer];
	}

	return [EMGenericKeychainItem genericKeychainItem:item forServiceName:serviceNameString username:usernameString password:passwordString];
}

#pragma mark -
#pragma mark Saving Passwords
- (EMGenericKeychainItem *)addGenericKeychainItemForService:(NSString *)serviceNameString withUsername:(NSString *)usernameString password:(NSString *)passwordString
{
	if (!usernameString || [usernameString length] == 0 || !serviceNameString || [serviceNameString length] == 0)
	{
		return nil;
	}	
	const char *serviceName = [serviceNameString UTF8String];
	const char *username = [usernameString UTF8String];
	const char *password = [passwordString UTF8String];
	
	SecKeychainItemRef item = nil;
	OSStatus returnStatus = SecKeychainAddGenericPassword(NULL, (UInt32)strlen(serviceName), serviceName, (UInt32)strlen(username), username, (UInt32)strlen(password), (void *)password, &item);
	
	if (returnStatus != noErr || !item)
	{
#ifndef TARGET_OS_IPHONE    
		NSLog(@"Error (%@) - %s", NSStringFromSelector(_cmd), GetMacOSStatusErrorString(returnStatus));
#endif
		return nil;
	}
	return [EMGenericKeychainItem genericKeychainItem:item forServiceName:serviceNameString username:usernameString password:passwordString];
}

@end
