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

#import "LUInterstitial.h"
#import "LUInterstitialClaimAction.h"
#import "LUInterstitialFeedbackAction.h"
#import "LUInterstitialJSONFactory.h"
#import "LUInterstitialShareAction.h"
#import "LUInterstitialURLAction.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUInterstitialJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  LUInterstitialActionType actionType = [self actionTypeFromString:[attributes lu_stringForKey:@"type"]];
  id action = [self actionForType:actionType withAttributes:attributes[@"action"]];
  NSString *calloutText = [attributes lu_stringForKey:@"callout_text"];
  NSString *descriptionHTML = [attributes lu_stringForKey:@"description_html"];
  NSURL *imageURL = [attributes lu_URLForKey:@"image_url"];
  NSString *title = [attributes lu_stringForKey:@"title"];

  return [[LUInterstitial alloc] initWithAction:action actionType:actionType calloutText:calloutText
                                descriptionHTML:descriptionHTML imageURL:imageURL title:title];
}

- (NSString *)rootKey {
  return @"interstitial";
}

#pragma mark - Private Methods

- (id)actionForType:(LUInterstitialActionType)actionType withAttributes:(NSDictionary *)attributes {
  switch (actionType) {
    case LUInterstitialActionTypeClaim:
      return [self claimActionWithAttributes:attributes];

    case LUInterstitialActionTypeFeedback:
      return [self feedbackActionWithAttributes:attributes];

    case LUInterstitialActionTypeShare:
      return [self shareActionWithAttributes:attributes];

    case LUInterstitialActionTypeURL:
      return [self URLActionWithAttributes:attributes];

    default:
      return nil;
  }
}

- (LUInterstitialActionType)actionTypeFromString:(NSString *)typeString {
  if ([typeString isEqualToString:@"share"]) {
    return LUInterstitialActionTypeShare;
  } else if ([typeString isEqualToString:@"claim"]) {
    return LUInterstitialActionTypeClaim;
  } else if ([typeString isEqualToString:@"feedback"] || [typeString isEqualToString:@"collect_feedback"]) {
    return LUInterstitialActionTypeFeedback;
  } else if ([typeString isEqualToString:@"url"]) {
    return LUInterstitialActionTypeURL;
  } else if ([typeString isEqualToString:@"no_action"]) {
    return LUInterstitialActionTypeNone;
  } else {
    return LUInterstitialActionTypeUnknown;
  }
}

- (LUInterstitialClaimAction *)claimActionWithAttributes:(NSDictionary *)attributes {
  NSString *campaignCode = [attributes lu_stringForKey:@"code"];
  return [[LUInterstitialClaimAction alloc] initWithCampaignCode:campaignCode];
}

- (LUInterstitialFeedbackAction *)feedbackActionWithAttributes:(NSDictionary *)attributes {
  NSString *questionText = [attributes lu_stringForKey:@"question_text"];
  return [[LUInterstitialFeedbackAction alloc] initWithQuestionText:questionText];
}

- (LUInterstitialShareAction *)shareActionWithAttributes:(NSDictionary *)attributes {
  NSString *messageForEmailBody = [attributes lu_stringForKey:@"message_for_email_body"];
  NSString *messageForEmailSubject = [attributes lu_stringForKey:@"message_for_email_subject"];
  NSString *messageForFacebook = [attributes lu_stringForKey:@"message_for_facebook"];
  NSString *messageForTwitter = [attributes lu_stringForKey:@"message_for_twitter"];
  NSURL *shareURLEmail = [attributes lu_URLForKey:@"share_url_email"];
  NSURL *shareURLFacebook = [attributes lu_URLForKey:@"share_url_facebook"];
  NSURL *shareURLTwitter = [attributes lu_URLForKey:@"share_url_twitter"];
  return [[LUInterstitialShareAction alloc] initWithMessageForEmailBody:messageForEmailBody
                                                 messageForEmailSubject:messageForEmailSubject
                                                     messageForFacebook:messageForFacebook
                                                      messageForTwitter:messageForTwitter
                                                          shareURLEmail:shareURLEmail
                                                       shareURLFacebook:shareURLFacebook
                                                        shareURLTwitter:shareURLTwitter];
}

- (LUInterstitialURLAction *)URLActionWithAttributes:(NSDictionary *)attributes {
  NSURL *URL = [attributes lu_URLForKey:@"url"];
  return [[LUInterstitialURLAction alloc] initWithURL:URL];
}

@end
