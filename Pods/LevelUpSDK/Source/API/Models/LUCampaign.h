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

#import "LUAPIModel.h"

@class LUMonetaryValue;

/**
 LevelUp campaigns are general objects used by merchants and advertisers. They are typically used by
 merchants to acquire new customers and/or re-engage new customers.

 ## Campaigns

 Applications built on the LevelUp SDK will usually interact with campaigns in one of several ways:

 - Users may scan QR codes representing a campaign, which will then claim the campaign for them, and
 show a success screen providing more information about the campaign, and ways to share the campaign
 online.
 - Each user has a unique referral code which they can share with their friends. If someone joins
 LevelUp using their code, both the referring user and the new user will get LevelUp credit. Behind
 the scenes, these referral programs are implemented using "Refer-a-Friend" campaigns.
 - Some merchants support migration of loyalty cards into LevelUp credit. These are handled by
 "Legacy Loyalty" campaigns.

 ## Sharing

 Some campaigns can be shared by users. Currently, sharing by email, Facebook, and Twitter is
 supported. If the campaign allows sharing, the campaign will contain initial text that can be used
 to prefill the sharing dialogs.
 */
@interface LUCampaign : LUAPIModel

/**
 The unique identifier for this campaign.
 */
@property (nonatomic, copy, readonly) NSNumber *campaignID;

/**
 An HTML message to show the user after claiming the campaign.
 */
@property (nonatomic, copy, readonly) NSString *confirmationHTML;

/**
 Specifies that the campaign is global, which means that it applies to all merchants -- if a user
 claims it, they will receive global credit that can be used at any LevelUp merchant.
 */
@property (nonatomic, assign, readonly) BOOL global;

/**
 A suggested initial email body to use when a user shares this campaign over email.
 */
@property (nonatomic, copy, readonly) NSString *messageForEmailBody;

/**
 A suggested initial email subject to use when a user shares this campaign over email.
 */
@property (nonatomic, copy, readonly) NSString *messageForEmailSubject;

/**
 A suggested initial post to use when a user shares this campaign over Facebook.
 */
@property (nonatomic, copy, readonly) NSString *messageForFacebook;

/**
 A suggested initial post to use when a user shares this campaign over Twitter.
 */
@property (nonatomic, copy, readonly) NSString *messageForTwitter;

/**
 The name of the campaign.
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 An HTML message describing the campaign.
 */
@property (nonatomic, copy, readonly) NSString *offerHTML;

/**
 Specifies if this campaign can be shared.
 */
@property (nonatomic, assign, readonly) BOOL shareable;

/**
 The URL to use when sharing this campaign via email. Note that this will be included in the email
 body by the server, so it does not need to be added to the email body.
 */
@property (nonatomic, copy, readonly) NSURL *shareURLEmail;

/**
 The URL to use when sharing this campaign via Facebook.
 */
@property (nonatomic, copy, readonly) NSURL *shareURLFacebook;

/**
 The URL to use when sharing this campaign via Twitter.
 */
@property (nonatomic, copy, readonly) NSURL *shareURLTwitter;

/**
 The campaign's sponsor.
 */
@property (nonatomic, copy, readonly) NSString *sponsor;

/**
 The monetary value of the campaign. This is the amount of credit the user will receive after
 claiming.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *value;

- (id)initWithCampaignID:(NSNumber *)campaignID confirmationHTML:(NSString *)confirmationHTML global:(BOOL)global
     messageForEmailBody:(NSString *)messageForEmailBody messageForEmailSubject:(NSString *)messageForEmailSubject
      messageForFacebook:(NSString *)messageForFacebook messageForTwitter:(NSString *)messageForTwitter
                    name:(NSString *)name offerHTML:(NSString *)offerHTML shareable:(BOOL)shareable
           shareURLEmail:(NSURL *)shareURLEmail shareURLFacebook:(NSURL *)shareURLFacebook
         shareURLTwitter:(NSURL *)shareURLTwitter sponsor:(NSString *)sponsor value:(LUMonetaryValue *)value;

/**
 A helper method which returns `confirmationHTML` stripped of HTML tags.
 */
- (NSString *)confirmationText;

/**
 An associated image for the campaign. Will automatically return a retina or non-retina scaled image
 based on the screen scale of the device. The resolution of the image is 320x212.
 */
- (NSURL *)imageURL;

/**
 A helper method which returns the `offerHTML` stripped of HTML tags.
 */
- (NSString *)offerText;

@end
