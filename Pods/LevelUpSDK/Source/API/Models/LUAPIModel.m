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
#import <objc/runtime.h>

@implementation LUAPIModel

#pragma mark - NSObject Methods

- (NSUInteger)hash {
  int prime = 11;
  NSUInteger total = [NSStringFromClass([self class]) hash] * prime;

  prime = [self primeAfter:prime];

  for (NSString *attribute in [self propertyNames]) {
    id value = [self valueForKey:attribute];

    if (value) {
      total += [value hash] * prime;
      prime = [self primeAfter:prime];
    }
  }

  return total;
}

- (BOOL)isEqual:(id)otherObject {
  if(!otherObject || [otherObject class] != [self class]) {
    return NO;
  }

  LUAPIModel *otherModel = (LUAPIModel *)otherObject;

  for (NSString *attribute in [self propertyNames]) {
    id value = [self valueForKey:attribute];
    id otherValue = [otherModel valueForKey:attribute];

    BOOL bothValuesNil = !value && !otherValue;
    BOOL valuesEqual = [value isEqual:otherValue];

    if (!bothValuesNil && !valuesEqual) {
      return NO;
    }
  }

  return YES;
}

#pragma mark - Private

- (BOOL)isPrime:(int)possiblePrime {
  for (int i = 2; i < possiblePrime; i++) {
    if (possiblePrime % i == 0) {
      return NO;
    }
  }

  return YES;
}

- (int)primeAfter:(int)prime {
  int nextPrime = prime + 1;

  while (![self isPrime:nextPrime]) {
    nextPrime++;
  }

  return nextPrime;
}

- (NSArray *)propertyNames {
  NSMutableArray *properties = [NSMutableArray array];

  Class cls = [self class];
  while (cls && (cls != [LUAPIModel superclass])) {
    [properties addObjectsFromArray:[self propertyNamesForClass:cls]];

    cls = [cls superclass];
  }

  return properties;
}

- (NSArray *)propertyNamesForClass:(Class)cls {
  NSMutableArray *classProperties = [NSMutableArray array];

  unsigned int outCount, i;
  objc_property_t *properties = class_copyPropertyList(cls, &outCount);
  for(i = 0; i < outCount; i++) {
    objc_property_t property = properties[i];
    const char *propName = property_getName(property);

    NSString *attribute = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
    [classProperties addObject:attribute];
  }
  free(properties);

  return classProperties;
}

@end
