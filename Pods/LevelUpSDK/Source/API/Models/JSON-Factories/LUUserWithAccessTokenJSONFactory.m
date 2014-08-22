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

#import "LUAccessToken.h"
#import "LUAccessTokenJSONFactory.h"
#import "LUUser.h"
#import "LUUserJSONFactory.h"
#import "LUUserWithAccessToken.h"
#import "LUUserWithAccessTokenJSONFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUUserWithAccessTokenJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUAccessToken *accessToken = [[LUAccessTokenJSONFactory factory] fromJSONObject:[attributes lu_safeValueForKey:@"access_token"]];
  LUUser *user = [[LUUserJSONFactory factory] fromJSONObject:[attributes lu_safeValueForKey:@"user"]];

  return [[LUUserWithAccessToken alloc] initWithAccessToken:accessToken user:user];
}

@end
