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

@class LULocation;

@interface LUCachedLocation : NSManagedObject

@property (nonatomic, copy) NSString *categoryIDs;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSNumber *locationID;
@property (nonatomic, copy) NSNumber *longitude;
@property (nonatomic, copy) NSNumber *merchantID;
@property (nonatomic, copy) NSString *merchantName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *shown;
@property (nonatomic, copy) NSDate *updatedAtDate;

+ (NSString *)entityName;
+ (LUCachedLocation *)findOrBuildWithLocationID:(NSNumber *)locationID
                           managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (NSComparisonResult)compare:(LUCachedLocation *)otherLocation relativeToLocation:(CLLocation *)center;
- (CLLocation *)toCLLocation;
- (LULocation *)toLocation;
- (void)updatePropertiesFromLocation:(LULocation *)location;

@end
