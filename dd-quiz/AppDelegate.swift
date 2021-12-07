//
//  AppDelegate.swift
//  dd-quiz
//
//  Created by Jack Wang on 10/26/21.
//

import UIKit
import Datadog

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        //init Datadog
//        Datadog.initialize(
//            appContext: .init(),
//            trackingConsent: .granted,
//            configuration: Datadog.Configuration
//            .builderUsing(
//                rumApplicationID: "135521e8-c318-4942-b55f-87e25e309ad4",
//                clientToken: "pub2e368f8be370929c4e334df09304804d",
//                environment:"dev"
//            )
//            .trackUIKitRUMActions()
//            .trackUIKitRUMViews(using: DefaultUIKitRUMViewsPredicate())
//            .trackURLSession(firstPartyHosts: ["datadoghq.com"])
//            .build()
//        )
//        Datadog.verbosityLevel = .debug
//
//        Global.rum = RUMMonitor.initialize()

        // Capture RUM resources with Datadog DDURLSessionDelegate:
        let session = URLSession(
            configuration: .default,
            delegate: DDURLSessionDelegate(),
            delegateQueue: nil
        )
                                    
        
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

