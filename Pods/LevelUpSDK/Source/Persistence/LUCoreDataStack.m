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

#import "LUCoreDataStack.h"
#import "LUCoreDataStore.h"
#import "NSArray+LUAdditions.h"

@implementation LUCoreDataStack

#pragma mark - Public Methods (Managed Object Context)

+ (NSManagedObjectContext *)managedObjectContext {
  NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSConfinementConcurrencyType];
  managedObjectContext.persistentStoreCoordinator = [self persistentStoreCoordinator];

  return managedObjectContext;
}

#pragma mark - Public Methods (Metadata Access)

+ (NSString *)metadataStringForKey:(NSString *)key {
  NSManagedObjectContext *moc = [self managedObjectContext];
  return [self metadataForObjectContext:moc][key];
}

+ (void)setMetadataString:(NSString *)string forKey:(NSString *)key {
  NSManagedObjectContext *moc = [self managedObjectContext];
  NSMutableDictionary *metadata = [[self metadataForObjectContext:moc] mutableCopy];
  metadata[key] = string;
  [self setMetadata:metadata forObjectContext:moc];
}

#pragma mark - Private Methods (Store Access)

+ (NSDictionary *)metadataForObjectContext:(NSManagedObjectContext *)moc {
  return [[moc.persistentStoreCoordinator.persistentStores lu_firstObject] metadata];
}

+ (void)setMetadata:(NSDictionary *)metadata forObjectContext:(NSManagedObjectContext *)moc {
  [[moc.persistentStoreCoordinator.persistentStores lu_firstObject] setMetadata:metadata];
  [moc save:nil];
}

+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  NSManagedObjectModel *mom = [NSManagedObjectModel mergedModelFromBundles:nil];
  NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];

  NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @YES, NSInferMappingModelAutomaticallyOption : @YES};
  NSError *error;
  if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                configuration:nil
                                                          URL:[LUCoreDataStore storeURL]
                                                      options:options
                                                        error:&error]) {
    NSLog(@"Error while creating persistent store coordinator: %@, %@", error, [error userInfo]);
    abort();
  }

  return persistentStoreCoordinator;
}

@end
