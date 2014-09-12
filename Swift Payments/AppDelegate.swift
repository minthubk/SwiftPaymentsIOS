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

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var navigationController: UINavigationController?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    configureLevelUpSDK()
    setupNavigationAndKeyWindow()
    return true
  }

  func application(application: UIApplication!, openURL url: NSURL!, sourceApplication: String!, annotation: AnyObject!) -> Bool {
    return LUDeepLinkAuth.handleOpenURL(url, sourceApplication: sourceApplication)
  }

  func configureLevelUpSDK() {
    LUAPIClient.setupWithAppID(LevelUpAppID, APIKey: LevelUpAPIKey)
  }

  func setupNavigationAndKeyWindow() {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)

    updateRootViewController()

    window!.makeKeyAndVisible()
  }

  func updateRootViewController() {
    var rootViewController: UIViewController?

    if AuthenticationHandler.isUserAuthenticated() {
      rootViewController = loggedInViewController()
    } else {
      rootViewController = LoggedOutViewController(nibName: "LoggedOutView", bundle: nil)
    }

    navigationController = UINavigationController(rootViewController: rootViewController!)
    window!.rootViewController = navigationController
  }

  func loggedInViewController() -> UIViewController {
    let payRewardStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = payRewardStoryboard.instantiateInitialViewController() as UIViewController

    let logoutButton = UIBarButtonItem(title: "Log Out", style: .Done, target: self, action: "logOut")
    viewController.navigationItem.rightBarButtonItem = logoutButton

    return viewController
  }

  func logOut() {
    LUAPIClient.sharedClient().accessToken = nil
    updateRootViewController()
  }
}
