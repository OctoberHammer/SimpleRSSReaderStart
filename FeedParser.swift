//
//  FeedParser.swift
//  SimpleRSSReader
//
//  Created by Ocotober Hammer on 3/29/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class FeedParser: NSObject, NSXMLParserDelegate {
	private var rssItems:[(title: String, link: String, description: String, pubDate: String, guid: String, duration: String)] = []
	private var currentElement: String = ""
	private var currentTitle: String = "" {
		didSet {
			currentTitle = currentTitle.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		}
	}
	
	private var currentDescription:String = "" {
		didSet {
			currentDescription = currentDescription.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		}
	}

	private var currentPubDate:String = "" {
		didSet {
			currentPubDate = currentPubDate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		}
	}

	private var currentLink:String = "" {
		didSet {
			currentLink = currentLink.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		}
	}
	
	private var currentGuid:String = "" {
		didSet {
			currentGuid = currentGuid.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		}
	}
	
	private var currentDuration:String = "" {
		didSet {
			currentDuration = currentDuration.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		}
	}
	
	private var parserCompletionHandler: ([(title: String, link: String, description: String, pubDate: String, guid: String, duration: String)] -> Void)?
	
}
