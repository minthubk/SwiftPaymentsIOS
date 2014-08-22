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

/**
 Deep Link Authorization allows you to request an access token from a LevelUp user using an
 app-switching model: the user will be deep linked into the LevelUp app, where they will be
 presented with a dialog describing the request. Upon responding to this request, the user will be
 bounced back into the requesting app.

 A request includes a list of permissions, such as the ability to create orders or to access their
 transaction history. An up-to-date list of permissions is available on the
 [LevelUp Developer Portal](http://developer.thelevelup.com/getting-started/permissions-list/).

 An authorization request is made using `authorizeWithPermissions:returnURLScheme:`. If there is
 a failure at any point in the request, a `LUDeepLinkAuthErrorNotification` notification
 will be sent. If this happens, the user info for the notification will contain an `NSError`
 instance under the key `LUDeepLinkAuthNotificationErrorKey`. This error will have
 `LUDeepLinkAuthErrorDomain` as the domain, and an appropriate value of `LUDeepLinkAuthErrorCode`
 as its code.

 In order for the SDK to handle the reponse back from the LevelUp app, a call to
 `handleOpenURL:sourceApplication:` must be made from your app delegate's
 `application:openURL:sourceApplication:annotation:` method.

 When a request succeeds, an LUDeepLinkAuthSuccessNotification will be sent. The user info
 for the notification will contain an access token string under the key
 `LUDeepLinkAuthNotificationAccessTokenKey`. Setting `accessToken` on `[LUAPIClient sharedClient]`
 to this token will allow the access token to be used on subsequent LevelUp API calls.
 */
@interface LUDeepLinkAuth : NSObject

/**
 Request the user to authorize using deep linking.

 @param permissions An array of strings, where each each string is the name of a requested
 permission. See http://developer.thelevelup.com/getting-started/permissions-list for a list of
 possible permissions.
 @param returnURLScheme The URL scheme to use in order to return the user to your app. This must be
 one of the custom URL schemes configured for your app. For more information, refer to Apple's
 documentation:
 https://developer.apple.com/library/ios/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/AdvancedAppTricks/AdvancedAppTricks.html#//apple_ref/doc/uid/TP40007072-CH7-SW50
 */
+ (void)authorizeWithPermissions:(NSArray *)permissions returnURLScheme:(NSString *)returnURLScheme;

/**
 This method must be called from the `application:openURL:sourceApplication:annotation:`
 method of your app delegate. Doing so allows the response from an auth request to be validated and
 completed.

 @param URL The url passed to `application:openURL:sourceApplication:annotation:`.
 @param sourceApplication The sourceApplication passed to
 `application:openURL:sourceApplication:annotation:`.
 @return YES If this URL was handled by the LevelUp SDK, else NO.
 */
+ (BOOL)handleOpenURL:(NSURL *)URL sourceApplication:(NSString *)sourceApplication;

/**
 Check if the Deep Link Auth app (LevelUp by default) is installed on the device.
 */
+ (BOOL)isDeepLinkAuthAppInstalled;

@end
