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
#import "LUCampaign.h"
#import "LUMonetaryValue.h"
#import "NSString+HTMLStripping.h"
#import "NSURL+LUAdditions.h"

@implementation LUCampaign

#pragma mark - Creation

- (id)initWithCampaignID:(NSNumber *)campaignID confirmationHTML:(NSString *)confirmationHTML global:(BOOL)global
     messageForEmailBody:(NSString *)messageForEmailBody messageForEmailSubject:(NSString *)messageForEmailSubject
      messageForFacebook:(NSString *)messageForFacebook messageForTwitter:(NSString *)messageForTwitter
                    name:(NSString *)name offerHTML:(NSString *)offerHTML shareable:(BOOL)shareable
           shareURLEmail:(NSURL *)shareURLEmail shareURLFacebook:(NSURL *)shareURLFacebook
         shareURLTwitter:(NSURL *)shareURLTwitter sponsor:(NSString *)sponsor value:(LUMonetaryValue *)value {
  self = [super init];
  if (!self) return nil;

  _campaignID = campaignID;
  _confirmationHTML = confirmationHTML;
  _global = global;
  _messageForEmailBody = messageForEmailBody;
  _messageForEmailSubject = messageForEmailSubject;
  _messageForFacebook = messageForFacebook;
  _messageForTwitter = messageForTwitter;
  _name = name;
  _offerHTML = offerHTML;
  _shareable = shareable;
  _shareURLEmail = shareURLEmail;
  _shareURLFacebook = shareURLFacebook;
  _shareURLTwitter = shareURLTwitter;
  _sponsor = sponsor;
  _value = value;

  return self;
}


#pragma mark - Public Methods

- (NSString *)confirmationText {
  return [self.confirmationHTML lu_stringByStrippingHTML];
}

- (NSURL *)imageURL {
  return [NSURL lu_imageURLForCampaignWithID:self.campaignID];
}

- (NSString *)offerText {
  return [self.offerHTML lu_stringByStrippingHTML];
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUCampaign [address=%p, confirmationHTML=%@, global=%@, messageForEmailBody=%@, messageForEmailSubject=%@, messageForFacebook=%@, messageForTwitter=%@, ID=%@, name=%@, offerHTML=%@, shareable=%@, shareURLEmail=%@, shareURLFacebook=%@, shareURLTwitter=%@, sponsor=%@, value=%@]",
          self, self.confirmationHTML, @(self.global), self.messageForEmailBody, self.messageForEmailSubject,
          self.messageForFacebook, self.messageForTwitter, self.campaignID, self.name, self.offerHTML,
          @(self.shareable), self.shareURLEmail, self.shareURLFacebook, self.shareURLTwitter, self.sponsor, self.value];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCampaign [address=%p, ID=%@, name=%@, value=%@]", self, self.campaignID, self.name, self.value];
}

@end
