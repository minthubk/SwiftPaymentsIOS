//
//  SecondViewController.swift
//  Swift Payments
//
//  Created by Daniel Schlitt on 8/21/14.
//  Copyright (c) 2014 SCVNGR. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
                            
  @IBOutlet weak var SpendToGo: UILabel?
  @IBOutlet weak var progressBar: UIProgressView?
  @IBOutlet weak var spendX: UILabel?
  @IBOutlet weak var earnY: UILabel?
  @IBOutlet weak var availableCredit: UILabel?
  
  var LoyaltyObject: LULoyalty?
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewWillAppear(animated: Bool){
    //Want user to see their loyalty appear immediately after they pay
    super.viewWillAppear(animated)
    let request: LUAPIRequest = LULoyaltyRequestFactory.requestForLoyaltyForMerchantWithID(MerchantID)
    LUAPIClient.sharedClient().performRequest(request,
      success: {LoyaltyObject, response in
        self.updateLoyaltyInfo(LoyaltyObject as LULoyalty)
      },
      failure: {error in
        println("There was an error getting the loyalty")
    })
}
  
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func updateLoyaltyInfo(LoyaltyObject: LULoyalty){
    
    self.LoyaltyObject = LoyaltyObject
    
    availableCredit!.text = "\u{2605} You have \(LoyaltyObject.potentialCredit.shortFormatWithSymbol()) in credit!"
    
    SpendToGo!.text = "\(LoyaltyObject.spendRemaining.shortFormatWithSymbol()) to GO!"
    progressBar!.progress = LoyaltyObject.progressPercent
    
    let X = LoyaltyObject.shouldSpend.shortFormatWithSymbol()
    let Y = LoyaltyObject.willEarn.shortFormatWithSymbol()
    spendX!.text = "Spend \(X)"
    earnY!.text = "Earn \(Y)"
    
  }



}

