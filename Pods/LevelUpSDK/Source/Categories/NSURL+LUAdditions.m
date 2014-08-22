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

#import "AFNetworking.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "NSRegularExpression+LUAdditions.h"
#import "NSURL+LUAdditions.h"
#import <UIKit/UIKit.h>

@implementation NSURL (LUAdditions)

NSString * const LUPatternLeadingSlashOptionalVersion = @"^/(v\\d+/)?";

#pragma mark - Public Methods

+ (NSURL *)lu_imageURLForCampaignWithID:(NSNumber *)campaignID {
  if (!campaignID) return nil;

  NSString *path = [NSString stringWithFormat:@"campaigns/%@/image", [campaignID stringValue]];
  return [self imageURLForPath:path version:LUAPIVersion14];
}

+ (NSURL *)lu_imageURLForImageWithBase:(NSURL *)baseURL {
  if (!baseURL) return nil;

  NSString *imageURLStringWithParameters = [NSString stringWithFormat:@"%@?%@", [baseURL absoluteString], [self imageQueryString]];
  return [NSURL URLWithString:imageURLStringWithParameters];
}

+ (NSURL *)lu_imageURLForLocationWithID:(NSNumber *)locationID {
  if (!locationID) return nil;

  NSString *path = [NSString stringWithFormat:@"locations/%@/image", [locationID stringValue]];
  return [self imageURLForPath:path version:LUAPIVersion14];
}

+ (NSURL *)lu_imageURLForWebLinkTypeWithID:(NSNumber *)webLinkTypeID {
  if (!webLinkTypeID) return nil;

  NSString *path = [NSString stringWithFormat:@"%@/web_link_types/%@/image?density=%d&height=%d&width=%d",
                    LUAPIVersion15, [webLinkTypeID stringValue], (int)[UIScreen mainScreen].scale, 25, 25];
  return [NSURL URLWithString:path relativeToURL:[LUAPIClient sharedClient].baseURL];
}

+ (NSURL *)lu_URLWithScheme:(NSString *)scheme host:(NSString *)host path:(NSString *)path queryParameters:(NSDictionary *)queryParameters {
  NSString *URLString = [NSString stringWithFormat:@"%@://%@%@", scheme, host, path];

  return [[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:queryParameters error:nil] URL];
}

- (NSString *)lu_pathAndQueryWithoutAPIVersion {
  NSString *pathWithQuery = [self pathWithQuery];

  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:LUPatternLeadingSlashOptionalVersion
                                                                         options:0
                                                                           error:NULL];
  return [regex lu_removeMatchesInString:pathWithQuery];
}

- (NSDictionary *)lu_queryDictionary {
  NSMutableDictionary *result = [NSMutableDictionary dictionary];
  NSArray *parts = [[self query] componentsSeparatedByString:@"&"];

  for (NSString *part in parts) {
    if ([part length] == 0) {
      continue;
    }

    NSRange index = [part rangeOfString:@"="];
    NSString *key;
    NSString *value;

    if (index.location == NSNotFound) {
      key = part;
      value = @"";
    } else {
      key = [part substringToIndex:index.location];
      value = [part substringFromIndex:index.location + index.length];
    }

    key = [key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    if ([key hasSuffix:@"[]"]) {
      key = [key substringToIndex:key.length - 2];

      NSMutableArray *valueArray;
      if ([result[key] isKindOfClass:[NSMutableArray class]]) {
        valueArray = result[key];
      } else {
        valueArray = [NSMutableArray array];
        result[key] = valueArray;
      }

      [valueArray addObject:value];
    } else {
      result[key] = value;
    }
  }

  return result;
}

#pragma mark - Private Methods

+ (NSString *)imageQueryString {
  return [NSString stringWithFormat:@"density=%d&height=%d&width=%d", (int)[UIScreen mainScreen].scale, 212, 320];
}

+ (NSURL *)imageURLForPath:(NSString *)path version:(NSString *)version {
  NSString *fullPath = [NSString stringWithFormat:@"%@/%@?%@", version, path, [self imageQueryString]];

  return [NSURL URLWithString:fullPath relativeToURL:[LUAPIClient sharedClient].baseURL];
}

- (NSString *)pathWithQuery {
  if ([self query].length > 0) {
    return [NSString stringWithFormat:@"%@?%@", [self path], [self query]];
  } else {
    return [self path];
  }
}

@end
