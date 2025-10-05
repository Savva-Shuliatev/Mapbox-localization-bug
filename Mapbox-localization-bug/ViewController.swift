//
//  ViewController.swift
//  Mapbox-localization-bug
//
//  Created by Savva Shuliatev
//  https://github.com/Savva-Shuliatev
//
//  A minimal showcase app reproducing a Mapbox localization bug and undocumented solution
//  https://github.com/Savva-Shuliatev/Mapbox-localization-bug
//

import UIKit
import Combine
import MapboxMaps

class ViewController: UIViewController {

  let mapView = MapView(frame: .zero)

  var cancellables: Set<AnyCancellable> = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(mapView)
    mapView.frame = view.bounds

    preconditionFailure("Set your accessToken!")
    MapboxOptions.accessToken = ""

    mapView.mapboxMap.onMapLoaded.observe { [weak self] _ in
      /// https://docs.mapbox.com/help/troubleshooting/change-language/#mapbox-maps-sdk-for-ios
      try! self!.mapView.mapboxMap.localizeLabels(into: Locale(identifier: "ar"))
      /// No effect

      /// Undocumented solution
      // self!.localizeMap()
    }
    .store(in: &cancellables)
  }

  /// Solution:
  /// Sets up map localization according to the device's current language settings.
  /// This utilizes an API that may not be officially documented.
  /// Reference to the blog describing localization support:
  /// https://www.mapbox.com/blog/maps-internationalization-34-languages
  func localizeMap() {
    let locale = getLocale()
    let settingsService = SettingsServiceFactory.getInstance(storageType: .persistent)
    switch settingsService.set(key: MapboxCommonSettings.language, value: locale) {
    case .success:
      print("Successfully set MapboxCommonSettings.language \(locale)")
    case .failure(let error):
      assertionFailure("Failed to set MapboxCommonSettings.language with locale: \(locale.debugDescription) with error: \(error)")
    }
  }

  /// Use a valid language/locale code for Mapbox (e.g., "en", "en-US").
  /// Avoid `Locale.current` or full string representations (e.g., "en_DE (current)") —
  /// they can break styles (blank map, missing labels) and trigger errors like:
  /// [Mapbox] [Warning, maps-core]: ... ?language=en_DE (current): unsupported URL(4)
  /// [Mapbox] [Error, maps-core/style]: Failed to load source composite: unsupported URL
  /// Prefer the user's first preferred language or a safe default.
  func getLocale() -> String {
    Locale.preferredLanguages.first ?? "ar"
  }

}

