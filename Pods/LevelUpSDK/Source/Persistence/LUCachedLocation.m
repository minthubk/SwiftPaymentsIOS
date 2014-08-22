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

#import "LUCachedLocation.h"
#import "LULocation.h"

@implementation LUCachedLocation

@dynamic categoryIDs;
@dynamic latitude;
@dynamic locationID;
@dynamic longitude;
@dynamic merchantID;
@dynamic merchantName;
@dynamic name;
@dynamic shown;
@dynamic updatedAtDate;

#pragma mark - Public Methods

+ (NSString *)entityName {
  return @"Location";
}

+ (LUCachedLocation *)findOrBuildWithLocationID:(NSNumber *)locationID
                           managedObjectContext:(NSManagedObjectContext *)managedObjectContext {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
  fetchRequest.predicate = [NSPredicate predicateWithFormat:@"locationID = %@", locationID];
  fetchRequest.fetchLimit = 1;

  NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:nil];

  if (!results) {
    return nil;
  } else if (results.count > 0) {
    return [results lastObject];
  }

  LUCachedLocation *location = [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                                             inManagedObjectContext:managedObjectContext];
  location.locationID = locationID;
  return location;
}

- (NSComparisonResult)compare:(LUCachedLocation *)otherLocation relativeToLocation:(CLLocation *)center {
  CLLocationDistance distance1 = [center distanceFromLocation:[self toCLLocation]];
  CLLocationDistance distance2 = [center distanceFromLocation:[otherLocation toCLLocation]];

  if (distance1 < distance2) {
    return NSOrderedAscending;
  } else if (distance1 > distance2) {
    return NSOrderedDescending;
  } else {
    return NSOrderedSame;
  }
}

- (CLLocation *)toCLLocation {
  return [[CLLocation alloc] initWithLatitude:[self.latitude doubleValue] longitude:[self.longitude doubleValue]];
}

- (LULocation *)toLocation {
  NSMutableArray *categoryIDs = [NSMutableArray array];
  for (NSString *categoryID in [self.categoryIDs componentsSeparatedByString:@"|"]) {
    if (categoryID.length > 0) {
      [categoryIDs addObject:@([categoryID longLongValue])];
    }
  }

  return [[LULocation alloc] initWithCategoryIDs:categoryIDs latitude:self.latitude locationID:self.locationID
                                       longitude:self.longitude merchantID:self.merchantID
                                    merchantName:self.merchantName name:self.name shown:[self.shown boolValue]
                                   updatedAtDate:self.updatedAtDate];
}

- (void)updatePropertiesFromLocation:(LULocation *)location {
  self.categoryIDs = [[location.categoryIDs componentsJoinedByString:@"|"] stringByAppendingString:@"|"];
  self.latitude = location.latitude;
  self.locationID = location.locationID;
  self.longitude = location.longitude;
  self.merchantID = location.merchantID;
  self.merchantName = location.merchantName;
  self.name = location.name;
  self.shown = @(location.shown);
  self.updatedAtDate = location.updatedAtDate;
}

@end
