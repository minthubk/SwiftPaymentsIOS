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

#import "LUMonetaryValueJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"
#import "NSDate+StringFormats.h"

@implementation NSDictionary (ObjectClassAccess)

#pragma mark - Public Methods

- (NSArray *)lu_arrayForKey:(id)aKey {
  return [self lu_objectForKey:aKey ofClass:[NSArray class]];
}

- (BOOL)lu_boolForKey:(id)aKey {
  NSNumber *numberValue = [self lu_numberForKey:aKey];
  if (!numberValue) return NO;

  return [numberValue boolValue];
}

- (NSDate *)lu_dateForKey:(id)aKey {
  NSString *stringValue = [self lu_stringForKey:aKey];
  if (!stringValue) return nil;

  return [NSDate lu_dateFromIso8601DateTimeString:stringValue];
}

- (NSDictionary *)lu_dictionaryForKey:(id)aKey {
  return [self lu_objectForKey:aKey ofClass:[NSDictionary class]];
}

- (float)lu_floatForKey:(id)aKey {
  NSNumber *numberValue = [self lu_numberForKey:aKey];
  if (!numberValue) return 0.0f;

  return [numberValue floatValue];
}

- (NSNumber *)lu_numberForKey:(id)aKey {
  NSNumber *number = [self lu_objectForKey:aKey ofClass:[NSNumber class]];
  if (number) return number;

  NSString *string = [self lu_stringForKey:aKey];
  if (!string) return nil;

  NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
  return [formatter numberFromString:string];
}

- (NSString *)lu_stringForKey:(id)aKey {
  NSString *string = [self lu_objectForKey:aKey ofClass:[NSString class]];
  if (string.length == 0) return nil;
  return string;
}

- (NSURL *)lu_URLForKey:(id)aKey {
  NSString *string = [self lu_objectForKey:aKey ofClass:[NSString class]];
  if (!string) return nil;

  return [NSURL URLWithString:string];
}

#pragma mark - Private Methods

- (id)lu_objectForKey:(id)aKey ofClass:(Class)aClass {
  id value = [self objectForKey:aKey];
  if (!value || ![value isKindOfClass:aClass]) return nil;

  return value;
}

@end
