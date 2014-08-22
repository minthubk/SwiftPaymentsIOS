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

#import "LULocation.h"
#import "LULocationSummaryJSONFactory.h"
#import "NSDate+StringFormats.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULocationSummaryJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSArray *categoryIDs;

  if ([attributes[@"categories"] isKindOfClass:[NSArray class]]) {
    categoryIDs = attributes[@"categories"];
  }

  NSNumber *latitude = [attributes lu_numberForKey:@"latitude"];
  NSNumber *locationID = [attributes lu_numberForKey:@"id"];
  NSNumber *longitude = [attributes lu_numberForKey:@"longitude"];
  NSNumber *merchantID = [attributes lu_numberForKey:@"merchant_id"];
  NSString *merchantName = [attributes lu_stringForKey:@"merchant_name"];
  NSString *name = [attributes lu_stringForKey:@"name"];
  BOOL shown = [attributes lu_boolForKey:@"shown"];
  NSDate *updatedAtDate = [NSDate lu_dateFromIso8601DateTimeString:attributes[@"updated_at"]];

  return [[LULocation alloc] initWithCategoryIDs:categoryIDs latitude:latitude locationID:locationID longitude:longitude
                                      merchantID:merchantID merchantName:merchantName name:name shown:shown
                                   updatedAtDate:updatedAtDate];
}

- (NSString *)rootKey {
  return @"location";
}

@end
