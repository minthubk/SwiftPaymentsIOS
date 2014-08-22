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
 `LUPaymentToken` is a payment token used to represent a user when they make a transaction. The
 payment token's data is presented in a QR code, which is scanned when the user pays. Each payment
 token is scoped to the app which is requesting it.
 */
@interface LUPaymentToken : LUAPIModel

/**
 This payment token's data. Use the `LUQRCodeGenerator` class to generate QR codes from this data
 which include the user's tip selection.
*/
@property (nonatomic, copy, readonly) NSString *data;

/**
 The unique identifier for this payment token.
 */
@property (nonatomic, copy, readonly) NSNumber *paymentTokenID;

- (id)initWithData:(NSString *)data paymentTokenID:(NSNumber *)paymentTokenID;

@end
