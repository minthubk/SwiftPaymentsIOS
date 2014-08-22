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

#import "LUUser.h"
#import "LUUserGenderTransformer.h"

@interface LUUser ()

@property (nonatomic, assign, readonly) BOOL connectedToFacebook;

@end

@implementation LUUser

+ (void)load {
  [NSValueTransformer setValueTransformer:[[LUUserGenderTransformer alloc] init] forName:LUUserGenderTransformerName];
}

#pragma mark - Creation

- (id)initWithBirthdate:(NSDate *)birthdate causeID:(NSNumber *)causeID connectedToFacebook:(BOOL)connectedToFacebook
       customAttributes:(NSDictionary *)customAttributes debitCardOnly:(BOOL)debitCardOnly email:(NSString *)email
              firstName:(NSString *)firstName gender:(LUGender)gender globalCredit:(LUMonetaryValue *)globalCredit
               lastName:(NSString *)lastName merchantsVisitedCount:(NSNumber *)merchantsVisitedCount
            ordersCount:(NSNumber *)ordersCount termsAccepted:(BOOL)termsAccepted
           totalSavings:(LUMonetaryValue *)totalSavings userID:(NSNumber *)userID {
  self = [super init];
  if (!self) return nil;

  _birthdate = birthdate;
  _causeID = causeID;
  _connectedToFacebook = connectedToFacebook;
  _customAttributes = [customAttributes mutableCopy];
  _debitCardOnly = debitCardOnly;
  _email = email;
  _firstName = firstName;
  _gender = gender;
  _globalCredit = globalCredit;
  _lastName = lastName;
  _merchantsVisitedCount = merchantsVisitedCount;
  _ordersCount = ordersCount;
  _termsAccepted = termsAccepted;
  _totalSavings = totalSavings;
  _userID = userID;

  return self;
}

#pragma mark - Getters

- (NSMutableDictionary *)customAttributes {
  if (_customAttributes) return _customAttributes;
  _customAttributes = [NSMutableDictionary dictionary];
  return _customAttributes;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUUser [address=%p, birthdate=%@, causeID=%@, customAttributes=%@, debitCardOnly=%@, email=%@, firstName=%@, gender=%@, globalCredit=%@, ID=%@, lastName=%@, merchantsVisitedCount=%@, ordersCount=%@, termsAccepted=%@, totalSavings=%@]",
          self, self.birthdate, self.causeID, self.customAttributes, @(self.debitCardOnly), self.email, self.firstName,
          [[self class] genderStringForGender:self.gender], self.globalCredit, self.userID, self.lastName,
          self.merchantsVisitedCount, self.ordersCount, @(self.termsAccepted), self.totalSavings];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUUser [address=%p, firstName=%@, ID=%@, lastName=%@]", self, self.firstName,
          self.userID, self.lastName];
}

#pragma mark - Gender transformations

+ (LUGender)genderForGenderString:(NSString *)genderString {
  NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:LUUserGenderTransformerName];
  return [[transformer reverseTransformedValue:genderString] integerValue];
}

+ (NSString *)genderStringForGender:(LUGender)gender {
  NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:LUUserGenderTransformerName];
  return [transformer transformedValue:@(gender)];
}

@end
