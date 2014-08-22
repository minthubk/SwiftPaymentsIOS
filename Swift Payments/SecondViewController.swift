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

