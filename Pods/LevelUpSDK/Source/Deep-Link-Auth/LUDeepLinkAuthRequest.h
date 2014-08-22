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

extern NSString * const LUDeepLinkAuthAppIDURLParam;
extern NSString * const LUDeepLinkAuthOneTimePadURLParam;
extern NSString * const LUDeepLinkAuthPermissionsURLParam;
extern NSString * const LUDeepLinkAuthReturnURLSchemeURLParam;

@class LUOneTimePad;

@interface LUDeepLinkAuthRequest : NSObject

@property (nonatomic, copy, readonly) NSString *appID;
@property (nonatomic, strong, readonly) LUOneTimePad *oneTimePad;
@property (nonatomic, copy, readonly) NSArray *permissions;
@property (nonatomic, copy, readonly) NSString *returnURLScheme;

- (id)initWithAppID:(NSString *)appID oneTimePad:(LUOneTimePad *)oneTimePad
        permissions:(NSArray *)permissions returnURLScheme:(NSString *)returnURLScheme;
- (id)initWithURL:(NSURL *)URL;
+ (instancetype)requestWithPermissions:(NSArray *)permissions
                       returnURLScheme:(NSString *)returnURLScheme;

- (NSURL *)URL;
- (NSError *)validateProperties;
- (NSError *)validateURL;

@end
