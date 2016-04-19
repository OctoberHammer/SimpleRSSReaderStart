//
//  Download.swift
//  SimpleRSSReader
//
//  Created by Ocotober Hammer on 4/15/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation

class Download: NSObject {
	var url: String
	var isDownloading = false
	var progress: Float = 0.0
	var downloadTask: NSURLSessionDownloadTask?
	var resumeData: NSData?
	
	init(url: String) {
		self.url = url
	}
}
