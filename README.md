# react-native-tvos-controller

[![npm version](https://badge.fury.io/js/react-native-tvos-controller.svg)](https://badge.fury.io/js/react-native-tvos-controller)
[![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/jondot/awesome-react-native)

TvOS remote controller module for react native.
Including "tap","long press","swipe" and "pan" gesture.

[React Native for TVOS](https://medium.com/@7ynk3r/react-native-apple-tv-today-48beb398a1ab#.5pp5drlyy)

[react-native-tvos-controller demo video](https://youtu.be/pou8ffWY8EY)

## Install

```shell
npm install --save react-native-tvos-controller
```

## Automatically link

#### With React Native 0.27+

```shell
react-native link react-native-tvos-controller
```

#### With older versions of React Native

You need [`rnpm`](https://github.com/rnpm/rnpm) (`npm install -g rnpm`)

```shell
rnpm link react-native-tvos-controller
```

## Manually link
If *Automatically link* can't work, you should link the module manually.
[Manually Link Tutorial](https://facebook.github.io/react-native/docs/linking-libraries-ios.html#manual-linking)

1. Add the following to your Project: node_modules/react-native-tvos-controller/ReactNativeTvosController/ReactNativeTvosController.xcodeproj

2. Add the following to Link Binary With Libraries: libReactNativeTvosController.a

3. Add the following to your Header Search Paths: $(SRCROOT)/../node_modules/react-native-tvos-controller/ReactNativeTvosController/ReactNativeTvosController

## Usage

```javascript
import reactNativeTvosController from "react-native-tvos-controller"
```

### connect

```javascript
reactNativeTvosController.connect()
```
Connect the remote controller of apple TV.

### enablePanGesture

```javascript
reactNativeTvosController.enablePanGesture();
```
You will receive the specific moving offset tracing data if you enable the pan gesture.
You can't receive the swipe event anymore.

### disablePanGesture

```javascript
reactNativeTvosController.disablePanGesture();
```
You won't receive the specific moving offset tracing data if you disable the pan gesture.
You can continue receiving the swipe event.

### subscribe

Subscribe the native events of Apple TV's remote controller.

#### events

##### TAP

```javascript
var tapSubscription = reactNativeTvosController.subscribe('TAP',
    (e) => {
      console.log("tapped");
      console.log(JSON.stringify(e));
      /*
      e.type : "PlayPause" || "Menu" || "Select" || "UpArrow" || "DownArrow" || "LeftArrow" || "RightArrow"
      e.code : 0 || 1 || 2 || 3 || 4 || 5 || 6
      */
    });
    tapSubscription(); //Cancel Subscription 
```

##### SWIPE

```javascript
var swipeSubscription = reactNativeTvosController.subscribe('SWIPE',
    (e) => {
      console.log("swiped");
      console.log(JSON.stringify(e));
      /*
      e.direction : "Right" || "Down" || "Left" || "Up"
      e.code : 0 || 1 || 2 || 3 
      */
    });
    swipeSubscription(); //Cancel Subscription 
```

##### LONGPRESS

```javascript
var longPressSubscription = reactNativeTvosController.subscribe('LONGPRESS',
    (e) => {
      console.log("longPressed");
      console.log(JSON.stringify(e));
      /*
      e.state : "Began" || "Ended"
      e.code : 0 || 1
      */
    });
    longPressSubscription(); //Cancel Subscription
```

##### PAN

```javascript
var panSubscription = reactNativeTvosController.subscribe('PAN',
    (e) => {
      console.log("panned");
      console.log(JSON.stringify(e));
      /*
      e.state : "Changed"
      e.x : (x offset)
      e.y : (y offset)
      */
    });
    panSubscription(); //Cancel Subscription
```















