/*
 * Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "LUCacheManager.h"
#import "LUKeychainAccess.h"

NSString * const LUCachedLoyaltyKey = @"LUCachedLoyaltyKey";
NSString * const LUCachedUserKey = @"LUCachedUserKey";

static LULoyalty *_cachedLoyalty;
static LUUser *_cachedUser;

@implementation LUCacheManager

#pragma mark - Object Creation

+ (LULoyalty *)cachedLoyalty {
  if (_cachedLoyalty) return _cachedLoyalty;

  _cachedLoyalty = [self cachedObjectForKey:LUCachedLoyaltyKey];
  return _cachedLoyalty;
}

+ (LUUser *)cachedUser {
  if (_cachedUser) return _cachedUser;

  _cachedUser = [self cachedObjectForKey:LUCachedUserKey];
  return _cachedUser;
}

+ (void)cacheLoyalty:(LULoyalty *)loyalty {
  _cachedLoyalty = loyalty;
  [self cacheObject:loyalty forKey:LUCachedLoyaltyKey];
}

+ (void)cacheUser:(LUUser *)user {
  _cachedUser = user;
  [self cacheObject:user forKey:LUCachedUserKey];
}

+ (void)setKeychainErrorHandler:(id<LUKeychainErrorHandler>)keychainErrorHandler {
  [self keychainAccess].errorHandler = keychainErrorHandler;
}

#pragma mark - Private Methods

+ (void)cacheObject:(id)object forKey:(NSString *)key {
  [[self keychainAccess] setObject:object forKey:key];
}

+ (id)cachedObjectForKey:(NSString *)key {
  return [[self keychainAccess] objectForKey:key];
}

+ (LUKeychainAccess *)keychainAccess {
  static LUKeychainAccess *_keychainAccess;

  if (_keychainAccess) return _keychainAccess;

  _keychainAccess = [LUKeychainAccess standardKeychainAccess];
  return _keychainAccess;
}

@end
