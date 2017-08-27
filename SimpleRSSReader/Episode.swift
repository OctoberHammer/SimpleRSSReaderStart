//
//  Episode.swift
//  SimpleRSSReader
//
//  Created by Ocotober Hammer on 4/10/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation
import UIKit

extension String {
	
	var html2AttributedString: NSAttributedString? {
		guard
			let data = data(using: String.Encoding.utf8)
			else { return nil }
		do {
            let result = try NSAttributedString(data: data, options:[NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return result
		} catch let error as NSError {
			print(error.localizedDescription)
			return  nil
		}
	}
	var html2String: String {
		return html2AttributedString?.string ?? ""
	}
}


class Episode {

	var title: String?
	var link: String
	var description: String?
	var pubDate: String?
	var guid: String
	var duration: String?
	var itunesAuthor: String?
	var itunesSubtitle: String?
	var image: Data?
	var reachtextContent: NSAttributedString?
	var isSelected = false
	var origLink: String?
	
	init(title: String?, link: String, description: String?, pubDate: String?, guid: String, duration: String?, itunesAuthor: String?, itunesSubtitle: String?, origLink: String?){
		self.description = description
		self.duration = duration
		self.guid = guid
		self.itunesAuthor = itunesAuthor
		self.itunesSubtitle = itunesSubtitle
		self.link = link
		self.pubDate = pubDate
		self.title = title
		self.origLink = origLink
	}

}
