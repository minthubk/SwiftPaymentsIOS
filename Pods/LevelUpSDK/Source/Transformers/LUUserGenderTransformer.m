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

#import "LUUser.h"
#import "LUUserGenderTransformer.h"

@interface LUUserGenderTransformer ()

@property (nonatomic, strong) NSMapTable *genderMap;
@property (nonatomic, strong) NSDictionary *reverseGenderMap;

@end

NSString * const LUUserGenderTransformerName = @"LUUserGenderTransformerName";

@implementation LUUserGenderTransformer

+ (Class)transformedValueClass {
  return [NSString class];
}

- (id)transformedValue:(id)value {
  return [[self.genderMap objectForKey:value] capitalizedString];
}

- (id)reverseTransformedValue:(id)value {
  return [self.reverseGenderMap objectForKey:[value lowercaseString]];
}

#pragma mark - Getters

- (NSMapTable *)genderMap {
  if (_genderMap) return _genderMap;
  _genderMap = [[NSMapTable alloc] init];
  [_genderMap setObject:@"male" forKey:@(LUGenderMale)];
  [_genderMap setObject:@"female" forKey:@(LUGenderFemale)];
  return _genderMap;
}

- (NSDictionary *)reverseGenderMap {
  if (_reverseGenderMap) return _reverseGenderMap;
  NSArray *keys = [[self.genderMap dictionaryRepresentation] allValues];
  NSArray *values = [[self.genderMap dictionaryRepresentation] allKeys];
  _reverseGenderMap = [NSDictionary dictionaryWithObjects:values forKeys:keys];
  return _reverseGenderMap;
}

@end
