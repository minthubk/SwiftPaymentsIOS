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
 If an API request returns an error, the response may include one or more `LUAPIError` objects.
 These will be included within the `userInfo` of the `NSError` returned by a network request.

 An error will have a `message`, and may have an `object` and `property`. These latter two
 properties are useful for validation errors. For example, if a user attempts to register without
 providing an email address, the object would be "user" and the property would be "email".
 */
@interface LUAPIError : LUAPIModel

/**
 A machine-readable description of the error (can be `nil`).
 */
@property (nonatomic, copy, readonly) NSString *code;

/**
 A human-readable description of the error.
 */
@property (nonatomic, copy, readonly) NSString *message;

/**
 A description of the object to which the error refers, such as "user" or "location". This can be
 useful to distinguish validation errors within nested objects.
 */
@property (nonatomic, copy, readonly) NSString *object;

/**
 The property to which the error refers. This is typically used for validation errors. For example,
 if a user attempts to register without providing an email address, the object would be "user" and
 the property would be "email".
 */
@property (nonatomic, copy, readonly) NSString *property;

- (id)initWithCode:(NSString *)code message:(NSString *)message object:(NSString *)object property:(NSString *)property;

@end
