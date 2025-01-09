//
//  ViewController.swift
//  Mapbox-localization-bug
//
//  Created by Savva Shuliatev on 09.01.2025.
//

import UIKit
import Combine
import MapboxMaps

class ViewController: UIViewController {

  private lazy var mapView = MapView(frame: .zero)

  private var cancellables: Set<AnyCancellable> = []

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

      /// Undocumented Solution
      // self!.localizeMap()
    }
    .store(in: &cancellables)
  }

  /// Solution:
  /// Sets up map localization according to the device's current language settings.
  /// This utilizes an API that may not be officially documented.
  /// Reference to the blog describing localization support:
  /// https://www.mapbox.com/blog/maps-internationalization-34-languages
  private func localizeMap() {
    let locale = Locale.current
    let settingsService = SettingsServiceFactory.getInstance(storageType: .persistent)
    switch settingsService.set(key: MapboxCommonSettings.language, value: "\(locale)") {
    case .success:
      print("Successfully set MapboxCommonSettings.language \(locale)")
    case .failure(let error):
      assertionFailure("Failed to set MapboxCommonSettings.language with error: \(error)")
    }
  }

}

