//
//  AppDelegate.swift
//  Swift Payment
//
//  Created by Daniel Schlitt on 8/14/14.
//  Copyright (c) 2014 SCVNGR. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var navigationController: UINavigationController?
  
  func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
    // Override point for customization after application launch.
    configureLevelUpSDK()
    setupNavigationAndKeyWindow()
    return true
  }
  
  func application(application: UIApplication!, openURL url: NSURL!, sourceApplication: String!, annotation: AnyObject!) -> Bool{
    return LUDeepLinkAuth.handleOpenURL(url, sourceApplication: sourceApplication)
  }
  
  func applicationWillResignActive(application: UIApplication!) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(application: UIApplication!) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(application: UIApplication!) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication!) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(application: UIApplication!) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func configureLevelUpSDK(){
    LUAPIClient.setupWithAppID(LevelUpAPPID, APIKey: LeveLUpAPIKey)
  }
  
  func setupNavigationAndKeyWindow(){
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    
    updateRootViewController()
    
    window!.makeKeyAndVisible()
  }
  
  func updateRootViewController(){
    var rootViewController: UIViewController?
    
    if AuthenticationHandler.isUserAuthenticated(){
      rootViewController = loggedInViewController()
      
    }else{
      rootViewController = LoggedOutViewController(nibName: "LoggedOutView", bundle: nil)
    }
    
    navigationController = UINavigationController(rootViewController: rootViewController)
    window!.rootViewController = navigationController
    
  }
  
  func loggedInViewController() -> UIViewController {
    let payRewardStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = payRewardStoryboard.instantiateInitialViewController() as UIViewController
    
    let logoutButton = UIBarButtonItem(title: "Log Out", style: .Done, target: self, action: "logOut")
    viewController.navigationItem.rightBarButtonItem = logoutButton
    
    return viewController
  }
  
  func logOut(){
    LUAPIClient.sharedClient().accessToken = nil
    updateRootViewController()
  }
}

