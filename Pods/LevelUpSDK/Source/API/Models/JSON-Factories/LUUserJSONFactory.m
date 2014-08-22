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
#import "LUUser.h"
#import "LUUserJSONFactory.h"
#import "NSDictionary+ObjectClassAccess.h"

@implementation LUUserJSONFactory

#pragma mark - Public Methods

- (id)createFromAttributes:(NSDictionary *)attributes {
  NSDate *birthdate = [attributes lu_dateForKey:@"born_at"];
  NSNumber *causeID = [attributes lu_numberForKey:@"cause_id"];
  BOOL connectedToFacebook = [attributes lu_boolForKey:@"connected_to_facebook"];
  NSDictionary *customAttributes = [attributes lu_dictionaryForKey:@"custom_attributes"];
  BOOL debitCardOnly = [attributes lu_boolForKey:@"debit_card_only"];
  NSString *email = [attributes lu_stringForKey:@"email"];
  NSString *firstName = [attributes lu_stringForKey:@"first_name"];
  LUGender gender = [LUUser genderForGenderString:[attributes lu_stringForKey:@"gender"]];
  LUMonetaryValue *globalCredit = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"global_credit_amount"]];
  NSString *lastName = [attributes lu_stringForKey:@"last_name"];
  NSNumber *merchantsVisitedCount = [attributes lu_numberForKey:@"merchants_visited_count"];
  NSNumber *ordersCount = [attributes lu_numberForKey:@"orders_count"];
  BOOL termsAccepted = [attributes lu_dateForKey:@"terms_accepted_at"] != nil;
  LUMonetaryValue *totalSavings = [LUMonetaryValue monetaryValueWithUSCents:[attributes lu_numberForKey:@"total_savings_amount"]];
  NSNumber *userID = [attributes lu_numberForKey:@"id"];

  return [[LUUser alloc] initWithBirthdate:birthdate causeID:causeID connectedToFacebook:connectedToFacebook
                          customAttributes:customAttributes debitCardOnly:debitCardOnly email:email firstName:firstName
                                    gender:gender globalCredit:globalCredit lastName:lastName
                     merchantsVisitedCount:merchantsVisitedCount ordersCount:ordersCount termsAccepted:termsAccepted
                              totalSavings:totalSavings userID:userID];
}

- (NSString *)rootKey {
  return @"user";
}

@end
