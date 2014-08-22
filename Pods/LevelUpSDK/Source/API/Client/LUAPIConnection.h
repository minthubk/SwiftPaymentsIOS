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

@class AFHTTPRequestOperation;

/**
 `LUAPIConnection` represents a connection to the LevelUp API. This object is returned by the
 `performRequest:success:failure` method of `LUAPIClient`.
 */
@interface LUAPIConnection : NSObject

/**
 The callback dispatch queue on failure. If `NULL` (default), the main queue is used.
 */
@property (nonatomic, assign) dispatch_queue_t failureCallbackQueue;

/**
 An `NSOperation` for this request.
 */
@property (nonatomic, strong, readonly) NSOperation *operation;

/**
 The callback dispatch queue on success. If `NULL` (default), the main queue is used.
 */
@property (nonatomic, assign) dispatch_queue_t successCallbackQueue;

- (id)initWithAFHTTPRequestOperation:(AFHTTPRequestOperation *)httpRequestOperation;

@end
