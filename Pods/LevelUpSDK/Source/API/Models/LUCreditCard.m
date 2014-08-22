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

@implementation LUCreditCard

#pragma mark - Creation

- (id)initWithBIN:(NSString *)BIN creditCardDescription:(NSString *)creditCardDescription creditCardID:(NSNumber *)creditCardID
                                cvv:(NSString *)cvv debit:(BOOL)debit expirationMonth:(NSNumber *)expirationMonth
                     expirationYear:(NSNumber *)expirationYear last4Digits:(NSString *)last4Digits
                             number:(NSString *)number postalCode:(NSString *)postalCode promoted:(BOOL)promoted
                               type:(NSString *)type {
  self = [super init];
  if (!self) return nil;

  _BIN = BIN;
  _creditCardDescription = creditCardDescription;
  _creditCardID = creditCardID;
  _cvv = cvv;
  _debit = debit;
  _expirationMonth = expirationMonth;
  _expirationYear = expirationYear;
  _last4Digits = last4Digits;
  _number = number;
  _postalCode = postalCode;
  _promoted = promoted;
  _type = type;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUCreditCard [address=%p, creditCardDescription=%@, cvv=%@, debit=%@, expirationMonth=%@, expirationYear=%@, ID=%@, last4Digits=%@, number=%@, postalCode=%@, promoted=%@, type=%@]",
          self, self.creditCardDescription, self.cvv, @(self.debit), self.expirationMonth,
          self.expirationYear, self.creditCardID, self.last4Digits, self.number, self.postalCode,
          @(self.promoted), self.type];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUCreditCard [address=%p, ID=%@, last4Digits=%@, type=%@]",
          self, self.creditCardID, self.last4Digits, self.type];
}

@end
