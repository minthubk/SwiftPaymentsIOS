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

#import "LUAPIClient.h"
#import "LUConstants.h"
#import "LUDeepLinkAuthInstallAlert.h"

@interface LUDeepLinkAuthInstallAlert ()

@property (nonatomic, strong) LUDeepLinkAuthInstallAlert *strongSelfReference;

@end

@implementation LUDeepLinkAuthInstallAlert

#pragma mark - Object Lifecycle Methods

- (id)init {
  self = [super init];
  if (!self) return nil;

  _alertView = [[UIAlertView alloc] initWithTitle:[LUAPIClient sharedClient].deepLinkAuthInstallTitle
                                          message:[LUAPIClient sharedClient].deepLinkAuthInstallMessage
                                         delegate:self
                                cancelButtonTitle:[LUAPIClient sharedClient].deepLinkAuthInstallNegativeButtonTitle
                                otherButtonTitles:[LUAPIClient sharedClient].deepLinkAuthInstallPositiveButtonTitle, nil];

  return self;
}

- (void)dealloc {
  _alertView.delegate = nil;
}

#pragma mark - Public Methods

+ (BOOL)shouldShowForError:(NSError *)error {
  return error.code == LUDeepLinkAuthErrorAppNotInstalled && [LUAPIClient sharedClient].deepLinkAuthShowInstallAlert;
}

+ (void)showAlert {
  [[[self alloc] init] show];
}

- (void)show {
  self.strongSelfReference = self;
  [self.alertView show];
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  self.strongSelfReference = nil;

  if (buttonIndex == alertView.cancelButtonIndex) return;

  [[UIApplication sharedApplication] openURL:[LUAPIClient sharedClient].deepLinkAuthInstallAppStoreURL];
}

@end
