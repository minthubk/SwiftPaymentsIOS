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

#import "LUAccessTokenJSONFactory.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAuthenticationRequestFactory.h"
#import "LUDeviceIdentifier.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUAuthenticationRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToLoginWithEmail:(NSString *)email password:(NSString *)password {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:email forKey:@"username"];
  [parameters lu_setSafeValue:password forKey:@"password"];
  [parameters lu_setSafeValue:[LUAPIClient sharedClient].apiKey forKey:@"api_key"];
  [parameters lu_setSafeValue:[LUDeviceIdentifier deviceIdentifier] forKey:@"device_identifier"];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"access_tokens"
                                 apiVersion:LUAPIVersion14
                                 parameters:@{@"access_token": parameters}
                               modelFactory:[LUAccessTokenJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateDowngradedAccessTokenWithPermissions:(NSArray *)permissions {
  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"access_tokens/downgrades"
                                 apiVersion:LUAPIVersion15
                                 parameters:@{@"access_token": @{@"permission_keynames": permissions}}
                               modelFactory:[LUAccessTokenJSONFactory factory]];
}

@end
