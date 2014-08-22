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

extern NSString * const LUDeviceTokenKey;

@class LUAPIRequest;

/**
 `LUAPNDeviceRequestFactory` is used to build requests for APN (Apple Push Notification) device
 tokens. If the app is going to handle push notifications, the device token must be registered with
 LevelUp, and unregistered if necessary.

 When an iOS app registers for push notifications,
 `application:didRegisterForRemoteNotificationsWithDeviceToken:` will be called on the application
 delegate. This device token needs to be registered with the LevelUp servers so that push
 notification can be delivered after an order is made.

 ## Best Practices

 As [described by Apple] [1] the process for registering for remote notifications is to first call
 `registerForRemoteNotificationTypes:`. Then the app delegate will receive
 `application:didRegisterForRemoteNotificationsWithDeviceToken:`. The device token will be passed to
 this method. Apple recommends that an application should register every time it launches.

 Any time a device token is registered, it should be sent to LevelUp via the SDK.

 [1]: http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/IPhoneOSClientImp/IPhoneOSClientImp.html#//apple_ref/doc/uid/TP40008194-CH103-SW1
*/
@interface LUAPNDeviceRequestFactory : NSObject

/**
 Builds a request to register an APN device with LevelUp.

 This method will also securely store the device token, so that it can be unregistered later.

 @warning This request requires an access token with either the `LUPermissionCreateOrders` or
 `LUPermissionReadQRCode` permission.
 @param deviceToken An APN device token to register.
 @param sandbox Specifies whether notifications should be sent to this device in sandbox mode (which
 uses Apple's sandbox notification server) or production (which uses Apple's production notification
 server). Typically this would match `LUAPIClient`'s development mode.
 */
+ (LUAPIRequest *)requestToRegisterAPNDeviceWithToken:(NSData *)deviceToken sandbox:(BOOL)sandbox;

/**
 Builds a request to unregister the current device token.

 This token will have been set by a previous call to `requestToRegisterAPNDeviceWithToken:sandbox:`.
 */
+ (LUAPIRequest *)requestToUnregisterCurrentAPNDevice;

@end
