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
#import <MapKit/MapKit.h>

@class LUWebLocations;

/**
 A LevelUp merchant has one or more locations. Take the example of a chain restaurant with multiple
 franchises. This restaurant would have a single merchant associated with it, but each store would
 have its own `LULocation`.

 ## MapKit

 `LULocation` implements the `MKAnnotation` protocol. This provides annotation-related information
 to a map view. The title of the annotation is the result of `fullStreetAddress`.
 */
@interface LULocation : LUAPIModel <MKAnnotation>

/**
 An array of category IDs to which this location belongs.
 */
@property (nonatomic, copy, readonly) NSArray *categoryIDs;

/**
 An HTML string describing the location
 */
@property (nonatomic, copy, readonly) NSString *descriptionHTML;

/**
 An optional "extended" address for the location. An example would be an apartment number.
 */
@property (nonatomic, copy, readonly) NSString *extendedAddress;

/**
 An optional string representing the hours during which this location is open. The format of this
 string is determined by the location.
 */
@property (nonatomic, copy, readonly) NSString *hours;

/**
 The latitude of the location.
 */
@property (nonatomic, copy, readonly) NSNumber *latitude;

/**
 The location's town or city.
 */
@property (nonatomic, copy, readonly) NSString *locality;

/**
 The unique identifier for this location.
 */
@property (nonatomic, copy, readonly) NSNumber *locationID;

/**
 The longitude of the location.
 */
@property (nonatomic, copy, readonly) NSNumber *longitude;

/**
 The ID of this location's merchant.
 */
@property (nonatomic, copy) NSNumber *merchantID;

/**
 The location's merchant's name.
 */
@property (nonatomic, copy) NSString *merchantName;

/**
 The location's name.
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 An optional phone number for the location.
 */
@property (nonatomic, copy, readonly) NSString *phone;

/**
 The location's postal code.
 */
@property (nonatomic, copy, readonly) NSString *postalCode;

/**
 The location's region, such as a state or province.
 */
@property (nonatomic, copy, readonly) NSString *region;

/**
 If `shown` is set to NO, then this location should not be displayed in-app.
 */
@property (nonatomic, assign) BOOL shown;

/**
 Specifies if this instance of `LULocation` is only a summary. If it is, then only `categoryIDs`,
 `latitude`, `locationID`, `longitude`, `merchantName`, `merchantID`, `shown` and `updatedAtDate`
 will be set.
 */
@property (nonatomic, assign) BOOL summary;

/**
 The location's address. If the location's address has a second line (such as an apartment number),
 this will be stored separately in the `extendedAddress` field.
 */
@property (nonatomic, copy, readonly) NSString *streetAddress;

/**
 The time that this location was last changed on the server.
 */
@property (nonatomic, copy) NSDate *updatedAtDate;

/**
 An instance of LUWebLocations, which holds the associated web locations for this physical location.

 @deprecated This method has been deprecated. Request web links at a location using
 `[LULocationRequestFactory requestForWebLinksAtLocationWithID:]`.
 */
@property (nonatomic, copy, readonly) LUWebLocations *webLocations DEPRECATED_ATTRIBUTE;

/**
 If the location has both a `streetAddress` and an `extendedAddress`, this will return both values
 joined by a comma. For example, "123 Main Street, Apt 2A". When an `extendedAddress` is not present,
 only the `streetAddress` will be returned.
 */
- (NSString *)fullStreetAddress;

/**
 An associated image for the location. Will automatically return a retina or non-retina scaled image
 based on the screen scale of the device. The resolution is 320x212.
 */
- (NSURL *)imageURL;

/**
 A `CLLocation` instance associated with this location.
 */
- (CLLocation *)location;

/**
 A helper method which returns all the address fields in one line. The format is
 "<full street address>, <locality>, <region> <postal code>". For example: "123 Main Street, Apt 2A,
 Boston, MA 01234".
 */
- (NSString *)singleLineAddress;

- (id)initWithCategoryIDs:(NSArray *)categoryIDs descriptionHTML:(NSString *)descriptionHTML
          extendedAddress:(NSString *)extendedAddress hours:(NSString *)hours latitude:(NSNumber *)latitude
                 locality:(NSString *)locality locationID:(NSNumber *)locationID longitude:(NSNumber *)longitude
               merchantID:(NSNumber *)merchantID merchantName:(NSString *)merchantName name:(NSString *)name
                    phone:(NSString *)phone postalCode:(NSString *)postalCode region:(NSString *)region
                    shown:(BOOL)shown streetAddress:(NSString *)streetAddress updatedAtDate:(NSDate *)updatedAtDate
             webLocations:(LUWebLocations *)webLocations;

- (id)initWithCategoryIDs:(NSArray *)categoryIDs latitude:(NSNumber *)latitude locationID:(NSNumber *)locationID
                longitude:(NSNumber *)longitude merchantID:(NSNumber *)merchantID merchantName:(NSString *)merchantName
                     name:(NSString *)name shown:(BOOL)shown updatedAtDate:(NSDate *)updatedAtDate;

@end
