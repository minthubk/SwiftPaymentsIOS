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

#import "NSRegularExpression+LUAdditions.h"

@implementation NSRegularExpression (LUAdditions)

- (BOOL)lu_hasMatchesInString:(NSString *)string {
  return [self numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)] > 0;
}

- (NSArray *)lu_matchesInString:(NSString *)string {
  return [self matchesInString:string
                       options:0
                         range:NSMakeRange(0, string.length)];
}

- (NSString *)lu_removeMatchesInString:(NSString *)string {
  NSMutableString *mutableString = [string mutableCopy];
  [self replaceMatchesInString:mutableString
                        options:0
                          range:NSMakeRange(0, string.length)
                   withTemplate:@""];

  return [NSString stringWithString:mutableString];
}

@end
