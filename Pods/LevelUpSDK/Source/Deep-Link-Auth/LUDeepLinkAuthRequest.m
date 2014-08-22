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
#import "LUDeepLinkAuth.h"
#import "LUDeepLinkAuthRequest.h"
#import "LUOneTimePad.h"
#import "NSData+LUAdditions.h"
#import "NSError+LUAdditions.h"
#import "NSURL+LUAdditions.h"

NSString * const LUDeepLinkAuthAppIDURLParam = @"app_id";
NSString * const LUDeepLinkAuthOneTimePadURLParam = @"otp";
NSString * const LUDeepLinkAuthPermissionsURLParam = @"permissions";
NSString * const LUDeepLinkAuthReturnURLSchemeURLParam = @"return_url_scheme";

@implementation LUDeepLinkAuthRequest

#pragma mark - Object Lifecycle Methods

- (id)initWithAppID:(NSString *)appID oneTimePad:(LUOneTimePad *)oneTimePad
        permissions:(NSArray *)permissions returnURLScheme:(NSString *)returnURLScheme {
  self = [super init];
  if (!self) return nil;

  _appID = appID;
  _oneTimePad = oneTimePad;
  _permissions = permissions;
  _returnURLScheme = returnURLScheme;

  return self;
}

- (id)initWithURL:(NSURL *)URL {
  NSDictionary *params = [URL lu_queryDictionary];

  return [self initWithAppID:params[LUDeepLinkAuthAppIDURLParam]
                  oneTimePad:[LUOneTimePad oneTimePadWithBase64EncodedString:params[LUDeepLinkAuthOneTimePadURLParam]]
                 permissions:params[LUDeepLinkAuthPermissionsURLParam]
             returnURLScheme:params[LUDeepLinkAuthReturnURLSchemeURLParam]];
}

+ (instancetype)requestWithPermissions:(NSArray *)permissions
                       returnURLScheme:(NSString *)returnURLScheme {
  return [[self alloc] initWithAppID:[LUAPIClient sharedClient].appID
                          oneTimePad:[LUOneTimePad saveNewOneTimePad]
                         permissions:permissions
                     returnURLScheme:returnURLScheme];
}

#pragma mark - Public Methods

- (NSURL *)URL {
  return [NSURL lu_URLWithScheme:[LUAPIClient sharedClient].deepLinkAuthURLScheme
                            host:LUDeepLinkAuthRequestHost
                            path:@"/"
                 queryParameters:[self URLParameters]];
}

- (NSError *)validateProperties {
  if ([self.appID length] == 0) {
    return [NSError lu_deepLinkAuthErrorWithCode:LUDeepLinkAuthErrorAppIDRequired
                                     description:@"An appID is required."];
  }

  if ([self.oneTimePad length] == 0) {
    return [NSError lu_deepLinkAuthErrorWithCode:LUDeepLinkAuthErrorOneTimePadRequired
                                     description:@"A one-time pad is required."];
  }

  if ([self.permissions count] == 0) {
    return [NSError lu_deepLinkAuthErrorWithCode:LUDeepLinkAuthErrorPermissionsRequired
                                     description:@"At least one permission is required."];
  }

  if ([self.returnURLScheme length] == 0) {
    return [NSError lu_deepLinkAuthErrorWithCode:LUDeepLinkAuthErrorReturnURLSchemeRequired
                                     description:@"A return URL scheme is required."];
  }

  return nil;
}

- (NSError *)validateURL {
  if (![LUDeepLinkAuth isDeepLinkAuthAppInstalled]) {
    return [NSError lu_deepLinkAuthErrorWithCode:LUDeepLinkAuthErrorAppNotInstalled
                                     description:@"Unable to open Deep Link Auth app"];
  }

  return [self validateProperties];
}

#pragma mark - Private Methods

- (NSDictionary *)URLParameters {
  return @{
    LUDeepLinkAuthAppIDURLParam: self.appID,
    LUDeepLinkAuthOneTimePadURLParam: [self.oneTimePad base64Encoding],
    LUDeepLinkAuthPermissionsURLParam: self.permissions,
    LUDeepLinkAuthReturnURLSchemeURLParam: self.returnURLScheme
  };
}

@end
