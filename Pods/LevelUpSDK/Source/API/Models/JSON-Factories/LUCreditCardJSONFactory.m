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

#import "LUCreditCard.h"
#import "LUCreditCardJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUCreditCardJSONFactory

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSString *BIN = [attributes lu_stringForKey:@"bin"];
  NSString *creditCardDescription = [attributes lu_stringForKey:@"description"];
  NSNumber *creditCardID = [attributes lu_numberForKey:@"id"];
  BOOL debit = [attributes lu_boolForKey:@"debit"];
  NSNumber *expirationMonth = [attributes lu_numberForKey:@"expiration_month"];
  NSNumber *expirationYear = [attributes lu_numberForKey:@"expiration_year"];
  NSString *last4Digits = [attributes lu_stringForKey:@"last_4"];
  BOOL promoted = [attributes lu_boolForKey:@"promoted"];
  NSString *type = [attributes lu_stringForKey:@"type"];

  return [[LUCreditCard alloc] initWithBIN:BIN creditCardDescription:creditCardDescription creditCardID:creditCardID cvv:nil
                                     debit:debit expirationMonth:expirationMonth expirationYear:expirationYear
                               last4Digits:last4Digits number:nil postalCode:nil promoted:promoted
                                      type:type];
}

- (NSString *)rootKey {
  return @"credit_card";
}

@end
