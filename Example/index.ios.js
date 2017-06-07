/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

import reactNativeTvosController from "react-native-tvos-controller";

reactNativeTvosController.connect();
reactNativeTvosController.enablePanGesture();
// reactNativeTvosController.disablePanGesture(); // uncomment to disable Pan Gesture
var tapSubscription = reactNativeTvosController.subscribe('TAP',
    (e) => {
      console.log("tapped");
      console.log(JSON.stringify(e));
    });
var swipeSubscription = reactNativeTvosController.subscribe('SWIPE',
    (e) => {
      console.log("swiped");
      console.log(JSON.stringify(e));
    });
var longPressSubscription = reactNativeTvosController.subscribe('LONGPRESS',
    (e) => {
      console.log("longPressed");
      console.log(JSON.stringify(e));
    });
var panSubscription = reactNativeTvosController.subscribe('PAN',
    (e) => {
      console.log("panned");
      console.log(JSON.stringify(e));
    });
export default class reactNativeTvosProject extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('reactNativeTvosProject', () => reactNativeTvosProject);
