<p align="center">
  <img src="https://levelup-assets.s3.amazonaws.com/images/email/email_logo.png" />
</p>

The [LevelUp](https://www.thelevelup.com) SDK allows developers to build apps that integrate with the LevelUp platform.

# Overview

The primary purpose of the SDK is to make it easy to issue requests to the LevelUp platform. It provides a layer on top of LevelUp's REST API. Requests may be things like signing up, logging or viewing nearby merchants. In addition, the SDK contains several utility classes to help with scanning and generating QR codes. Read below for additional information, or check out the [complete documentation](http://thelevelup.github.io/levelup-sdk-ios/) for a look at all the classes available with the SDK.

The recommended way to access the LevelUp SDK is through [CocoaPods](http://cocoapods.org/).

# Interacting with the API

## Performing Requests

Interactions with the LevelUp API occur through the [LUAPIClient](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUAPIClient.html) class. This is a singleton class through which all requests are performed.

Before issuing any requests, you must register an App ID and API key. This is done using the `setupWithAppID:APIKey:` method:

```objective-c
[LUAPIClient setupWithAppID:APP_ID APIKey:API_KEY];
```

An API request is an instance of [LUAPIRequest](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUAPIRequest.html). The SDK includes a set of request factories in order to create these requests (see "Request Factories" below).

Requests are performed by calling `performRequest:success:failure:`:

```objective-c
LUAPIRequest *request = [LUUserRequestFactory requestForCurrentUser];
[[LUAPIClient sharedClient] performRequest:request
                                   success:^(LUUser *user) {
                                     NSLog(@"Retrieved user: %@", user);
                                   }
                                   failure:^(NSError *error) {
                                     NSLog(@"Error while retrieving user: %@");
                                   }];
```

When the API call is successful, the `success` block will be called, and will be passed a result. This result differs for each call; for example, a request for the current user returns an `LUUser`, while a request for nearby merchants would return an `NSArray` of `LUMerchant` objects. The documentation for each request factory specifies the object which will be passed to `success`.

If the API request fails, an `NSError` instance will be passed to the `failure` block. The `userInfo` dictionary for this `NSError` has keys with several additional pieces of information:

- `LUAPIFailingURLRequestErrorKey`: An `NSURLRequest` containing the request.
- `LUAPIFailingURLResponseErrorKey`: An `NSURLResponse` containing the response.
- `LUAPIFailingErrorMessageErrorKey`: An optional error message from the server.
- `LUAPIFailingJSONResponseErrorKey`: An optional JSON response from the server.

## Models

The SDK includes model classes for LevelUp domain objects, such as a user or a merchant. Instances of these objects may be returned from API calls, or may be referenced from other model objects.

* **[LUAccessToken](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUAccessToken.html)**: An access token is created when a user successfully logs in, and is used to maintain an authentication session.
* **[LUCampaign](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUCampaign.html)**: Campaigns are promotions which can be claimed by users.
* **[LUCategory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUCategory.html)**: A merchant category, such as "Italian" or "Bar".
* **[LUClaim](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUClaim.html)**: Represents a user's claim on a campaign.
* **[LUCohort](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUCohort.html)**: When a user claims a campaign, they do so through a cohort. This could be through a social network or a particular advertisement.
* **[LUCreditCard](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUCreditCard.html)**: Users have one or more credit cards to use as payment methods.
* **[LUInterstitial](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUInterstitial.html)**: Interstitial actions may be shown on some merchant or receipt screens to promote a campaign.
* **[LULocation](http://thelevelup.github.io/levelup-sdk-ios/Classes/LULocation.html)**: A merchant has one or more locations, which are physical places users can pay.
* **[LULoyalty](http://thelevelup.github.io/levelup-sdk-ios/Classes/LULoyalty.html)**: Contains information about a user's loyalty progress at a specific merchant.
* **[LUMonetaryValue](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUMonetaryValue.html)**: Represents an amount of money of a specific currency.
* **[LUOrder](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUOrder.html)**: An order that has been placed using LevelUp.
* **[LUPaymentToken](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUPaymentToken.html)**: The user's payment token.
* **[LUUser](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUUser.html)**: Represents a user of LevelUp.

## Request Factories

The SDK includes a set of request factories, which generate a particular `LUAPIRequest`. Some may require additional input, such as a merchant ID, which must be provided in order to retrieve a given merchant.

Below is the full list of request factories:

* [LUAPNDeviceRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUAPNDeviceRequestFactory.html)
* [LUAuthenticationRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUAuthenticationRequestFactory.html)
* [LUCampaignRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUCampaignRequestFactory.html)
* [LUCategoryRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUCategoryRequestFactory.html)
* [LUClaimRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUClaimRequestFactory.html)
* [LUCohortRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUCohortRequestFactory.html)
* [LUCreditCardRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUCreditCardRequestFactory.html)
* [LUInterstitialRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUInterstitialRequestFactory.html)
* [LULocationRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LULocationRequestFactory.html)
* [LULoyaltyRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LULoyaltyRequestFactory.html)
* [LUOrderRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUOrderRequestFactory.html)
* [LUPaymentTokenRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUPaymentTokenRequestFactory.html)
* [LUTicketRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUTicketRequestFactory.html)
* [LUUserRequestFactory](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUUserRequestFactory.html)

# Generating and Scanning Codes

A core feature of an app built on the LevelUp platform is the ability to display QR codes (so that users can pay) and to scan QR codes (so that users can claim campaigns). The SDK provides two classes to assist with these actions.

## Generating Codes

The [LUPaymentQRCodeGenerator](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUPaymentQRCodeGenerator.html) class is used to generate a `UIImage` containing user's QR code, along with optional information such as a tip percentage.

To generate a QR code for an arbitrary `NSString`, use [LUGenericQRCodeGenerator](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUGenericQRCodeGenerator.html).

## Scanning Codes

[LUQRCodeScannerView](http://thelevelup.github.io/levelup-sdk-ios/Classes/LUQRCodeScannerView.html) is a `UIView` that handles scanning QR codes. It is provided with a delegate to be notified when a scan is successful.

# Testing

The SDK contains several optional classes to assist in testing. These can be included through a CocoaPods subspec called "Testing". The header file for these classes is `LevelUpSDKTesting.h`.

There are two main categories of testing classes: factories and network stubs.

## Factories

To aid in testing, fake test instances of all the main LevelUp SDK classes are available. These are added in categories to the classes. For example, getting a test user is as simple as calling `[LUUser fakeInstance]`. For a full list of fake instances, see the header files in `Testing/Factories`.

## Network Stubs

Network stubs are also provided for all common requests. These allow you to stub out network calls so that canned responses are returned instead of connecting to the server. This is done transparently to your code.

Use the `LUAPIStubbing` class to manage stubs. The `addStub:` method adds a stub, and `clearStubs` clears all stubs. Two optional methods are also available: `disableNetConnect` and `raiseOnUnexpectedRequest:`. The `disableNetConnect` method will block all network requests and return an error for any request that does not match a stub. The related `raiseOnUnexpectedRequest:` method will cause an exception to also be raised when this happens. This can be useful for finding places where stubs need to be added.

Stubs are instances of the `LUAPIStub` class. `LUAPIStubFactory` provides methods to create stubs for many of the common use cases of the API. See `LUAPIStubFactory.h` in `Testing/Network-Responses` for a full list of methods.

Here's a simple example of how to use network stubs:

```objective-c
[[LUAPIStubbing sharedInstance] disableNetConnect];
[[LUAPIStubbing sharedInstance] addStub:[LUAPIStubFactory stubToGetCurrentUser]];

LUAPIRequest *request = [LUUserRequestFactory requestForCurrentUser];
[[LUAPIClient sharedClient] performRequest:request
                                   success:^(LUUser *user) {
                                     // ...
                                   }
                                   failure:^(NSError *error) {
                                     // ...
                                   }];

[[LUAPIStubbing sharedInstance] clearStubs];
```

# Developer Terms

By enabling LevelUp integrations, including through this SDK, you agree
to LevelUp's [developer
terms](https://www.thelevelup.com/developer-terms).

# Copyright

Copyright (C) 2014 SCVNGR, Inc. d/b/a LevelUp

The LevelUp SDK is available under the Apache 2.0 license. See the LICENSE file for more information.
