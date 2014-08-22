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

#import "LUKeychainAccess.h"
#import "LUOneTimePad.h"
#import "NSData+LUAdditions.h"

NSString * const LUOneTimePadKey = @"LUDeepLinkAuthOneTimePad";
NSInteger const LUOneTimePadLengthInBytes = 128;

@implementation LUOneTimePad

#pragma mark - Object Lifecycle Methods

- (id)initWithData:(NSData *)data {
  self = [super init];
  if (!self) return nil;

  _data = data;

  return self;
}

#pragma mark - Factory Methods

+ (instancetype)loadOneTimePad {
  NSData *data = [[LUKeychainAccess standardKeychainAccess] dataForKey:LUOneTimePadKey];
  if (!data) return nil;

  return [[self alloc] initWithData:data];
}

+ (instancetype)oneTimePadWithBase64EncodedString:(NSString *)string {
  NSData *data = [NSData lu_dataWithBase64EncodedString:string];
  return [[self alloc] initWithData:data];
}

+ (instancetype)saveNewOneTimePad {
  NSData *data = [NSData lu_randomDataOfLength:LUOneTimePadLengthInBytes];
  LUOneTimePad *pad = [[LUOneTimePad alloc] initWithData:data];

  [[LUKeychainAccess standardKeychainAccess] setData:pad.data forKey:LUOneTimePadKey];

  return pad;
}

#pragma mark - Encoding/Decoding Methods

- (NSString *)decodeString:(NSString *)string {
  NSData *paddedData = [NSData lu_dataWithBase64EncodedString:string];
  NSData *data = [paddedData lu_XORDataWithSecret:self.data];
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)encodeString:(NSString *)string {
  NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
  NSData *paddedData = [data lu_XORDataWithSecret:self.data];
  return [paddedData lu_base64Encoding];
}

#pragma mark - Public Methods

- (NSString *)base64Encoding {
  return [self.data lu_base64Encoding];
}

- (NSUInteger)length {
  return [self.data length];
}

#pragma mark - NSObject Methods

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[self class]]) return NO;

  LUOneTimePad *otherPad = (LUOneTimePad *)object;
  return [self.data isEqualToData:otherPad.data];
}

- (NSUInteger)hash {
  return [self.data hash];
}

@end
