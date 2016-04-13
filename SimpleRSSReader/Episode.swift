//
//  Episode.swift
//  SimpleRSSReader
//
//  Created by Ocotober Hammer on 4/10/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation

class Episode {

	var title: String?
	var link: String
	var description: String?
	var pubDate: String?
	var guid: String
	var duration: String?
	var itunesAuthor: String?
	var itunesSubtitle: String?
	var image: NSData?
	
	init(title: String?, link: String, description: String?, pubDate: String?, guid: String, duration: String?, itunesAuthor: String?, itunesSubtitle: String?){
		self.description = description
		self.duration = duration
		self.guid = guid
		self.itunesAuthor = itunesAuthor
		self.itunesSubtitle = itunesSubtitle
		self.link = link
		self.pubDate = pubDate
		self.title = title
	}

}