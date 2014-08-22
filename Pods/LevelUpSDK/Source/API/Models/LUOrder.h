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

@class LUMonetaryValue;

/**
 `LUOrder` represents an order made using LevelUp.
 */
@interface LUOrder : LUAPIModel

/**
 The amount of money that will be (or has been) charged to the user for this order.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *balance;

/**
 The date that this order's bundle was closed. If this is `nil`, then this order hasn't been closed.
 */
@property (nonatomic, copy, readonly) NSDate *bundleClosedDate;

/**
 The descriptor that will appear on the user's statement, if this order has been closed.
 */
@property (nonatomic, copy, readonly) NSString *bundleDescriptor;

/**
 The contribution associated with this order (if one was made).
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *contribution;

/**
 The name of the contribution associated with this order, if one was made.
 */
@property (nonatomic, strong, readonly) NSString *contributionTargetName;

/**
 The date that this order was created.
 */
@property (nonatomic, copy, readonly) NSDate *createdDate;

/**
 The amount of credit applied to this order.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *credit;

/**
 The amount of credit the user earned with this purchase.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *earn;

/**
 An optional array of `LUOrderItem` instances.
 */
@property (nonatomic, strong, readonly) NSArray *items;

/**
 An optional "extended" address for the location at which this order was made. An example would be
 an apartment number.
 */
@property (nonatomic, copy, readonly) NSString *locationExtendedAddress;

/**
 The ID of the location at which this order was made.
 */
@property (nonatomic, copy, readonly) NSNumber *locationID;

/**
 The town or city of the location at which this order was made.
 */
@property (nonatomic, copy, readonly) NSString *locationLocality;

/**
 The name of the location at which this order was made.
*/
@property (nonatomic, copy, readonly) NSString *locationName;

/**
 The postal code of the location at which this order was made.
 */
@property (nonatomic, copy, readonly) NSString *locationPostalCode;

/**
 The region of the location at which this order was made.
 */
@property (nonatomic, copy, readonly) NSString *locationRegion;

/**
 The street address of the location at which this order was made.
 */
@property (nonatomic, copy, readonly) NSString *locationStreetAddress;

/**
 The ID of the merchant at which this order was made.
 */
@property (nonatomic, copy, readonly) NSNumber *merchantID;

/**
 The name of the merchant at which this order was made.
 */
@property (nonatomic, copy, readonly) NSString *merchantName;

/**
 If this order has been refunded, the date that this order was refunded. If the order hasn't been
 refunded, this will be `nil`.
 */
@property (nonatomic, copy, readonly) NSDate *refundedDate;

/**
 The amount the user spent for this order, not including tip.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *spend;

/**
 The tip made for this order.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *tip;

/**
 The sum of `spend` and `tip`.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *total;

/**
 The date that this order was transacted.
 */
@property (nonatomic, copy, readonly) NSDate *transactedDate;

/**
 The unique identifier for this order.
 */
@property (nonatomic, copy, readonly) NSString *UUID;

/**
 Specifies if an order is closed.
 */
- (BOOL)closed;

/**
 Specifies if a contribution was made on this order.
 */
- (BOOL)hasContribution;

/**
 Specifies if the user earned credit on this order.
 */
- (BOOL)hasEarnedCredit;

/**
 Specifies if this order has a non-zero balance.
 */
- (BOOL)hasNonZeroBalance;

/**
 Specifies if this order included a tip.
 */
- (BOOL)hasTipApplied;

/**
 Specifies if credit was used on this order.
 */
- (BOOL)hasUsedCredit;

/**
 An associated image for the order's location. Will automatically return a retina or non-retina
 scaled image based on the screen scale of the device. The resolution is 320x212.
 */
- (NSURL *)imageURL;

/**
 A helper method which returns all the address fields in one line. The format is
 "<full street address>, <locality>, <region> <postal code>". For example: "123 Main Street, Apt 2A,
 Boston, MA 01234".
 */
- (NSString *)singleLineAddress;

/**
 Specifies if this order has been refunded.
 */
- (BOOL)wasRefunded;

- (id)initWithBalance:(LUMonetaryValue *)balance bundleClosedDate:(NSDate *)bundleClosedDate
     bundleDescriptor:(NSString *)bundleDescriptor contribution:(LUMonetaryValue *)contribution
contributionTargetName:(NSString *)contributionTargetName createdDate:(NSDate *)createdDate
               credit:(LUMonetaryValue *)credit earn:(LUMonetaryValue *)earn items:(NSArray *)items
locationExtendedAddress:(NSString *)locationExtendedAddress locationID:(NSNumber *)locationID
     locationLocality:(NSString *)locationLocality locationName:(NSString *)locationName
   locationPostalCode:(NSString *)locationPostalCode locationRegion:(NSString *)locationRegion
locationStreetAddress:(NSString *)locationStreetAddress merchantID:(NSNumber *)merchantID
         merchantName:(NSString *)merchantName refundedDate:(NSDate *)refundedDate
                spend:(LUMonetaryValue *)spend tip:(LUMonetaryValue *)tip
                total:(LUMonetaryValue *)total transactedDate:(NSDate *)transactedDate
                 UUID:(NSString *)UUID;

@end
