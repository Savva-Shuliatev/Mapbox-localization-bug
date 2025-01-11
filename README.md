### Mapbox iOS SDK Localization Bug Demo with Undocumented solution

This is a demonstration application that highlights a bug in the Mapbox iOS SDK, where localization does not change as expected.

Issue: https://github.com/mapbox/mapbox-maps-ios/issues/2278

[Mapbox developer answer](https://github.com/mapbox/mapbox-maps-ios/issues/2278#issuecomment-2584083920):

>Hi @Savva-Shuliatev --
>
> Thanks for the report. You are correct that .localizeLabels() does not work for Mapbox Standard (our default style) or Mapbox Satellite Standard. We have an open issue for this here that you can use to follow updates. In short, Mapbox Standard introduced a new basemap approach that changed how layers are handled at runtime. As you've identified, this means that the .localizeLabels() approach to translating map labels does not work for these styles.
>
>If translation using .localizeLabels() is important for your project, I recommend creating a style based on one of our classic styles, such as Mapbox Streets.
>
>The alternative approach you identified here using MapboxCommonSettings remains in preview so we do not recommend it for production applications.
>

### Problem Description

The issue occurs when trying to update the localization programmatically in the code. Despite the expected behavior where localization should change, it does not reflect the changes.

### Expected Behavior

Localization should update dynamically in the application when explicitly set in the code:

```Swift
try! self!.mapView.mapboxMap.localizeLabels(into: Locale(identifier: "ar")) /// No effect
```

The localization remains unchanged, and the expected dynamic update does not occur.

## Undocumented Solution!

Sets up map localization according to the device's current language settings. This utilizes an API that may not be officially documented: 

```Swift
let locale = Locale.current
let settingsService = SettingsServiceFactory.getInstance(storageType: .persistent)
switch settingsService.set(key: MapboxCommonSettings.language, value: "\(locale)") {
case .success:
 print("Successfully set MapboxCommonSettings.language \(locale)")
case .failure(let error):
 assertionFailure("Failed to set MapboxCommonSettings.language with error: \(error)")
}
```

Reference to the blog describing localization support: https://www.mapbox.com/blog/maps-internationalization-34-languages

### Before testing

Set your accessToken:
```Swift
MapboxOptions.accessToken = "your_accessToken"
```

And remove preconditionFailure:
```Swift
preconditionFailure("Set your accessToken!") /// Remove this line
```


### Purpose

The purpose of this application is to serve as a reproducible example of the issue for debugging, testing, or reporting purposes. If you are encountering the same issue, feel free to clone this repository, test it on your environment, or use it to provide feedback to the Mapbox team.
Let us know if you encounter any similar issues or have insights into resolving this bug!
