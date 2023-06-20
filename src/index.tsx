import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-manual-ios-sdk' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const ManualIosSdk = NativeModules.ManualIosSdk
  ? NativeModules.ManualIosSdk
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function multiply(a: number, b: number): Promise<number> {
  return ManualIosSdk.multiply(a, b);
}

export function initSDK() {
  return ManualIosSdk.initSDK();
}


export function setEventNameProperties(s: String) {
  return ManualIosSdk.setEventNameProperties(s);
}
