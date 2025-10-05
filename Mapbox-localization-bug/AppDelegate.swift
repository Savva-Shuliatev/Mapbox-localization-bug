//
//  AppDelegate.swift
//  Mapbox-localization-bug
//
//  Created by Savva Shuliatev
//  https://github.com/Savva-Shuliatev
//
//  A minimal showcase app reproducing a Mapbox localization bug and undocumented solution
//  https://github.com/Savva-Shuliatev/Mapbox-localization-bug
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(
      name: "Default Configuration",
      sessionRole: connectingSceneSession.role
    )
  }

}

