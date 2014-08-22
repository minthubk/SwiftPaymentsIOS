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
#import "LUWebLinkJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUWebLinkJSONFactory

#pragma mark - Public Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSURL *deepLinkURL = [attributes lu_URLForKey:@"ios_deeplink_url"];
  NSString *title = [attributes lu_stringForKey:@"title"];
  NSNumber *webLinkTypeID = [attributes lu_numberForKey:@"web_link_type_id"];
  NSURL *webURL = [attributes lu_URLForKey:@"web_url"];

  return [[LUWebLink alloc] initWithDeepLinkURL:deepLinkURL
                                          title:title
                                  webLinkTypeID:webLinkTypeID
                                         webURL:webURL];
}

- (NSString *)rootKey {
  return @"web_link";
}

@end
