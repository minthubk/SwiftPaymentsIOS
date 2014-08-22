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

/**
 Parses a "Web Link" HTTP header: http://tools.ietf.org/html/rfc5988.

 These headers have the form:

 <http://example.com/TheBook/chapter1>; rel="previous"; title="previous chapter",
 <http://example.com/TheBook/chapter3>; rel="next"; title="next chapter",

 In this particular class, the `nextURL` method looks for a link that includes a link with a
 relation type of "next". For example:

 <http://example.com>; rel="next"
*/
@interface LUWebLinkParser : NSObject

- (id)initWithHeaderValue:(NSString *)headerValue;
- (NSURL *)nextURL;

@end
