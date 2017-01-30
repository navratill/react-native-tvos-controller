import {
  NativeModules,
  NativeEventEmitter
} from 'react-native';

const nativeEventEmitter = new NativeEventEmitter(NativeModules.ReactNativeTvosController);

module.exports = {
    connect: function(){
        NativeModules.ReactNativeTvosController.connect();
    },
    enablePanGesture: function(){
        NativeModules.ReactNativeTvosController.enablePanGesture();
    },
    disablePanGesture: function(){
        NativeModules.ReactNativeTvosController.disablePanGesture();
    },
    subscribe: function(event, callback){
        nativeEventEmitter.addListener(event, callback);
        return function(){
            nativeEventEmitter.removeListener(event, callback);
        }
    }
}