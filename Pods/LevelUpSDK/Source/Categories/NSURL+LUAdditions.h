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

@interface NSURL (LUAdditions)

+ (NSURL *)lu_imageURLForCampaignWithID:(NSNumber *)campaignID;
+ (NSURL *)lu_imageURLForImageWithBase:(NSURL *)baseURL;
+ (NSURL *)lu_imageURLForLocationWithID:(NSNumber *)locationID;
+ (NSURL *)lu_imageURLForWebLinkTypeWithID:(NSNumber *)webLinkTypeID;
+ (NSURL *)lu_URLWithScheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path queryParameters:(NSDictionary *)queryParameters;
- (NSString *)lu_pathAndQueryWithoutAPIVersion;
- (NSDictionary *)lu_queryDictionary;

@end
