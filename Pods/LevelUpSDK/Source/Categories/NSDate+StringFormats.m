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

#import "NSDate+StringFormats.h"

@implementation NSDate (StringFormats)

#pragma mark - Public Methods

+ (NSDate *)lu_dateFromIso8601DateTimeString:(NSString *)dateString {
  // This tweaking is required because NSDateFormatter doesn't fully support
  // ISO 8601. Specifically, it doesn't want time zones with colons, so we strip
  // out the third-to-last character (the colon).
  NSUInteger colonIndex = [dateString length] - 3;
  NSString *finalDateString = dateString;

  if (':' == [finalDateString characterAtIndex:colonIndex]) {
    finalDateString = [finalDateString stringByReplacingCharactersInRange:NSMakeRange(colonIndex, 1) withString:@""];
  }

  return [[NSDate lu_iso8601DateTimeFormatter] dateFromString:finalDateString];
}

- (NSString *)lu_iso8601DateTimeString {
  return [[NSDate lu_iso8601DateTimeFormatter] stringFromDate:self];
}

#pragma mark - Private Methods

+ (NSDateFormatter *)lu_iso8601DateTimeFormatter {
  NSDateFormatter *iso8601DateTimeFormatter = [[NSDateFormatter alloc] init];
  [iso8601DateTimeFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZ"];
  [iso8601DateTimeFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

  return iso8601DateTimeFormatter;
}

@end
