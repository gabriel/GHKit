//
//  GHNSUserDefaults+Utils.m
//  GHKitIOS
//
//  Created by Gabriel Handford on 7/21/11.
//  Copyright 2011 rel.me. All rights reserved.
//

#import "GHNSUserDefaults+Utils.h"


@implementation NSUserDefaults(GHUtils)

- (BOOL)gh_containsKey:(NSString *)key {
  id value = [self objectForKey:key];
  return (value != nil);
}

- (BOOL)gh_boolForKey:(id)key withDefault:(BOOL)defaultValue {
  id value = [self objectForKey:key];
  if (!value) return defaultValue;
  return [value boolValue];   
}

- (void)gh_setBool:(BOOL)b forKey:(NSString *)key {
  [self setObject:[NSNumber numberWithBool:b] forKey:key];
}

- (double)gh_doubleForKey:(NSString *)key withDefault:(double)defaultValue {
  id value = [self objectForKey:key];
  if (!value) return defaultValue;
  return [value doubleValue];
}

- (void)gh_setDouble:(double)d forKey:(NSString *)key {
  [self setObject:[NSNumber numberWithDouble:d] forKey:key];
}

- (NSInteger)gh_integerForKey:(NSString *)key withDefault:(NSInteger)defaultValue {
  id value = [self objectForKey:key];
  if (!value) return defaultValue;
  return [value integerValue];  
}

- (void)gh_setInteger:(NSInteger)integer forKey:(NSString *)key {
  [self setObject:[NSNumber numberWithInteger:integer] forKey:key];  
}

- (void)gh_setObjectAsData:(id)obj forKey:(NSString *)key {
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
  if (!data) {
    [NSException raise:NSInvalidArgumentException format:@"Invalid data for key: %@", key];
    return;
  }
  [self setObject:data forKey:key];
}

- (id)gh_objectFromDataForKey:(NSString *)key {
  NSData *data = [self objectForKey:key];
  if (!data) return nil;
  return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (id)gh_objectForKey:(NSString *)key withDefault:(id)defaultValue {
  id value = [self objectForKey:key];
  if (!value) return defaultValue;
  return value;
}

@end
