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

class FirstViewController: UIViewController {
  @IBOutlet weak var QRImageView: UIImageView!
  var paymentToken: LUPaymentToken?

  override func viewDidLoad() {
    super.viewDidLoad()

    let request: LUAPIRequest = LUPaymentTokenRequestFactory.requestForPaymentToken()
    LUAPIClient.sharedClient().performRequest(request,
      success: { token, response in
        self.paymentToken = token as? LUPaymentToken
        self.refreshQRCode()
      },
      failure: { error in
        println("There was an error getting the Payment Token")
        println(error)
    })
  }

  func refreshQRCode() {
    if paymentToken!.data.isEmpty {
      return
    }

    QRImageView!.image = LUPaymentQRCodeGenerator.QRCodeFromPaymentToken(paymentToken!.data)
  }
}
