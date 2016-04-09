//
//  FeedParser.swift
//  SimpleRSSReader
//
//  Created by Ocotober Hammer on 3/29/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class FeedParser: NSObject, NSXMLParserDelegate {
	private var rssItems:[(title: String, link: String, description: String, pubDate: String, guid: String, duration: String, itunesAuthor: String, itunesSubtitle: String)] = []
	private var currentElement: String = ""
	private var currentTitle: String = "" {
		didSet {
			currentTitle = currentTitle.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		}
	}
	
	private var currentItunesAuthor: String = "" {
		didSet {
			currentItunesAuthor = currentItunesAuthor.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		}
	}
	
	private var currentItunesSubtitle: String = "" {
		didSet {
			currentItunesSubtitle = currentItunesSubtitle.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
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
	
	private var parserCompletionHandler: ([(title: String, link: String, description: String, pubDate: String, guid: String, duration: String, itunesAuthor: String, itunesSubtitle: String)] -> Void)?
	
	func parseFeed(feedUrl: String, completionHandler: ([(title: String, link: String, description: String, pubDate: String, guid: String, duration: String, itunesAuthor: String, itunesSubtitle: String)] -> Void)?) -> Void {
		self.parserCompletionHandler = completionHandler
		
		let request = NSURLRequest(URL: NSURL(string:feedUrl)!)
		let urlSession = NSURLSession.sharedSession()
		let task = urlSession.dataTaskWithRequest(request, completionHandler: {
			(data, response, error) -> Void in
			
			guard let data = data else {
				if let error = error {
					print(error)
				}
				return
			}
			
			let parser = NSXMLParser(data:data)
			parser.delegate = self
			parser.parse()
		})
		
		task.resume()
		
		
		
		
		
		
	}
	
	
	func parserDidStartDocument(parser: NSXMLParser) {
		rssItems = []
	}
	
	
	
	func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
		currentElement = elementName
		
		if currentElement == "item" {
			currentTitle = ""
			currentLink = ""
			currentGuid = ""
			currentPubDate = ""
			currentDuration = ""
			currentDescription = ""
			currentItunesAuthor = ""
			currentItunesSubtitle = ""
		}
	}
	

	func parser(parser: NSXMLParser, foundCharacters string: String) {
		switch currentElement {
		case "title": currentTitle += string
		case "description": currentDescription += string
		case "pubdate": currentPubDate += string
		case  "duration": currentDuration += string
		case "link": currentLink += string
		case "guid": currentGuid += string
		case "itunes:author": currentItunesAuthor += string
		case "itunes:subtitle": currentItunesSubtitle += string
		default: break
		}
	}
	
	func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == "item" {
			let rssItem = (title: currentTitle, link: currentLink, description: currentDescription, pubDate: currentPubDate, guid: currentGuid, duration: currentDuration, itunesAuthor: currentItunesAuthor, itunesSubtitle: currentItunesSubtitle)
			rssItems += [rssItem]
		}
	}
	
	func parserDidEndDocument(parser: NSXMLParser) {
		parserCompletionHandler?(rssItems)
	}
	
	
	func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
		print(parseError.localizedDescription)
	}
	
	
	
	
	
	
	
	
	
	
	
}
