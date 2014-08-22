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

#import "LUMonetaryValue.h"
#import "LUMonetaryValueJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUMonetaryValueJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSNumber *amount = [attributes lu_numberForKey:@"amount"];
  NSString *currencyCode = [attributes lu_stringForKey:@"currency_code"];
  NSString *currencySymbol = [attributes lu_stringForKey:@"currency_symbol"];
  NSString *formattedAmount = [attributes lu_stringForKey:@"formatted_amount"];

  return [[LUMonetaryValue alloc] initWithAmount:amount currencyCode:currencyCode
                                  currencySymbol:currencySymbol formattedAmount:formattedAmount];
}

@end
