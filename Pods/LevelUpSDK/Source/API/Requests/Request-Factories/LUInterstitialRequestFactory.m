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

#import "LUAPIRequest.h"
#import "LUInterstitialJSONFactory.h"
#import "LUInterstitialRequestFactory.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation LUInterstitialRequestFactory

+ (LUAPIRequest *)requestForInterstitialForOrderWithUUID:(NSString *)UUID {
  NSString *path = [NSString stringWithFormat:@"orders/%@/interstitial", UUID];

  return [LUAPIRequest apiRequestWithMethod:@"GET"
                                       path:path
                                 apiVersion:LUAPIVersion15
                                 parameters:nil
                               modelFactory:[LUInterstitialJSONFactory factory]];
}

+ (LUAPIRequest *)requestToSubmitFeedbackForOrderWithUUID:(NSString *)UUID
                                             questionText:(NSString *)questionText
                                                   rating:(int)rating
                                                  comment:(NSString *)comment {
  NSString *path = [NSString stringWithFormat:@"orders/%@/feedback", UUID];
  NSString *ratingString = rating > 0 ? [NSString stringWithFormat:@"%d", rating] : @"";

  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters lu_setSafeValue:questionText forKey:@"question_text"];
  [parameters lu_setSafeValue:ratingString forKey:@"rating"];
  [parameters lu_setSafeValue:comment forKey:@"comment"];

  return [LUAPIRequest apiRequestWithMethod:@"POST"
                                       path:path
                                 apiVersion:LUAPIVersion15
                                 parameters:@{@"feedback": parameters}
                               modelFactory:[LUInterstitialJSONFactory factory]];
}

@end
