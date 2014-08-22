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

#import "NSData+Base64.h"
#import "NSData+LUAdditions.h"

@implementation NSData (LUAdditions)

+ (NSData *)lu_dataWithBase64EncodedString:(NSString *)string {
  return [self dataWithBase64EncodedString:string];
}

+ (int8_t)lu_randomByte {
  return arc4random() % INT8_MAX;
}

+ (NSData *)lu_randomDataOfLength:(NSUInteger)length {
  NSMutableData *data = [NSMutableData dataWithCapacity:length];
  while ([data length] < length) {
    int8_t randomByte = [self lu_randomByte];
    [data appendBytes:&randomByte length:1];
  }

  return [NSData dataWithData:data];
}

- (NSString *)lu_base64Encoding {
  return [self base64Encoding];
}

- (NSString *)lu_hexString {
  NSMutableString *buffer = [NSMutableString stringWithCapacity:self.length * 2];

  const unsigned char *bytes = [self bytes];
  for (int i = 0; i < self.length; i++) {
    [buffer appendFormat:@"%02X", (int)bytes[i]];
  }

  return [NSString stringWithString:buffer];
}

- (NSData *)lu_XORDataWithSecret:(NSData *)secret {
  NSMutableData *result = [self mutableCopy];

  int8_t selfByte, secretByte, resultByte;
  NSRange cur;
  for (int i = 0; i < MIN([self length], [secret length]); i++) {
    cur = NSMakeRange(i, 1);

    [self getBytes:&selfByte range:cur];
    [secret getBytes:&secretByte range:cur];

    resultByte = selfByte ^ secretByte;
    [result replaceBytesInRange:cur withBytes:&resultByte];
  }

  return [NSData dataWithData:result];
}

@end
