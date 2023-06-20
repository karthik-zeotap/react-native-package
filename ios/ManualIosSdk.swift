import ZeotapCollect

@objc(ManualIosSdk)
class ManualIosSdk: NSObject {
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
      }
      
      @objc func initSDK() {
          print("Teest, inside package, inside initSDK")
          var collectOptions = CollectOption()
          collectOptions = collectOptions.writeKey(value: "abc")
          Collect.initialize(option: collectOptions.build())
      }

      
    @objc func setEventProperties(_ eventName: String, event eventProp: NSDictionary) {
      let prop = eventProp as! Dictionary<String,NSObject>
      if !prop.isEmpty {
        Collect.getInstance()?.setEventProperties(eventName, prop)
      }
    }
    @objc func setEventNameProperties(_ eventName: String) {
        print("Teest, inside package, inside setEventNameProperties")
      Collect.getInstance()?.setEventProperties(eventName)
    }
    @objc func setInstantEventNameProperties(_ eventName: String) {
      Collect.getInstance()?.setInstantEventProperties(eventName)
    }
    @objc func setInstantEventProperties(_ eventName: String, event eventProp: [String: NSObject]) {
      Collect.getInstance()?.setInstantEventProperties(eventName, eventProp)
    }
    @objc func setUserProperties(_ user: [String: NSObject]) {
      Collect.getInstance()?.setUserProperties(user)
    }
    @objc func setPageProperties(_ page: [String: NSObject]) {
      Collect.getInstance()?.setPageProperties(page)
    }
    @objc func setUserIdentities(_ user: [String: NSObject]) {
      Collect.getInstance()?.setUserIdentities(user)
    }
    @objc func setConsent(_ consent: [String: NSObject]) {
      Collect.getInstance()?.setConsent(consent: consent)
    }
    @objc func addAskForConsentListener(_ cb: @escaping RCTResponseSenderBlock) {
      print("Test app: Executing addAskForConsentListener \n")
      Collect.getInstance()?.listenToAskForConsent(action: { _data in
        print("Test app: Executing callback \n")
        cb([])
      })
    }
    @objc func unsetUserIdentities() {
      Collect.getInstance()?.unsetUserIdentities()
    }
    @objc func deInitiate() {
      Collect.getInstance()?.pauseCollection()
    }
    @objc func reInitialize() {
      Collect.getInstance()?.resumeCollection()
    }
    @objc func getZI(_ callback: @escaping RCTResponseSenderBlock) {
      let zi = Collect.getInstance()?.getZI()
      callback([zi ?? ""])
    }
    @objc func resetZI() {
      Collect.getInstance()?.resetZI()
    }
    func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format: "%02x", UInt8(byte))
        }
        return hexString
    }
    func sha256(str: String) -> String {
        let strData = str.data(using: .utf8)
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        strData?.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(strData!.count), &hash)
        }
        return hexStringFromData(input: NSData(bytes: hash, length: digestLength))
    }
    
    @objc func hashUserIdentitiesAndSet(_ user: [String: NSObject], useOld useOldCellConfig : Bool) {
      var ids: [String: Any] = [:]
      for (key, value) in user {
        switch key {
        case "email":
          ids["email_sha256_lowercase"] = sha256(str: (value as! String).lowercased())
        case "loginid":
          ids["loginid_sha256_lowercase"] = sha256(str: (value as! String).lowercased())
        case "cellno":
          if ((value as! String).contains(" ")){
            let stringArray = (value as! String).components(separatedBy: " ")
            ids["cellno_without_country_code_sha256"] = sha256(str: stringArray[1] )
            ids["cellno_with_country_code_sha256"] = sha256(str: stringArray[0] + stringArray[1] )
            ids["cellno_e164_sha256"] = sha256(str: "+" + sha256(str: stringArray[0] + stringArray[1] ))
          }
          else {
            ids["cellno_without_country_code_sha256"] = sha256(str: value as! String)
          }
        case "cellno_cc":
        if(useOldCellConfig){
          ids["cellno_with_country_code_sha256"] = sha256(str: value as! String)
        }
          
        default:
          ids[key] = value
        }
      }
      Collect.getInstance()?.setUserIdentities(ids)
    }
    
    
}
