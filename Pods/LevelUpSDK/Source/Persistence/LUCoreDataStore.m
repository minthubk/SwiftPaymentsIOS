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

#import "LUCoreDataStore.h"

NSString * const LUPersistedObjectsInitialDatabaseFileName = @"LUPersistedObjectsInitial";
NSString * const LUPersistedObjectsStoreDatabaseFileName = @"LUPersistedObjects";

@implementation LUCoreDataStore

#pragma mark - Public Methods

+ (NSURL *)storeURL {
  if (![self storeDatabaseExists] || [self initialDatabaseNewerThanStoreDatabase]) {
    [self replaceStoreDatabaseWithInitial];
  }

  return [self storeDatabaseURL];
}

#pragma mark - Private Methods (Database URLs)

+ (NSURL *)initialDatabaseURL {
  return [[NSBundle mainBundle] URLForResource:LUPersistedObjectsInitialDatabaseFileName withExtension:@"sqlite"];
}

+ (NSURL *)storeDatabaseURL {
  NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];

  NSString *storeFileName = [LUPersistedObjectsStoreDatabaseFileName stringByAppendingPathExtension:@"sqlite"];
  return [applicationDocumentsDirectory URLByAppendingPathComponent:storeFileName];
}

#pragma mark - Private Methods (Store File Access)

+ (NSDate *)fileCreatedAt:(NSURL *)file {
  NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[file path] error:nil];
  return attributes[NSFileCreationDate];
}

+ (BOOL)initialDatabaseNewerThanStoreDatabase {
  NSDate *storeDatabaseCreatedAt = [self fileCreatedAt:[self storeDatabaseURL]];
  NSDate *initialDatabaseCreatedAt = [self fileCreatedAt:[self initialDatabaseURL]];

  return [storeDatabaseCreatedAt compare:initialDatabaseCreatedAt] == NSOrderedDescending;
}

+ (void)replaceStoreDatabaseWithInitial {
  if ([self storeDatabaseExists]) {
    [[NSFileManager defaultManager] removeItemAtURL:[self storeDatabaseURL] error:nil];
  }

  [[NSFileManager defaultManager] copyItemAtURL:[self initialDatabaseURL] toURL:[self storeDatabaseURL] error:nil];
}

+ (BOOL)storeDatabaseExists {
  return [[NSFileManager defaultManager] fileExistsAtPath:[[self storeDatabaseURL] path]];
}

@end
