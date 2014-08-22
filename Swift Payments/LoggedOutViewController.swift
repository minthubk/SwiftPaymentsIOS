//
//  LoggedOutViewController.swift
//  Swift Payment
//
//  Created by Daniel Schlitt on 8/21/14.
//  Copyright (c) 2014 SCVNGR. All rights reserved.
//

import Foundation

class LoggedOutViewController: UIViewController {

  required init(coder aDecoder: NSCoder!) {
    super.init(coder: aDecoder)
  }
  
  override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    let failedNotification = NSNotificationCenter.defaultCenter()
    
    failedNotification.addObserver( self,
      selector: "deepLinkAuthFailed:",
      name: LUDeepLinkAuthErrorNotification,
      object: nil)
    
    let succeededNotification = NSNotificationCenter.defaultCenter()
    
    succeededNotification.addObserver(self,
      selector: "deepLinkAuthSucceeded:",
      name: LUDeepLinkAuthSuccessNotification,
      object: nil)

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }

  
  
  
  @IBAction func DeepLinkAuth(sender: UIButton) {
    LUDeepLinkAuth.authorizeWithPermissions(["read_user_basic_info", "read_qr_code", "manage_user_campaigns"], returnURLScheme: "com.thelevelup.Swift-Payments")
  }
  
  func deepLinkAuthFailed(notification: NSNotification){

    let error = notification.userInfo[LUDeepLinkAuthNotificationErrorKey]! as NSError
    
    UIAlertView(title: "Deep Link Auth Error",
      message: error.localizedDescription,
      delegate: nil,
      cancelButtonTitle: "OK").show()
  }
  
  func deepLinkAuthSucceeded(notification: NSNotification){
    let accessToken = notification.userInfo[LUDeepLinkAuthNotificationAccessTokenKey]! as String
    LUAPIClient.sharedClient().accessToken = accessToken
    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    appDelegate.updateRootViewController()
    }
}