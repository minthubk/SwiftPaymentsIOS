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

extern NSString * const LUNextPageURLKey;

@protocol LULocationCacheUpdaterDelegate;

/**
 `LULocationCacheUpdater` is used to update the local database of summary info for all LevelUp
 locations.

 An initial database seed is provided in the SDK, and only changes to locations are sent from the
 platform.

 Updates are made in the background. A `LULocationCacheUpdaterDelegate` is provided, and will be
 notified when update finishes, and whether any updates were made. The delegate is also notified of
 any errors, either with Core Data or over the network.
 */
@interface LULocationCacheUpdater : NSObject

@property (nonatomic, assign, readonly) BOOL isUpdating;

- (id)initWithDelegate:(id<LULocationCacheUpdaterDelegate>)delegate;
- (void)startUpdating;
- (void)stopUpdating;

@end

@protocol LULocationCacheUpdaterDelegate <NSObject>

- (void)locationCacheUpdaterDidFinishWithUpdates:(BOOL)updates;
- (void)locationCacheUpdaterDidReceiveCoreDataError:(NSError *)error;
- (void)locationCacheUpdaterDidReceiveNetworkError:(NSError *)error;

@end
