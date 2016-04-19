//
//  SingletonModel.swift
//  SimpleRSSReader
//
//  Created by Ocotober Hammer on 4/18/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation




class SingletonModel {
	static let sharedInstance = SingletonModel()
	var counter = 0
	var dictOfEpisodes = [String: Episode]()
	var arrayOfEpisodes = [Episode]()
	
	func incrementCounter() {
		counter += 1
	}
	
	private init(){
	
	}
}