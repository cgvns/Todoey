//
//  AppDelegate.swift
//  Todoey
//
//  Created by macbookpro on 16/9/18.
//  Copyright © 2018 macbookpro. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
  
        
//        Below line prints loaction of realm database
//        print(Realm.Configuration.defaultConfiguration.fileURL)

        
        do {
            let realm = try Realm()
            realm.autorefresh = true
        } catch{
            print("Error initialising new realm, \(error)")
        }
        
        return true
    }





















