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

import Foundation

class LoggedOutViewController: UIViewController {
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    let failedNotification = NSNotificationCenter.defaultCenter()

    failedNotification.addObserver(self,
      selector: "deepLinkAuthFailed:",
      name: LUDeepLinkAuthErrorNotification,
      object: nil)

    let succeededNotification = NSNotificationCenter.defaultCenter()

    succeededNotification.addObserver(self,
      selector: "deepLinkAuthSucceeded:",
      name: LUDeepLinkAuthSuccessNotification,
      object: nil)
  }

  @IBAction func deepLinkAuth(sender: UIButton) {
    LUDeepLinkAuth.authorizeWithPermissions(["read_user_basic_info", "read_qr_code", "manage_user_campaigns"], returnURLScheme: "com.thelevelup.Swift-Payments")
  }

  func deepLinkAuthFailed(notification: NSNotification) {
    let error = notification.userInfo![LUDeepLinkAuthNotificationErrorKey]! as NSError

    UIAlertView(title: "Deep Link Auth Error",
      message: error.localizedDescription,
      delegate: nil,
      cancelButtonTitle: "OK").show()
  }

  func deepLinkAuthSucceeded(notification: NSNotification) {
    let accessToken = notification.userInfo![LUDeepLinkAuthNotificationAccessTokenKey]! as String
    LUAPIClient.sharedClient().accessToken = accessToken

    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    appDelegate.updateRootViewController()
  }
}
