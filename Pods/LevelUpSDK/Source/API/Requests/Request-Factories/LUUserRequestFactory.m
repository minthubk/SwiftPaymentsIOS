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
#import "LUDeviceIdentifier.h"
#import "LUUser.h"
#import "LUUserJSONFactory.h"
#import "LUUserParameterBuilder.h"
#import "LUUserRequestFactory.h"
#import "LUUserWithAccessTokenJSONFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUUserRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCurrentUser {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"users"
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUUserJSONFactory factory]];
}

+ (LUAPIRequest *)requestForUserWithID:(NSNumber *)userID {
  NSString *path = [NSString stringWithFormat:@"users/%@", userID];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUUserJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateUser:(LUUser *)user {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  params[@"api_key"] = [LUAPIClient sharedClient].apiKey;
  params[@"user"] = [LUUserParameterBuilder parametersForUser:user];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"users"
                                 apiVersion:LUAPIVersion14
                                 parameters:params
                               modelFactory:[LUUserJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateUser:(LUUser *)user withPermissions:(NSArray *)permissions {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  params[@"api_key"] = [LUAPIClient sharedClient].apiKey;
  params[@"permission_keynames"] = permissions;

  params[@"user"] = [NSMutableDictionary dictionary];
  [params[@"user"] lu_setSafeValue:user.email forKey:@"email"];
  [params[@"user"] lu_setSafeValue:user.firstName forKey:@"first_name"];
  [params[@"user"] lu_setSafeValue:user.lastName forKey:@"last_name"];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"apps/users"
                                 apiVersion:LUAPIVersion15
                                 parameters:params
                               modelFactory:[LUUserWithAccessTokenJSONFactory factory]];
}

+ (LUAPIRequest *)requestToResetPasswordWithEmail:(NSString *)email {
  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"passwords"
                                 apiVersion:LUAPIVersion14
                                 parameters:@{@"email" : email}
                               modelFactory:nil];
}

+ (LUAPIRequest *)requestToUpdateUser:(LUUser *)user {
  return [LUAPIRequest apiRequestWithMethod:@"PUT"
                                       path:@"users"
                                 apiVersion:LUAPIVersion15
                                 parameters:@{@"user" : [LUUserParameterBuilder parametersForUser:user]}
                               modelFactory:[LUUserJSONFactory factory]];
}

@end
