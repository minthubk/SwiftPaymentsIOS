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

#import <CommonCrypto/CommonDigest.h>
#import "LUDeviceIdentifier.h"
#import "LUKeychainAccess.h"

NSString * const DeviceIdentifierKey = @"LUDeviceIdentifier";

@implementation LUDeviceIdentifier

#pragma mark - Public Methods

+ (NSString *)deviceIdentifier {
  NSString *deviceIdentifier = [[LUKeychainAccess standardKeychainAccess] stringForKey:DeviceIdentifierKey];

  if (deviceIdentifier == nil) {
    deviceIdentifier = [self generateUUID];

    [[LUKeychainAccess standardKeychainAccess] setString:deviceIdentifier forKey:DeviceIdentifierKey];
  }

  return deviceIdentifier;
}

#pragma mark - Private Methods

+ (NSString *)generateUUID {
  CFUUIDRef uuid = CFUUIDCreate(NULL);
  CFStringRef uuidString = CFUUIDCreateString(NULL, uuid);
  CFRelease(uuid);

  NSString *rawUUIDStr = [NSString stringWithString:(__bridge NSString *)uuidString];
  CFRelease(uuidString);

  // MD5 hash the UUID
  unsigned char digest[CC_MD5_DIGEST_LENGTH];

  CC_MD5((__bridge const void *)([rawUUIDStr dataUsingEncoding:NSASCIIStringEncoding]), (CC_LONG)[rawUUIDStr length], digest);
  NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    [output appendFormat:@"%02x", digest[i]];
  }

  return [NSString stringWithString:output];
}

@end
