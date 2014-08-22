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

#import "LUWebLink.h"
#import "NSURL+LUAdditions.h"

@implementation LUWebLink

#pragma mark - Creation

- (id)initWithDeepLinkURL:(NSURL *)deepLinkURL title:(NSString *)title
            webLinkTypeID:(NSNumber *)webLinkTypeID webURL:(NSURL *)webURL {
  self = [super init];
  if (!self) return nil;

  _deepLinkURL = deepLinkURL;
  _title = title;
  _webLinkTypeID = webLinkTypeID;
  _webURL = webURL;

  return self;
}

#pragma mark - Public Methods

- (NSURL *)imageURL {
  return [NSURL lu_imageURLForWebLinkTypeWithID:self.webLinkTypeID];
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUWebLink [address=%p, deepLinkURL=%@, title=%@, webLinkTypeID=%@, webURL=%@]",
          self, self.deepLinkURL, self.title, self.webLinkTypeID, self.webURL];
}

@end
