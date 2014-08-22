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

#import "BTEncryption.h"
#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUConstants.h"
#import "LUCreditCard.h"
#import "LUCreditCardJSONFactory.h"
#import "LUCreditCardRequestFactory.h"

@implementation LUCreditCardRequestFactory

#pragma mark - Public Methods

+ (LUAPIRequest *)requestForCreditCards {
  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:@"credit_cards"
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUCreditCardJSONFactory factory]];
}

+ (LUAPIRequest *)requestToCreateCreditCard:(LUCreditCard *)creditCard {
  NSString *braintreePublicKey = [LUAPIClient sharedClient].clientsideEncryptionKey;
  BTEncryption *braintree = [[BTEncryption alloc] initWithPublicKey:braintreePublicKey];

  NSDictionary *parameters = @{
    @"encrypted_cvv" : [braintree encryptString:creditCard.cvv],
    @"encrypted_expiration_month" : [braintree encryptString:[creditCard.expirationMonth stringValue]],
    @"encrypted_expiration_year" : [braintree encryptString:[creditCard.expirationYear stringValue]],
    @"encrypted_number" : [braintree encryptString:creditCard.number],
    @"postal_code" : [braintree encryptString:creditCard.postalCode]
  };

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:@"credit_cards"
                                 apiVersion:LUAPIVersion15
                                 parameters:@{@"credit_card" : parameters}
                               modelFactory:[LUCreditCardJSONFactory factory]];
}

+ (LUAPIRequest *)requestToDeleteCreditCardWithID:(NSNumber *)creditCardID {
  NSString *path = [NSString stringWithFormat:@"credit_cards/%@", creditCardID];

  return [LUAPIRequest apiRequestWithMethod:@"DELETE"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUCreditCardJSONFactory factory]];
}

+ (LUAPIRequest *)requestToPromoteCreditCardWithID:(NSNumber *)creditCardID {
  NSString *path = [NSString stringWithFormat:@"credit_cards/%@", creditCardID];

  return [LUAPIRequest apiRequestWithMethod:@"PUT"
                                       path:path
                                 apiVersion:LUAPIVersion14
                                 parameters:nil
                               modelFactory:[LUCreditCardJSONFactory factory]];
}

@end
