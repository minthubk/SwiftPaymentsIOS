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
 An `LUOrderItem` represents a single item that was part of an order.
 */
@interface LUOrderItem : LUAPIModel

/**
 An optional category for this item.
 */
@property (nonatomic, copy, readonly) NSString *category;

/**
 The price for this item that was charged to the customer.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *chargedPrice;

/**
 An optional description of the item.
 */
@property (nonatomic, copy, readonly) NSString *itemDescription;

/**
 The name of the item.
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 The quantity of the item that was purchased.
 */
@property (nonatomic, assign, readonly) NSUInteger quantity;

/**
 An optional SKU (Stock Keeping Unit) code for this item.
 */
@property (nonatomic, copy, readonly) NSString *SKU;

/**
 An optional standard price for the item.
 */
@property (nonatomic, strong, readonly) LUMonetaryValue *standardPrice;

/**
 An optional UPC (Universal Product Code) for this item.
 */
@property (nonatomic, copy, readonly) NSString *UPC;

- (id)initWithCategory:(NSString *)category chargedPrice:(LUMonetaryValue *)chargedPrice
       itemDescription:(NSString *)itemDescription name:(NSString *)name
              quantity:(NSUInteger)quantity SKU:(NSString *)SKU
         standardPrice:(LUMonetaryValue *)standardPrice UPC:(NSString *)UPC;

@end
