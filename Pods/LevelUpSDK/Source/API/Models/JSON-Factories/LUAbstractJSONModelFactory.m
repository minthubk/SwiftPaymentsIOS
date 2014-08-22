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

#import "LUAbstractJSONModelFactory.h"
#import "NSArray+LUAdditions.h"

@implementation LUAbstractJSONModelFactory

#pragma mark - Public Methods

+ (instancetype)factory {
  return [[self alloc] init];
}

- (id)createFromAttributes:(NSDictionary *)attributes {
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                               userInfo:nil];
}

- (id)fromArray:(NSArray *)array {
  return [array lu_mappedArrayWithBlock:^(id subJSON) {
    return [self fromJSONObject:subJSON];
  }];
}

- (id)fromDictionary:(NSDictionary *)dictionary {
  NSDictionary *attributes = dictionary;

  if ([self hasSingleDictionaryUnderRootKey:attributes]) {
    attributes = attributes[[self rootKey]];
  }

  return [self createFromAttributes:attributes];
}

- (id)fromJSONObject:(id)JSON {
  if ([JSON isKindOfClass:[NSArray class]]) {
    return [self fromArray:JSON];
  } else if ([JSON isKindOfClass:[NSDictionary class]]) {
    return [self fromDictionary:JSON];
  } else {
    return nil;
  }
}

- (NSString *)rootKey {
  return nil;
}

#pragma mark - Private Methods

- (BOOL)hasSingleDictionaryUnderRootKey:(NSDictionary *)dict {
  id objectUnderRootKey = dict[[self rootKey]];

  return [dict count] == 1 && objectUnderRootKey && [objectUnderRootKey isKindOfClass:[NSDictionary class]];
}

@end
