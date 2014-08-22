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
#import "LUInterstitial.h"
#import "NSString+HTMLStripping.h"
#import "NSURL+LUAdditions.h"

@implementation LUInterstitial {
  NSURL *_imageURL;
}

#pragma mark - Creation

- (id)initWithAction:(id)action actionType:(LUInterstitialActionType)actionType calloutText:(NSString *)calloutText
     descriptionHTML:(NSString *)descriptionHTML imageURL:(NSURL *)imageURL title:(NSString *)title {
  self = [super init];
  if (!self) return nil;

  _action = action;
  _actionType = actionType;
  _calloutText = calloutText;
  _descriptionHTML = descriptionHTML;
  _imageURL = imageURL;
  _title = title;

  return self;
}

#pragma mark - Public Methods

- (NSString *)actionTypeString {
  switch (self.actionType) {
    case LUInterstitialActionTypeUnknown:
      return @"unknown";

    case LUInterstitialActionTypeNone:
      return @"none";

    case LUInterstitialActionTypeClaim:
      return @"claim";

    case LUInterstitialActionTypeFeedback:
      return @"feedback";

    case LUInterstitialActionTypeShare:
      return @"share";

    case LUInterstitialActionTypeURL:
      return @"url";
  }
}

- (NSString *)descriptionText {
  return [self.descriptionHTML lu_stringByStrippingHTML];
}

- (NSURL *)imageURL {
  return [NSURL lu_imageURLForImageWithBase:_imageURL];
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUInterstitial [address=%p, action=%@, actionType=%@, calloutText=%@, descriptionHTML=%@, imageURL=%@, title=%@]",
          self, self.action, [self actionTypeString], self.calloutText, self.descriptionHTML,
          self.imageURL, self.title];
}

@end
