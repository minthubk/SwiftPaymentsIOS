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

#import "LUAPIError.h"
#import "LUAPIErrorJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUAPIErrorJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *code = [attributes lu_stringForKey:@"code"];
  NSString *message = [attributes lu_stringForKey:@"message"];
  NSString *object = [attributes lu_stringForKey:@"object"];
  NSString *property = [attributes lu_stringForKey:@"property"];

  return [[LUAPIError alloc] initWithCode:code message:message object:object property:property];
}

- (NSString *)rootKey {
  return @"error";
}

@end
