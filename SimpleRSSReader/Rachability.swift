//
//  Rachability.swift
//  ParseStarterProject-Swift
//
//  Created by Ocotober Hammer on 4/5/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import SystemConfiguration

//if Reachability.isConnectedToNetwork() == true {
//	println("Internet connection OK")
//} else {
//	println("Internet connection FAILED")
//}

//if Reachability.isConnectedToNetwork() == true {
//	println("Internet connection OK")
//} else {
//	println("Internet connection FAILED")
//	var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
//	alert.show()
//}

open class Reachability {
	
	class func isConnectedToNetwork() -> Bool {
		
		var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
		zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
		zeroAddress.sin_family = sa_family_t(AF_INET)
		
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)}
        } ) else {
            return false 
        }
		
		var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
		if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
			return false
		}
		
		let isReachable = flags == .reachable
		let needsConnection = flags == .connectionRequired
		
		return isReachable && !needsConnection
		
	}
}
