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

#import "LUInterstitialShareAction.h"

@implementation LUInterstitialShareAction

#pragma mark - Creation

- (id)initWithMessageForEmailBody:(NSString *)messageForEmailBody
           messageForEmailSubject:(NSString *)messageForEmailSubject
               messageForFacebook:(NSString *)messageForFacebook
                messageForTwitter:(NSString *)messageForTwitter
                    shareURLEmail:(NSURL *)shareURLEmail
                 shareURLFacebook:(NSURL *)shareURLFacebook
                  shareURLTwitter:(NSURL *)shareURLTwitter {
  self = [super init];
  if (!self) return nil;

  _messageForEmailBody = messageForEmailBody;
  _messageForEmailSubject = messageForEmailSubject;
  _messageForFacebook = messageForFacebook;
  _messageForTwitter = messageForTwitter;
  _shareURLEmail = shareURLEmail;
  _shareURLFacebook = shareURLFacebook;
  _shareURLTwitter = shareURLTwitter;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUInterstitialShareAction [address=%p, messageForEmailBody=%@, messageForEmailSubject=%@, messageForFacebook=%@, messageForTwitter=%@, shareURLEmail=%@, shareURLFacebook=%@, shareURLTwitter=%@]",
          self, self.messageForEmailBody, self.messageForEmailSubject, self.messageForFacebook,
          self.messageForTwitter, self.shareURLEmail, self.shareURLFacebook, self.shareURLTwitter];
}

@end
