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

#import "LUAPIModel.h"

/**
 This action is used for interstitials that request the user claim a campaign.
 */
@interface LUInterstitialClaimAction : LUAPIModel

/**
 A campaign code that the user will have the option of claiming.
 */
@property (nonatomic, copy, readonly) NSString *campaignCode;

- (id)initWithCampaignCode:(NSString *)campaignCode;

@end
