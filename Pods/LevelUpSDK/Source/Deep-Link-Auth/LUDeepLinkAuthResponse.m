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
#import "LUConstants.h"
#import "LUDeepLinkAuthResponse.h"
#import "LUOneTimePad.h"
#import "NSData+LUAdditions.h"
#import "NSError+LUAdditions.h"
#import "NSURL+LUAdditions.h"

NSString * const LUDeepLinkAuthPaddedAccessTokenURLParam = @"padded_access_token";
NSString * const LUDeepLinkAuthPermissionAcceptedURLParam = @"permission_accepted";

@implementation LUDeepLinkAuthResponse

#pragma mark - Object Lifecycle Methods

- (id)initWithAccepted:(BOOL)accepted paddedAccessToken:(NSString *)paddedAccessToken
     sourceApplication:(NSString *)sourceApplication {
  self = [super init];
  if (!self) return nil;

  _accepted = accepted;
  _paddedAccessToken = paddedAccessToken;
  _sourceApplication = sourceApplication;

  return self;
}

+ (instancetype)responseWithURL:(NSURL *)URL sourceApplication:(NSString *)sourceApplication {
  NSDictionary *params = [URL lu_queryDictionary];

  return [[self alloc] initWithAccepted:[params[LUDeepLinkAuthPermissionAcceptedURLParam] isEqualToString:@"1"]
                      paddedAccessToken:params[LUDeepLinkAuthPaddedAccessTokenURLParam]
                      sourceApplication:sourceApplication];
}

#pragma mark - Public Methods

+ (BOOL)isDeepLinkAuthResponseURL:(NSURL *)URL {
  return [[URL host] isEqualToString:LUDeepLinkAuthResponseHost];
}

+ (NSURL *)responseURLWithScheme:(NSString *)scheme
                        accepted:(BOOL)accepted
               paddedAccessToken:(NSString *)paddedAccessToken {
  NSDictionary *params = @{
    LUDeepLinkAuthPaddedAccessTokenURLParam: paddedAccessToken ?: @"",
    LUDeepLinkAuthPermissionAcceptedURLParam: @(accepted)
  };

  return [NSURL lu_URLWithScheme:scheme host:LUDeepLinkAuthResponseHost path:@"/" queryParameters:params];
}

- (NSString *)decodedAccessToken {
  return [[LUOneTimePad loadOneTimePad] decodeString:self.paddedAccessToken];
}

- (NSError *)validate {
  if (![[LUAPIClient sharedClient].deepLinkAuthBundleID isEqualToString:self.sourceApplication]) {
    return [NSError lu_deepLinkAuthErrorWithCode:LUDeepLinkAuthErrorWrongSourceApplication
                                     description:@"Source application does not match deepLinkAuthBundleID in LUAPIClient"];
  }

  if (!self.accepted) {
    return [NSError lu_deepLinkAuthErrorWithCode:LUDeepLinkAuthErrorRequestRejected
                                     description:@"Deep Link Auth request was not accepted by the user"];
  }

  if ([[self decodedAccessToken] length] == 0) {
    return [NSError lu_deepLinkAuthErrorWithCode:LUDeepLinkAuthErrorMalformedResponse
                                     description:@"Access token in Deep Link Auth response was malformed"];
  }

  return nil;
}

@end
