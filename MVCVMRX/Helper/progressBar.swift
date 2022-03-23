//
//  progressBar.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 23/03/2022.
//

import Foundation
import SVProgressHUD

class ProgressLoaderHUD {
    
    static func showLoader() {
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
    }
    
    static func hideLoader() {
        SVProgressHUD.dismiss()
    }
}
