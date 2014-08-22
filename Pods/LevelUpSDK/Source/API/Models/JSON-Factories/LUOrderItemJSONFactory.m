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
#import "LUOrderItem.h"
#import "LUOrderItemJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUOrderItemJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *category = [attributes lu_stringForKey:@"category"];
  LUMonetaryValue *chargedPrice = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"charged_price_amount"]];
  NSString *itemDescription = [attributes lu_stringForKey:@"description"];
  NSString *name = [attributes lu_stringForKey:@"name"];
  NSUInteger quantity = [[attributes lu_numberForKey:@"quantity"] unsignedIntegerValue];
  NSString *SKU = [attributes lu_stringForKey:@"sku"];
  LUMonetaryValue *standardPrice = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"standard_price_amount"]];
  NSString *UPC = [attributes lu_stringForKey:@"upc"];

  return [[LUOrderItem alloc] initWithCategory:category chargedPrice:chargedPrice
                               itemDescription:itemDescription name:name quantity:quantity SKU:SKU
                                 standardPrice:standardPrice UPC:UPC];
}

- (NSString *)rootKey {
  return @"item";
}

@end
