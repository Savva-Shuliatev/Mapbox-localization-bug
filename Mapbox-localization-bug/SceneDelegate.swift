//
//  SceneDelegate.swift
//  Mapbox-localization-bug
//
//  Created by Savva Shuliatev
//  https://github.com/Savva-Shuliatev
//
//  A minimal showcase app reproducing a Mapbox localization bug and undocumented solution
//  https://github.com/Savva-Shuliatev/Mapbox-localization-bug
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let _ = (scene as? UIWindowScene) else { return }
  }

}

