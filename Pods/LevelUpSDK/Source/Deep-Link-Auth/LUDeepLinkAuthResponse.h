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

extern NSString * const LUDeepLinkAuthPaddedAccessTokenURLParam;
extern NSString * const LUDeepLinkAuthPermissionAcceptedURLParam;

@interface LUDeepLinkAuthResponse : NSObject

@property (nonatomic, assign, readonly) BOOL accepted;
@property (nonatomic, copy, readonly) NSString *paddedAccessToken;
@property (nonatomic, copy, readonly) NSString *sourceApplication;

- (id)initWithAccepted:(BOOL)accepted paddedAccessToken:(NSString *)paddedAccessToken
     sourceApplication:(NSString *)sourceApplication;
+ (instancetype)responseWithURL:(NSURL *)URL sourceApplication:(NSString *)sourceApplication;

+ (BOOL)isDeepLinkAuthResponseURL:(NSURL *)URL;
+ (NSURL *)responseURLWithScheme:(NSString *)scheme
                        accepted:(BOOL)accepted
               paddedAccessToken:(NSString *)paddedAccessToken;
- (NSString *)decodedAccessToken;
- (NSError *)validate;

@end
