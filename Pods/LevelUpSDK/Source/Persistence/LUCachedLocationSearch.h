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

/**
 `LUCachedLocationSearch` is used to query a locally cached database of information on all LevelUp
 locations.

 This database is a local SQLite file managed via Core Data. The SDK will contain an initial seed of
 the database, and then the `LULocationCacheUpdater` class can be used to keep the location cache
 up-to-date.

 To use `LUCachedLocationSearch`, create an instance along with a `CLLocation` around which to order
 the locations, a maximum number of results, and an optional category ID upon which to filter.
 */
@interface LUCachedLocationSearch : NSObject

/**
 Creates an instance of `LUCachedLocationSearch` with the specified search criteria.

 @param center The center point of the search. Searches with progressively higher radii will be
 performed until at least `limit` results are found.
 @param limit The desired number of results.
 @param categoryID An optional category ID to filter on. May be `nil`.
 */
- (id)initWithCenter:(CLLocation *)center limit:(NSUInteger)limit categoryID:(NSNumber *)categoryID;

/**
 Performs the search.

 @param error If an error occurs during the search, `error` will be updated to point to an instance
 of `NSError` with error info.
 */
- (NSArray *)executeSearch:(NSError **)error;

@end
