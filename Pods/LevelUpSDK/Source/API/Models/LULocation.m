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
#import "LULocation.h"
#import "NSURL+LUAdditions.h"

@implementation LULocation

#pragma mark - Creation

- (id)initWithCategoryIDs:(NSArray *)categoryIDs descriptionHTML:(NSString *)descriptionHTML
          extendedAddress:(NSString *)extendedAddress hours:(NSString *)hours latitude:(NSNumber *)latitude
                 locality:(NSString *)locality locationID:(NSNumber *)locationID longitude:(NSNumber *)longitude
               merchantID:(NSNumber *)merchantID merchantName:(NSString *)merchantName name:(NSString *)name
                    phone:(NSString *)phone postalCode:(NSString *)postalCode region:(NSString *)region
                    shown:(BOOL)shown streetAddress:(NSString *)streetAddress updatedAtDate:(NSDate *)updatedAtDate
             webLocations:(LUWebLocations *)webLocations {
  self = [super init];
  if (!self) return nil;

  _categoryIDs = categoryIDs;
  _descriptionHTML = descriptionHTML;
  _extendedAddress = extendedAddress;
  _hours = hours;
  _latitude = latitude;
  _locality = locality;
  _locationID = locationID;
  _longitude = longitude;
  _merchantID = merchantID;
  _merchantName = merchantName;
  _name = name;
  _phone = phone;
  _postalCode = postalCode;
  _region = region;
  _shown = shown;
  _streetAddress = streetAddress;
  _summary = NO;
  _updatedAtDate = updatedAtDate;
  _webLocations = webLocations;

  return self;
}

- (id)initWithCategoryIDs:(NSArray *)categoryIDs latitude:(NSNumber *)latitude locationID:(NSNumber *)locationID
                longitude:(NSNumber *)longitude merchantID:(NSNumber *)merchantID merchantName:(NSString *)merchantName
                    name:(NSString *)name shown:(BOOL)shown updatedAtDate:(NSDate *)updatedAtDate {
  self = [super init];
  if (!self) return nil;

  _categoryIDs = categoryIDs;
  _latitude = latitude;
  _locationID = locationID;
  _longitude = longitude;
  _merchantID = merchantID;
  _merchantName = merchantName;
  _name = name;
  _shown = shown;
  _summary = YES;
  _updatedAtDate = updatedAtDate;

  return self;
}

#pragma mark - Public Methods

- (NSString *)fullStreetAddress {
  if (self.extendedAddress.length > 0) {
    return [NSString stringWithFormat:@"%@, %@", self.streetAddress, self.extendedAddress];
  }

  return self.streetAddress;
}

- (NSURL *)imageURL {
  return [NSURL lu_imageURLForLocationWithID:self.locationID];
}

- (CLLocation *)location {
  if (self.latitude && self.longitude) {
    CLLocationCoordinate2D coord = self.coordinate;
    return [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
  } else {
    return nil;
  }
}

- (NSString *)singleLineAddress {
  return [NSString stringWithFormat:
          @"%@, %@, %@ %@",
          [self fullStreetAddress],
          self.locality,
          self.region,
          self.postalCode];
}

#pragma mark - MKAnnotation Methods

#if !defined(BOUNDED)
#define BOUNDED(A,B,C)  (MAX((B), MIN((C), A)))
#endif

- (CLLocationCoordinate2D)coordinate {
  if (self.latitude && self.longitude) {
    return CLLocationCoordinate2DMake(BOUNDED(self.latitude.doubleValue, -90, 90), BOUNDED(self.longitude.doubleValue, -180, 180));
  } else {
    return kCLLocationCoordinate2DInvalid;
  }
}

- (NSString *)subtitle {
  return self.name;
}

- (NSString *)title {
  return self.merchantName;
}

#pragma mark - NSObject Methods

- (NSString *)debugDescription {
  return [NSString stringWithFormat:
          @"LULocation [address=%p, categoryIDs=%@, descriptionHTML=%@, extendedAddress=%@, hours=%@, ID=%@, latitude=%@, locality=%@, longitude=%@, merchantID=%@, merchantName=%@, name=%@, phone=%@, postalCode=%@, region=%@, shown=%@, summary=%@, streetAddress=%@, updatedAtDate=%@]",
          self, self.categoryIDs, self.descriptionHTML, self.extendedAddress, self.hours, self.locationID, self.latitude,
          self.locality, self.longitude, self.merchantID, self.merchantName, self.name, self.phone, self.postalCode,
          self.region, @(self.shown), @(self.summary), self.streetAddress, self.updatedAtDate];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"LULocation [address=%p, ID=%@, latitude=%@, longitude=%@, merchantName=%@, name=%@, streetAddress=%@]",
          self, self.locationID, self.latitude, self.longitude, self.merchantName, self.name, self.streetAddress];
}

@end
