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

#import "LUAPIError.h"

@implementation LUAPIError

#pragma mark - Creation

- (id)initWithCode:(NSString *)code message:(NSString *)message object:(NSString *)object property:(NSString *)property {
  self = [super init];
  if (!self) return nil;

  _code = code;
  _message = message;
  _object = object;
  _property = property;

  return self;
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUAPIError [address=%p, code=%@, message=%@, object=%@, property=%@]",
          self, self.code, self.message, self.object, self.property];
}

@end
