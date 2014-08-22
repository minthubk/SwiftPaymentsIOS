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

/** Types of interstitial actions. */
typedef NS_ENUM(NSInteger, LUInterstitialActionType) {
  /** An unrecognized action type was returned. The interstitial should be ignored. */
  LUInterstitialActionTypeUnknown,

  /** The interstitial has no action: it is designed to show information to the user. */
  LUInterstitialActionTypeNone,

  /** The user will be asked to claim a campaign. */
  LUInterstitialActionTypeClaim,

  /** The user will be asked to rate their experience and provide comments. */
  LUInterstitialActionTypeFeedback,

  /** The user can share information related to the order via email, Facebook or Twitter. */
  LUInterstitialActionTypeShare,

  /** The interstitial will include a URL that the user can view. */
  LUInterstitialActionTypeURL
};

/**
 An order may be associated with an `LUInterstital`, which represents an interstitial view that can
 be shown to the user. Interstitials can be used for things like showing additional information to
 the user, prompting them to share information about the merchant, or claiming a campaign.

 An interstitial may optionally have an action for the user to complete. There are several possible
 actions based on the `actionType`. See `LUInterstitialActionType` for a full list of types.

 The `action` property of `LUInterstitialAction` will contain additional properties relevant to the
 particular type. It may be `nil` (if the action type is "none" or "unknown"), or it may be an
 instance of `LUInterstitialClaimAction`, `LUInterstitialFeedbackAction`,
 `LUInterstitialShareAction`, or `LUInterstitialURLAction`.
 */
@interface LUInterstitial : LUAPIModel

/**
 An object with information about the action that this interstitial is requesting from the user.

 The type of this property depends on the value of the `actionType` property:

 - `LUInterstitialActionTypeUnknown`: This property will be `nil`.
 - `LUInterstitialActionTypeNone`: This property will be `nil`.
 - `LUInterstitialActionTypeClaim`: This property will be an instance of `LUInterstitialClaimAction`.
 - `LUInterstitialActionTypeFeedback`: This property will be an instance of
 `LUInterstitialFeedbackAction`.
 - `LUInterstitialActionTypeShare`: This property will be an instance of `LUInterstitialShareAction`.
 - `LUInterstitialActionTypeURL`: This property will be an instance of `LUInterstitialURLAction`.
 */
@property (nonatomic, strong, readonly) id action;

/**
 The type of action this interstitial is requesting.

 Will be one of: `LUInterstitialActionTypeUnknown`, `LUInterstitialActionTypeNone`,
 `LUInterstitialActionTypeClaim`, `LUInterstitialActionTypeFeedback`,
 `LUInterstitialActionTypeShare`, or `LUInterstitialActionTypeURL`.
 */
@property (nonatomic, assign, readonly) LUInterstitialActionType actionType;

/**
 The callout text for the interstitial.
 */
@property (nonatomic, copy, readonly) NSString *calloutText;

/**
 An HTML description of the interstitial.
 */
@property (nonatomic, copy, readonly) NSString *descriptionHTML;

/**
 An image for this interstitial. Will automatically return a retina or non-retina scaled image based
 on the screen scale of the device. The resolution is 320x212.
 */
@property (nonatomic, strong, readonly) NSURL *imageURL;

/**
 The title of the interstitial.
 */
@property (nonatomic, copy, readonly) NSString *title;

/**
 Returns an `NSString` for this interstitial's `actionType`.
 */
- (NSString *)actionTypeString;

/**
 A helper method which returns the `descriptionHTML` stripped of HTML tags.
 */
- (NSString *)descriptionText;

- (id)initWithAction:(id)action actionType:(LUInterstitialActionType)actionType calloutText:(NSString *)calloutText
     descriptionHTML:(NSString *)descriptionHTML imageURL:(NSURL *)imageURL title:(NSString *)title;

@end
