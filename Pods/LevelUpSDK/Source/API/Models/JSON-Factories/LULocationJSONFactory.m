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
#import "LULocationJSONFactory.h"
#import "LUWebLocations.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LULocationJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSArray *categoryIDs = [attributes lu_arrayForKey:@"categories"];
  NSString *descriptionHTML = [attributes lu_stringForKey:@"description_html"];
  NSString *extendedAddress = [attributes lu_stringForKey:@"extended_address"];
  NSString *hours = [attributes lu_stringForKey:@"hours"];
  NSNumber *latitude = [attributes lu_numberForKey:@"latitude"];
  NSString *locality = [attributes lu_stringForKey:@"locality"];
  NSNumber *locationID = [attributes lu_numberForKey:@"id"];
  NSNumber *longitude = [attributes lu_numberForKey:@"longitude"];
  NSNumber *merchantID = [attributes lu_numberForKey:@"merchant_id"];
  NSString *merchantName = [attributes lu_stringForKey:@"merchant_name"];
  NSString *name = [attributes lu_stringForKey:@"name"];
  NSString *phone = [attributes lu_stringForKey:@"phone"];
  NSString *postalCode = [attributes lu_stringForKey:@"postal_code"];
  NSString *region = [attributes lu_stringForKey:@"region"];
  BOOL shown = [attributes lu_boolForKey:@"shown"];
  NSString *streetAddress = [attributes lu_stringForKey:@"street_address"];
  LUWebLocations *webLocations = [[LUWebLocations alloc] initWithFacebookAddress:[attributes lu_stringForKey:@"facebook_url"]
                                                                  foodlerAddress:[attributes lu_stringForKey:@"foodler_url"]
                                                                     menuAddress:[attributes lu_stringForKey:@"menu_url"]
                                                               newsletterAddress:[attributes lu_stringForKey:@"newsletter_url"]
                                                                opentableAddress:[attributes lu_stringForKey:@"opentable_url"]
                                                                  twitterAddress:[attributes lu_stringForKey:@"twitter_url"]
                                                                     yelpAddress:[attributes lu_stringForKey:@"yelp_url"]];
  NSDate *updatedAtDate = [attributes lu_dateForKey:@"updated_at"];

  return [[LULocation alloc] initWithCategoryIDs:categoryIDs descriptionHTML:descriptionHTML extendedAddress:extendedAddress
                                           hours:hours latitude:latitude locality:locality locationID:locationID longitude:longitude
                                      merchantID:merchantID merchantName:merchantName name:name phone:phone postalCode:postalCode
                                          region:region shown:shown streetAddress:streetAddress updatedAtDate:updatedAtDate
                                    webLocations:webLocations];
}

- (NSString *)rootKey {
  return @"location";
}

@end
