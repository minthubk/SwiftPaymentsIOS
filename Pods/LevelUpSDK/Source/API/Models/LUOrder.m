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

#import "LUAPIClient.h"
#import "LUAPIRequest.h"
#import "LUMonetaryValue.h"
#import "LUOrder.h"
#import "NSURL+LUAdditions.h"

@implementation LUOrder

#pragma mark - Creation

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
                 UUID:(NSString *)UUID {
  self = [super init];
  if (!self) return nil;

  _balance = balance;
  _bundleClosedDate = bundleClosedDate;
  _bundleDescriptor = bundleDescriptor;
  _contribution = contribution;
  _contributionTargetName = contributionTargetName;
  _createdDate = createdDate;
  _credit = credit;
  _earn = earn;
  _items = items;
  _locationExtendedAddress = locationExtendedAddress;
  _locationID = locationID;
  _locationLocality = locationLocality;
  _locationName = locationName;
  _locationPostalCode = locationPostalCode;
  _locationRegion = locationRegion;
  _locationStreetAddress = locationStreetAddress;
  _merchantID = merchantID;
  _merchantName = merchantName;
  _refundedDate = refundedDate;
  _spend = spend;
  _tip = tip;
  _total = total;
  _transactedDate = transactedDate;
  _UUID = UUID;

  return self;
}

#pragma mark - Public Methods

- (BOOL)closed {
  return self.bundleClosedDate != nil;
}

- (BOOL)hasContribution {
  return [self.contribution.amount floatValue] > 0.0f;
}

- (BOOL)hasEarnedCredit {
  return [self.earn.amount floatValue] > 0.0f;
}

- (BOOL)hasNonZeroBalance {
  return [self.balance.amount floatValue] != 0.0f;
}

- (BOOL)hasTipApplied {
  return [self.tip.amount floatValue] > 0.0f;
}

- (BOOL)hasUsedCredit {
  return [self.credit.amount floatValue] > 0.0f;
}

- (NSURL *)imageURL {
  return [NSURL lu_imageURLForLocationWithID:self.locationID];
}

- (NSString *)singleLineAddress {
  NSString *fullStreetAddress;

  if (self.locationExtendedAddress.length > 0) {
    fullStreetAddress = [NSString stringWithFormat:@"%@, %@", self.locationStreetAddress, self.locationExtendedAddress];
  } else {
    fullStreetAddress = self.locationStreetAddress;
  }

  return [NSString stringWithFormat:@"%@, %@, %@ %@", fullStreetAddress, self.locationLocality, self.locationRegion,
          self.locationPostalCode];
}

- (BOOL)wasRefunded {
  return self.refundedDate != nil;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LUOrder [address=%p, balance=%@, bundleClosedDate=%@, bundleDescriptor=%@, contribution=%@, contributionTargetName=%@, createdDate=%@, credit=%@, earn=%@, items=%@, locationExtendedAddress=%@, locationID=%@, locationLocality=%@, locationName=%@, locationPostalCode=%@, locationRegion=%@, locationStreetAddress=%@, merchantID=%@, merchantName=%@, refundedDate=%@, spend=%@, tip=%@, total=%@, transactedDate=%@, UUID=%@]",
          self, self.balance, self.bundleClosedDate, self.bundleDescriptor, self.contribution,
          self.contributionTargetName, self.createdDate, self.credit, self.earn, self.items,
          self.locationExtendedAddress, self.locationID, self.locationLocality, self.locationName,
          self.locationPostalCode, self.locationRegion, self.locationStreetAddress, self.merchantID,
          self.merchantName, self.refundedDate, self.spend, self.tip, self.total,
          self.transactedDate, self.UUID];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LUOrder [address=%p, merchantName=%@, total=%@, UUID=%@]",
          self, self.merchantName, self.total, self.UUID];
}

@end
