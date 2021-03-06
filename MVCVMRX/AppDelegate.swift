//
//  AppDelegate.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 20/03/2022.
//

import UIKit
import MOLH
import Localize_Swift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        if MOLHLanguage.isArabic(){
            MOLH.setLanguageTo("ar")
            Constants.applanuage = "ar"
        }
        else{
            MOLH.setLanguageTo("en")
            Constants.applanuage = "en"
        }
        MOLH.shared.specialKeyWords = ["Cancel","Done"]
        
        return true
    }



}

