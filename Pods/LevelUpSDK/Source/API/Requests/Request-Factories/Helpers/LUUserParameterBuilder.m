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

#import "LUDeviceIdentifier.h"
#import "LUUser.h"
#import "LUUserParameterBuilder.h"
#import "NSDate+StringFormats.h"

@implementation LUUserParameterBuilder

#pragma mark - Public Methods

+ (NSDictionary *)parametersForUser:(LUUser *)user {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];

  [self addKey:@"born_at" toDictionary:params ifValuePresent:[user.birthdate lu_iso8601DateTimeString]];

  if (user.userID) {
    [self addKey:@"custom_attributes" toDictionary:params ifValuePresent:user.customAttributes];
  }

  [self addKey:@"device_identifier" toDictionary:params ifValuePresent:[LUDeviceIdentifier deviceIdentifier]];
  [self addKey:@"email" toDictionary:params ifValuePresent:user.email];
  [self addKey:@"first_name" toDictionary:params ifValuePresent:user.firstName];

  NSString *genderString = [[LUUser genderStringForGender:user.gender] lowercaseString];
  [self addKey:@"gender" toDictionary:params ifValuePresent:genderString];

  [self addKey:@"last_name" toDictionary:params ifValuePresent:user.lastName];

  if (user.userID) {
    [self addKey:@"new_password" toDictionary:params ifValuePresent:user.password];
  } else {
    [self addKey:@"password" toDictionary:params ifValuePresent:user.password];
  }

  params[@"terms_accepted"] = @(user.termsAccepted);

  return params;
}

#pragma mark - Private Methods

+ (void)addKey:(NSString *)key toDictionary:(NSMutableDictionary *)dictionary ifValuePresent:(id)value {
  if (value && (![value respondsToSelector:@selector(length)] || [value length] > 0)) {
    dictionary[key] = value;
  }
}

@end
