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

@interface NSDictionary (ObjectClassAccess)

- (NSArray *)lu_arrayForKey:(id)aKey;
- (BOOL)lu_boolForKey:(id)aKey;
- (NSDate *)lu_dateForKey:(id)aKey;
- (NSDictionary *)lu_dictionaryForKey:(id)aKey;
- (float)lu_floatForKey:(id)aKey;
- (NSNumber *)lu_numberForKey:(id)aKey;
- (NSString *)lu_stringForKey:(id)aKey;
- (NSURL *)lu_URLForKey:(id)aKey;

@end
