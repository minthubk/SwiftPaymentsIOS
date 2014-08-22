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

#import "LUWebLinkParser.h"
#import "NSRegularExpression+LUAdditions.h"

@interface LUWebLinkParser ()

@property (nonatomic, copy) NSString *headerValue;

@end

@implementation LUWebLinkParser

#pragma mark - Object Lifecycle

- (id)initWithHeaderValue:(NSString *)headerValue {
  self = [super init];
  if (!self) return nil;

  _headerValue = headerValue;

  return self;
}

#pragma mark - Public Methods

- (NSURL *)nextURL {
  if (!self.headerValue) return nil;

  for (NSDictionary *match in [self linksWithParams]) {
    if ([self containsNextRelationType:match[@"params"]]) {
      return match[@"link"];
    }
  }

  return nil;
}

#pragma mark - Private Methods (Regex matching)

- (BOOL)containsNextRelationType:(NSString *)params {
  return [[self relNextRegex] lu_hasMatchesInString:params];
}

- (NSArray *)linksWithParams {
  NSMutableArray *results = [NSMutableArray array];

  for (NSTextCheckingResult *linkMatch in [[self linkWithParamsRegex] lu_matchesInString:self.headerValue]) {
    NSDictionary *result = [self resultFromMatch:linkMatch];
    if (result) {
      [results addObject:result];
    }
  }

  return results;
}

- (NSDictionary *)resultFromMatch:(NSTextCheckingResult *)match {
  if (match.numberOfRanges < 3) return nil;

  NSRange rangeOfLink = [match rangeAtIndex:1];
  NSRange rangeOfParams = [match rangeAtIndex:2];

  return @{
    @"link" : [NSURL URLWithString:[self.headerValue substringWithRange:rangeOfLink]],
    @"params" : [self.headerValue substringWithRange:rangeOfParams]
  };
}

#pragma mark - Private Methods (Regular Expressions)

- (NSRegularExpression *)linkWithParamsRegex {
  // A link enclosed in "<>", followed by one or more comma separated params
  return [NSRegularExpression regularExpressionWithPattern:@"^<([^>]+)>(?:;([^,]+))+"
                                                   options:NSRegularExpressionCaseInsensitive
                                                     error:nil];
}

- (NSRegularExpression *)relNextRegex {
  return [NSRegularExpression regularExpressionWithPattern:@"rel\\s*=\\s*\"next\""
                                                   options:NSRegularExpressionCaseInsensitive
                                                     error:nil];
}

@end
