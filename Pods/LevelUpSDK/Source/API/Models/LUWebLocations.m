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

#import "LUWebLocations.h"

@interface LUWebLocations ()

@property (nonatomic, copy) NSString *facebookAddress;
@property (nonatomic, copy) NSString *foodlerAddress;
@property (nonatomic, copy) NSString *menuAddress;
@property (nonatomic, copy) NSString *newsletterAddress;
@property (nonatomic, copy) NSString *opentableAddress;
@property (nonatomic, copy) NSString *twitterAddress;
@property (nonatomic, copy) NSString *yelpAddress;

@end

@implementation LUWebLocations

#pragma mark - Creation Methods

- (id)initWithFacebookAddress:(NSString *)facebook foodlerAddress:(NSString *)foodler menuAddress:(NSString *)menu
            newsletterAddress:(NSString *)newsletter opentableAddress:(NSString *)opentable
               twitterAddress:(NSString *)twitter yelpAddress:(NSString *)yelp {
  self = [super init];

  _facebookAddress = facebook;
  _foodlerAddress = foodler;
  _menuAddress = menu;
  _newsletterAddress = newsletter;
  _opentableAddress = opentable;
  _twitterAddress = twitter;
  _yelpAddress = yelp;

  return self;
}

#pragma mark - Public Methods

- (NSURL *)facebookURL {
  return [NSURL URLWithString:self.facebookAddress];
}

- (NSURL *)foodlerURL {
  return [NSURL URLWithString:self.foodlerAddress];
}

- (NSURL *)menuURL {
  return [NSURL URLWithString:self.menuAddress];
}

- (NSURL *)newsletterURL {
  return [NSURL URLWithString:self.newsletterAddress];
}

- (NSURL *)opentableURL {
  return [NSURL URLWithString:self.opentableAddress];
}

- (NSURL *)twitterURL {
  return [NSURL URLWithString:self.twitterAddress];
}

- (NSURL *)yelpURL {
  return [NSURL URLWithString:self.yelpAddress];
}

#pragma mark - NSObject Methods

- (NSString *)description {
  return [NSString stringWithFormat:@"LUWebLocation [address=%p, facebookAddress=%@, foodlerAddress=%@, menuAddress=%@, newsletterAddress=%@, opentableAddress=%@, twitterAddress=%@, yelpAddress=%@",
          self, self.facebookAddress, self.foodlerAddress, self.menuAddress, self.newsletterAddress,
          self.opentableAddress, self.twitterAddress, self.yelpAddress];
}

@end
