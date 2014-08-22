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
#import "LUCachedLocationSearch.h"
#import "LUCoreDataStack.h"
#import "NSArray+LUAdditions.h"

const CLLocationDistance LURadiusOfEarth = 6378100.0;
const CLLocationDistance LULengthOfDegreeOfLatitude = 11132.954;

@interface LUCachedLocationSearch ()

@property (nonatomic, copy) NSNumber *categoryID;
@property (nonatomic, strong) CLLocation *center;
@property (nonatomic, assign) NSUInteger limit;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation LUCachedLocationSearch

- (id)initWithCenter:(CLLocation *)center limit:(NSUInteger)limit categoryID:(NSNumber *)categoryID {
  self = [super init];
  if (!self) return nil;

  _categoryID = categoryID;
  _center = center;
  _limit = limit;
  _managedObjectContext = [LUCoreDataStack managedObjectContext];

  return self;
}

- (NSArray *)executeSearch:(NSError **)error {
  NSMutableArray *locations = [[self nearbyLocations:error] mutableCopy];
  if (!locations) return nil;

  [locations sortUsingComparator:^(LUCachedLocation *obj1, LUCachedLocation *obj2) {
    return [obj1 compare:obj2 relativeToLocation:self.center];
  }];

  if ([locations count] > self.limit) {
    [locations setArray:[locations subarrayWithRange:NSMakeRange(0, self.limit)]];
  }

  return [locations lu_mappedArrayWithBlock:^(LUCachedLocation *cachedLocation) {
    return [cachedLocation toLocation];
  }];
}

#pragma mark - Private Methods (Nearby Locations)

- (NSArray *)locationsWithinRadius:(CLLocationDistance)radius error:(NSError **)error {
  NSFetchRequest *fetchRequest = [self fetchRequestForLocationsWithinRadius:radius];
  NSMutableArray *locations = [[self.managedObjectContext executeFetchRequest:fetchRequest error:error] mutableCopy];

  return [locations filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(LUCachedLocation *location, NSDictionary *bindings) {
    return [[location toCLLocation] distanceFromLocation:self.center] <= radius;
  }]];
}

- (NSArray *)nearbyLocations:(NSError **)error {
  NSFetchRequest *fetchRequestForAllLocations = [self fetchRequestForAllLocations];
  NSUInteger totalNumberOfLocations = [self.managedObjectContext countForFetchRequest:fetchRequestForAllLocations
                                                                                error:error];

  if (totalNumberOfLocations == 0) {
    return [NSArray array];
  } else if (totalNumberOfLocations <= self.limit) {
    return [self.managedObjectContext executeFetchRequest:fetchRequestForAllLocations error:error];
  }

  CLLocationDistance radius = 100.0;
  NSArray *locations;

  do {
    locations = [self locationsWithinRadius:radius error:error];
    if (!locations) return nil;

    radius *= 2.0;
  } while ([locations count] < self.limit && radius < LURadiusOfEarth * 2);

  return locations;
}

#pragma mark - Private Methods (Fetch Requests)

- (NSFetchRequest *)fetchRequestForAllLocations {
  return [self fetchRequestForLocationsWithinRadius:-1];
}

- (NSFetchRequest *)fetchRequestForLocationsWithinRadius:(CLLocationDistance)radius {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[LUCachedLocation entityName]];

  NSMutableArray *subpredicates = [NSMutableArray arrayWithObject:[self predicateForShown]];

  if (self.categoryID) {
    [subpredicates addObject:[self predicateForCategoryID]];
  }

  if (radius > 0) {
    [subpredicates addObject:[self predicateForRadius:radius]];
  }

  fetchRequest.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];

  return fetchRequest;
}

#pragma mark - Private Methods (Subpredicates)

- (NSPredicate *)predicateForShown {
  return [NSPredicate predicateWithFormat:@"shown = YES"];
}

- (NSPredicate *)predicateForCategoryID {
  return [NSPredicate predicateWithFormat:@"categoryIDs CONTAINS %@", [NSString stringWithFormat:@"%@|", self.categoryID]];
}

- (NSPredicate *)predicateForRadius:(CLLocationDistance)radius {
  CLLocationDegrees radiusInDegrees = radius / LULengthOfDegreeOfLatitude;

  CLLocationDegrees minLatitude = self.center.coordinate.latitude - radiusInDegrees;
  CLLocationDegrees maxLatitude = self.center.coordinate.latitude + radiusInDegrees;

  if (minLatitude > maxLatitude) {
    CLLocationDegrees tmp = maxLatitude;
    maxLatitude = minLatitude;
    minLatitude = tmp;
  }

  minLatitude = MAX(minLatitude, -90.0);
  maxLatitude = MIN(maxLatitude, 90.0);

  CLLocationDistance longitudeFudge = cos(self.center.coordinate.longitude * M_PI / 180);
  CLLocationDegrees minLongitude = self.center.coordinate.longitude - radiusInDegrees * longitudeFudge;
  CLLocationDegrees maxLongitude = self.center.coordinate.longitude + radiusInDegrees * longitudeFudge;

  if (minLongitude > maxLongitude) {
    double tmp = maxLongitude;
    maxLongitude = minLongitude;
    minLongitude = tmp;
  }

  minLongitude = MAX(minLongitude, -180.0);
  maxLongitude = MIN(maxLongitude, 180.0);

  return [NSPredicate predicateWithFormat:@"(latitude BETWEEN {%@, %@}) AND (longitude BETWEEN {%@, %@})", @(minLatitude), @(maxLatitude), @(minLongitude), @(maxLongitude)];
}

@end
