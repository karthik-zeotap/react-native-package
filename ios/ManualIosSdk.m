#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ManualIosSdk, NSObject)
RCT_EXTERN_METHOD(initSDK)
RCT_EXTERN_METHOD(setEventNameProperties: (NSString *)eventName);
RCT_EXTERN_METHOD(setEventProperties: (NSString *)eventName event:(NSDictionary *) eventProp)
RCT_EXTERN_METHOD(setInstantEventNameProperties: (NSString *)eventName);
RCT_EXTERN_METHOD(setInstantEventProperties: (NSString *)eventName event:(NSDictionary *) eventProp)
RCT_EXTERN_METHOD(setUserProperties: (NSDictionary *) user)
RCT_EXTERN_METHOD(setUserIdentities: (NSDictionary *) user)
RCT_EXTERN_METHOD(setPageProperties: (NSDictionary *) page)
RCT_EXTERN_METHOD(setConsent: (NSDictionary *) consent)
RCT_EXTERN_METHOD(unsetUserIdentities)
RCT_EXTERN_METHOD(deInitiate)
RCT_EXTERN_METHOD(reInitialize)
RCT_EXTERN_METHOD(addAskForConsentListener: (RCTResponseSenderBlock *) cb)
RCT_EXTERN_METHOD(getZI: (RCTResponseSenderBlock *) callback)
RCT_EXTERN_METHOD(resetZI)
RCT_EXTERN_METHOD(hashUserIdentitiesAndSet: (NSDictionary *) user useOld:(BOOL *) useOldCellConfig)
@end
