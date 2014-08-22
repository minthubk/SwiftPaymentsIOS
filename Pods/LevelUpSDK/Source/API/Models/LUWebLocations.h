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

@interface LUWebLocations : LUAPIModel

- (id)initWithFacebookAddress:(NSString *)facebook
               foodlerAddress:(NSString *)foodler
                  menuAddress:(NSString *)menu
            newsletterAddress:(NSString *)newsletter
             opentableAddress:(NSString *)opentable
               twitterAddress:(NSString *)twitter
                  yelpAddress:(NSString *)yelp;

- (NSURL *)facebookURL;
- (NSURL *)foodlerURL;
- (NSURL *)menuURL;
- (NSURL *)newsletterURL;
- (NSURL *)opentableURL;
- (NSURL *)twitterURL;
- (NSURL *)yelpURL;

@end
