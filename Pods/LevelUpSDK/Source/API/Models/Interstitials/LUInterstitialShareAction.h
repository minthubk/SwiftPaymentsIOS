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

/**
 This action is used for interstitials that present the user with options to share via email,
 Facebook or Twitter. The message properties are default text that can be used to pre-fill share
 dialogs -- the user can change the text if they wish.
 */
@interface LUInterstitialShareAction : LUAPIModel

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

- (id)initWithMessageForEmailBody:(NSString *)messageForEmailBody
           messageForEmailSubject:(NSString *)messageForEmailSubject
               messageForFacebook:(NSString *)messageForFacebook
                messageForTwitter:(NSString *)messageForTwitter
                    shareURLEmail:(NSURL *)shareURLEmail
                 shareURLFacebook:(NSURL *)shareURLFacebook
                  shareURLTwitter:(NSURL *)shareURLTwitter;

@end
