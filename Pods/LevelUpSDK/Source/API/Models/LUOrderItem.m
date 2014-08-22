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

#import "LUOrderItem.h"

@implementation LUOrderItem

#pragma mark - Creation

- (id)initWithCategory:(NSString *)category chargedPrice:(LUMonetaryValue *)chargedPrice
       itemDescription:(NSString *)itemDescription name:(NSString *)name
              quantity:(NSUInteger)quantity SKU:(NSString *)SKU
         standardPrice:(LUMonetaryValue *)standardPrice UPC:(NSString *)UPC {
  self = [super init];
  if (!self) return nil;

  _category = category;
  _chargedPrice = chargedPrice;
  _itemDescription = itemDescription;
  _name = name;
  _quantity = quantity;
  _SKU = SKU;
  _standardPrice = standardPrice;
  _UPC = UPC;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:@"LUOrderItem [address=%p, category=%@, chargedPrice=%@, itemDescription=%@, name=%@, quantity=%@, SKU=%@, standardPrice=%@, UPC=%@]",
          self, self.category, self.chargedPrice, self.itemDescription, self.name, @(self.quantity),
          self.SKU, self.standardPrice, self.UPC];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrderItem [address=%p, chargedPrice=%@, quantity=%@, SKU=%@]",
          self, self.chargedPrice, @(self.quantity), self.SKU];
}

@end
