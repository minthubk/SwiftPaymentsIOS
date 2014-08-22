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

#import "LUAPIModel.h"

/**
 A user's credit card to use for billing. Users can have any number of credit cards, but one will be
 marked as `promoted`, which mean it will be the first card attempted when a new charge needs to be
 made.
 */
@interface LUCreditCard : LUAPIModel

/**
 A string representing the BIN for the card in Braintree. This can be used to identify the origin of
 a specific card.
 */
@property (nonatomic, copy, readonly) NSString *BIN;

/**
 A string that describes the credit card. Includes the card's type and last 4 digits.
 */
@property (nonatomic, copy, readonly) NSString *creditCardDescription;

/**
 The unique identifier for this credit card.
 */
@property (nonatomic, copy, readonly) NSNumber *creditCardID;

/**
 The credit card's CVV (card verification value).
 */
@property (nonatomic, copy) NSString *cvv;

/**
 Specifies if the card is a debit card.
 */
@property (nonatomic, assign, readonly) BOOL debit;

/**
 The card's expiration month, as a number from 1 to 12.
 */
@property (nonatomic, copy) NSNumber *expirationMonth;

/**
 The card's expiration year as a four digit number (e.g. 2013).
 */
@property (nonatomic, copy) NSNumber *expirationYear;

/**
 The last 4 digits of the credit card. This is returned by the server, and does not need to be set
 when creating a new card.
 */
@property (nonatomic, copy, readonly) NSString *last4Digits;

/**
 The credit card number. Should be set when creating a credit card. Will be nil when retrieving
 cards from the server.
 */
@property (nonatomic, copy) NSString *number;

/**
 The postal code (zip code) associated with the card.
 */
@property (nonatomic, copy) NSString *postalCode;

/**
 Specifies if the card is currently promoted.
 */
@property (nonatomic, assign) BOOL promoted;

/**
 The credit card type (e.g. Visa, MasterCard, etc). This will be returned by the server, but is not
 required when creating credit cards.
 */
@property (nonatomic, copy, readonly) NSString *type;

- (id)initWithBIN:(NSString *)BIN creditCardDescription:(NSString *)creditCardDescription creditCardID:(NSNumber *)creditCardID
                                cvv:(NSString *)cvv debit:(BOOL)debit expirationMonth:(NSNumber *)expirationMonth
                     expirationYear:(NSNumber *)expirationYear last4Digits:(NSString *)last4Digits
                             number:(NSString *)number postalCode:(NSString *)postalCode promoted:(BOOL)promoted
                               type:(NSString *)type;

@end
