//
//  AppDelegate.swift
//  Tommy
//
//  Created by Arman on 25/06/2020.
//  Copyright © 2020 Arman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let dataController = DataController(modelName: "TommyDB")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        dataController.load()
        
        guard let controller = window?.rootViewController as? UITabBarController else {
            fatalError("Unexpected Root View Controller")
        }
        
        for child in controller.viewControllers! {
            if let vc = child as? UINavigationController  {
                for viewController in vc.viewControllers{
                    if let gallery = viewController as? GalleryViewController {
                        gallery.dataController = dataController
                    }else if let favorite = viewController as? FavoriteListController {
                        favorite.dataController = dataController
                    }
                }
                
            }
        }

        return true
    }

}

