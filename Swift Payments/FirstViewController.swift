//
//  FirstViewController.swift
//  Swift Payments
//
//  Created by Daniel Schlitt on 8/21/14.
//  Copyright (c) 2014 SCVNGR. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
                            
  @IBOutlet weak var QRImageView: UIImageView!
  var paymentToken: LUPaymentToken?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    let request: LUAPIRequest = LUPaymentTokenRequestFactory.requestForPaymentToken()
    LUAPIClient.sharedClient().performRequest(request,
      success: {token, response in
        self.paymentToken = token as? LUPaymentToken
        self.refreshQRCode()
      },
      failure: {error in
        println("There was an error getting the Payment Token")
        println(error)
        //UIAlerView
    })

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  func refreshQRCode(){
    if paymentToken!.data.isEmpty{
      return
    }
    QRImageView!.image = LUPaymentQRCodeGenerator.QRCodeFromPaymentToken(paymentToken!.data)
    
    }
}

