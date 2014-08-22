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
#import "LUAPIRequest.h"
#import "LULocationRequestFactory.h"
#import "LULocationSummaryJSONFactory.h"
#import "LULocationJSONFactory.h"
#import "LUWebLinkJSONFactory.h"
#import "NSURL+LUAdditions.h"

@implementation LULocationRequestFactory

+ (LUAPIRequest *)requestForAppLocationsNearLocation:(CLLocation *)location {
  NSString *requestPath = [NSString stringWithFormat:@"apps/%@/locations", [LUAPIClient sharedClient].appID];
  NSDictionary *params = @{@"lat" : @(location.coordinate.latitude), @"lng" : @(location.coordinate.longitude)};

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:requestPath
                                 apiVersion:LUAPIVersion14
                                 parameters:params
                               modelFactory:[LULocationJSONFactory factory]];
}

+ (LUAPIRequest *)requestForAppLocationsOnPage:(NSURL *)pageURL {
  if (!pageURL) return [self requestForLocationSummaries];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:[pageURL lu_pathAndQueryWithoutAPIVersion]
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationJSONFactory factory]];
}

+ (LUAPIRequest *)requestForLocationSummaries {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"locations"
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationSummaryJSONFactory factory]];
}

+ (LUAPIRequest *)requestForLocationSummariesOnPage:(NSURL *)pageURL {
  if (!pageURL) return [self requestForLocationSummaries];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:[pageURL lu_pathAndQueryWithoutAPIVersion]
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationSummaryJSONFactory factory]];
}

+ (LUAPIRequest *)requestForLocationWithID:(NSNumber *)locationID {
  NSString *requestPath = [@"locations/" stringByAppendingString:[locationID stringValue]];
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:requestPath
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LULocationJSONFactory factory]];
}

+ (LUAPIRequest *)requestForWebLinksAtLocationWithID:(NSNumber *)locationID {
  NSString *requestPath = [NSString stringWithFormat:@"locations/%@/web_links", [locationID stringValue]];
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:requestPath
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUWebLinkJSONFactory factory]];
}

@end
