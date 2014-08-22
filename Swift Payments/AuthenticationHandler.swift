//
//  AuthenticationHandler.swift
//  Swift Payments
//
//  Created by Daniel Schlitt on 8/22/14.
//  Copyright (c) 2014 SCVNGR. All rights reserved.
//

import Foundation


class AuthenticationHandler{
   class func isUserAuthenticated() -> Bool {
    return LUAPIClient.sharedClient().accessToken != nil
  }
}

