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

#import "NSDictionary+SafetyAdditions.h"

@implementation NSDictionary (SafetyAdditions)

- (id)lu_safeValueForKey:(NSString *)key {
  id value = [self valueForKey:key];
  if (value == [NSNull null]) {
    value = nil;
  }

  return value;
}

@end

@implementation NSMutableDictionary (SafetyAdditions)

- (void)lu_setSafeValue:(id)value forKey:(NSString *)key {
  if (!value) {
    value = [NSNull null];
  }

  [self setValue:value forKey:key];
}

@end
