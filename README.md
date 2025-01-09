### Mapbox iOS SDK Localization Bug Demo

This is a demonstration application that highlights a bug in the Mapbox iOS SDK, where localization does not change as expected.

### Problem Description

The issue occurs when trying to update the localization programmatically in the code. Despite the expected behavior where localization should change, it does not reflect the changes.

### Expected Behavior

Localization should update dynamically in the application when explicitly set in the code:

```Swift
try! self!.mapView.mapboxMap.localizeLabels(into: Locale(identifier: "ar")) /// No effect
```

The localization remains unchanged, and the expected dynamic update does not occur.

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
