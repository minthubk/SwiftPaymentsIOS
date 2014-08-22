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
#import "LUAPIConnection.h"
#import "LUAPIResponse.h"
#import "LUCachedLocation.h"
#import "LUCoreDataStack.h"
#import "LULocation.h"
#import "LULocationCacheUpdater.h"
#import "LULocationRequestFactory.h"

NSString * const LUNextPageURLKey = @"LULocationCacheUpdaterNextPageURLKey";

@interface LULocationCacheUpdater ()

@property (nonatomic, weak) LUAPIConnection *currentRequest;
@property (nonatomic, weak) id<LULocationCacheUpdaterDelegate> delegate;
@property (nonatomic, assign) BOOL isUpdating;
@property (nonatomic, assign) BOOL locationsChanged;
@property (nonatomic, strong) dispatch_queue_t locationUpdaterQueue;

@end

@implementation LULocationCacheUpdater

#pragma mark - Creation

- (id)initWithDelegate:(id<LULocationCacheUpdaterDelegate>)delegate {
  self = [super init];
  if (!self) return nil;

  _delegate = delegate;
  _locationUpdaterQueue = dispatch_queue_create("LULocationUpdaterQueue", DISPATCH_QUEUE_SERIAL);

  return self;
}

#pragma mark - Public Methods

- (void)startUpdating {
  if (self.isUpdating) return;

  self.isUpdating = YES;

  NSURL *nextPageURL = [NSURL URLWithString:[LUCoreDataStack metadataStringForKey:LUNextPageURLKey]];
  [self retrieveNextPageOfLocations:nextPageURL];
}

- (void)stopUpdating {
  if (!self.isUpdating) return;

  self.isUpdating = NO;
  [self.currentRequest.operation cancel];
}

#pragma mark - Private Methods

- (void)coreDataError:(NSError *)error {
  dispatch_sync(dispatch_get_main_queue(), ^{
    self.isUpdating = NO;
    [self.delegate locationCacheUpdaterDidReceiveCoreDataError:error];
  });
}

- (void)finishedUpdatingLocations {
  dispatch_async(self.locationUpdaterQueue, ^{
    dispatch_sync(dispatch_get_main_queue(), ^{
      self.isUpdating = NO;
      [self.delegate locationCacheUpdaterDidFinishWithUpdates:self.locationsChanged];
    });
  });
}

- (void)retrieveNextPageOfLocations:(NSURL *)nextPageURL {
  self.currentRequest =
    [[LUAPIClient sharedClient] performRequest:[LULocationRequestFactory requestForLocationSummariesOnPage:nextPageURL]
                                       success:^(NSArray *locations, LUAPIResponse *response) {
                                         if (!locations || !self.isUpdating) {
                                           [self finishedUpdatingLocations];
                                           return;
                                         }

                                         [self updateLocations:locations response:response];

                                         [self retrieveNextPageOfLocations:[response nextPageURL]];
                                       }
                                       failure:^(NSError *error) {
                                         [self.delegate locationCacheUpdaterDidReceiveNetworkError:error];
                                       }];

  self.currentRequest.successCallbackQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (void)updateLocations:(NSArray *)locations response:(LUAPIResponse *)response {
  dispatch_async(self.locationUpdaterQueue, ^{
    NSManagedObjectContext *moc = [LUCoreDataStack managedObjectContext];
    for (LULocation *location in locations) {
      LUCachedLocation *cachedLocation = [LUCachedLocation findOrBuildWithLocationID:location.locationID managedObjectContext:moc];
      [cachedLocation updatePropertiesFromLocation:location];
    }

    if (![moc hasChanges]) {
      return;
    }

    NSError *error;
    if (![moc save:&error]) {
      [self coreDataError:error];
      return;
    }

    [LUCoreDataStack setMetadataString:[[response nextPageURL] absoluteString] forKey:LUNextPageURLKey];

    self.locationsChanged = YES;
  });
}

@end
