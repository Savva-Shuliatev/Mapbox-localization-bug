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
    }
    .store(in: &cancellables)
  }


}

