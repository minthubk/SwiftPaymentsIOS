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

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUAPNDeviceRequestFactory.h"
#import "LUKeychainAccess.h"
#import "NSData+LUAdditions.h"

NSString * const LUDeviceTokenKey = @"LUDeviceToken";

@implementation LUAPNDeviceRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestToRegisterAPNDeviceWithToken:(NSData *)deviceToken sandbox:(BOOL)sandbox {
  [[LUKeychainAccess standardKeychainAccess] setString:[deviceToken lu_hexString] forKey:LUDeviceTokenKey];

  NSDictionary *parameters = @{
    @"apn_device": @{
      @"sandbox": @(sandbox),
      @"token": [deviceToken lu_hexString]
    }
  };

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"apn_devices"
                                 apiVersion:LUAPIVersion15
                                 parameters:parameters
                               modelFactory:nil];
}

+ (LUAPIRequest *)requestToUnregisterCurrentAPNDevice {
  NSString *deviceToken = [[LUKeychainAccess standardKeychainAccess] stringForKey:LUDeviceTokenKey];
  if (!deviceToken) return nil;

  NSString *path = [NSString stringWithFormat:@"apn_devices/%@", deviceToken];

  return [LUAPIRequest apiRequestWithMethod:@"DELETE"
                                       path:path
                                 apiVersion:LUAPIVersion15
                                 parameters:@{@"api_key": [LUAPIClient sharedClient].apiKey}
                               modelFactory:nil];
}

@end
