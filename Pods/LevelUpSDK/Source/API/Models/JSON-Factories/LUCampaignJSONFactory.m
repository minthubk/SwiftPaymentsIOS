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

#import "LUCampaign.h"
#import "LUCampaignJSONFactory.h"
#import "LUMonetaryValue.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCampaignJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *campaignID = [attributes lu_numberForKey:@"id"];
  NSString *confirmationHTML = [attributes lu_stringForKey:@"confirmation_html"];
  BOOL global = [attributes lu_boolForKey:@"applies_to_all_merchants"];
  NSString *messageForEmailBody = [attributes lu_stringForKey:@"message_for_email_body"];
  NSString *messageForEmailSubject = [attributes lu_stringForKey:@"message_for_email_subject"];
  NSString *messageForFacebook = [attributes lu_stringForKey:@"message_for_facebook"];
  NSString *messageForTwitter = [attributes lu_stringForKey:@"message_for_twitter"];
  NSString *name = [attributes lu_stringForKey:@"name"];
  NSString *offerHTML = [attributes lu_stringForKey:@"offer_html"];
  BOOL shareable = [attributes lu_boolForKey:@"shareable"];
  NSURL *shareURLEmail = [attributes lu_URLForKey:@"share_url_email"];
  NSURL *shareURLFacebook = [attributes lu_URLForKey:@"share_url_facebook"];
  NSURL *shareURLTwitter = [attributes lu_URLForKey:@"share_url_twitter"];
  NSString *sponsor = [attributes lu_stringForKey:@"sponsor"];
  LUMonetaryValue *value = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"value_amount"]];

  return [[LUCampaign alloc] initWithCampaignID:campaignID confirmationHTML:confirmationHTML global:global
                            messageForEmailBody:messageForEmailBody messageForEmailSubject:messageForEmailSubject
                             messageForFacebook:messageForFacebook messageForTwitter:messageForTwitter name:name
                                      offerHTML:offerHTML shareable:shareable shareURLEmail:shareURLEmail
                                          shareURLFacebook:shareURLFacebook shareURLTwitter:shareURLTwitter
                                        sponsor:sponsor value:value];
}

- (NSString *)rootKey {
  return @"campaign";
}

@end
