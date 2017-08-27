//
//  FeedParser.swift
//  SimpleRSSReader
//
//  Created by Ocotober Hammer on 3/29/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class FeedParser: NSObject, XMLParserDelegate {
	fileprivate var rssItems:[(title: String, link: String, description: String, pubDate: String, guid: String, duration: String, itunesAuthor: String, itunesSubtitle: String, origLink: String)] = []

	
	let appDelegate = UIApplication.shared.delegate as! AppDelegate
	let singletonModel = SingletonModel.sharedInstance

	
	fileprivate var currentElement: String = ""
	fileprivate var currentTitle: String = "" {
		didSet {
			currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		}
	}
	
	fileprivate var currentItunesAuthor: String = "" {
		didSet {
			currentItunesAuthor = currentItunesAuthor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		}
	}
	
	fileprivate var currentItunesSubtitle: String = "" {
		didSet {
			currentItunesSubtitle = currentItunesSubtitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		}
	}
	
	fileprivate var currentDescription:String = "" {
		didSet {
			currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		}
	}

	fileprivate var currentPubDate:String = "" {
		didSet {
			currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		}
	}

	fileprivate var currentLink:String = "" {
		didSet {
			currentLink = currentLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		}
	}
	
	fileprivate var currentOrigLink:String = "" {
		didSet {
			currentOrigLink = currentOrigLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		}
	}
	
	fileprivate var currentGuid:String = "" {
		didSet {
			currentGuid = currentGuid.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		}
	}
	
	fileprivate var currentDuration:String = "" {
		didSet {
			currentDuration = currentDuration.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		}
	}
	
	fileprivate var parserCompletionHandler: (([(title: String, link: String, description: String, pubDate: String, guid: String, duration: String, itunesAuthor: String, itunesSubtitle: String, origLink: String)]) -> Void)?
	
	func parseFeed(_ feedUrl: String, completionHandler: (([(title: String, link: String, description: String, pubDate: String, guid: String, duration: String, itunesAuthor: String, itunesSubtitle: String, origLink: String)]) -> Void)?) -> Void {
		self.parserCompletionHandler = completionHandler
		
		let request = URLRequest(url: URL(string:feedUrl)!)
		let urlSession = URLSession.shared
		let task = urlSession.dataTask(with: request, completionHandler: {
			(data, response, error) -> Void in
			
			guard let data = data else {
				if let error = error {
					print(error)
				}
				return
			}
			
			let parser = XMLParser(data:data)
			parser.delegate = self
			parser.parse()
		})
		
		task.resume()

	}
	
	
	func parserDidStartDocument(_ parser: XMLParser) {
		rssItems = []
		appDelegate.rssItems = []
	}
	
	
	
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
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
			currentOrigLink = ""
		}
	}
	

	func parser(_ parser: XMLParser, foundCharacters string: String) {
		switch currentElement {
		case "title": currentTitle += string
		case "description": currentDescription += string
		case "pubdate": currentPubDate += string
		case  "duration": currentDuration += string
		case "link": currentLink += string
		case "guid": currentGuid += string
		case "itunes:author": currentItunesAuthor += string
		case "itunes:subtitle": currentItunesSubtitle += string
		case "feedburner:origLink": currentOrigLink += string
		default: break
		}
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == "item" {
//			let rssItem = (title: currentTitle, link: currentLink, description: currentDescription, pubDate: currentPubDate, guid: currentGuid, duration: currentDuration, itunesAuthor: currentItunesAuthor, itunesSubtitle: currentItunesSubtitle, origLink: currentOrigLink)
			let rssItem = Episode(title: currentTitle, link: currentLink, description: currentDescription, pubDate: currentPubDate, guid: currentGuid, duration: currentDuration, itunesAuthor: currentItunesAuthor, itunesSubtitle: currentItunesSubtitle, origLink: currentOrigLink)
//			rssItems += [rssItem]
			singletonModel.arrayOfEpisodes += [rssItem]
			
		}
	}
	
	func parserDidEndDocument(_ parser: XMLParser) {
		parserCompletionHandler?(rssItems)
	}
	
	
	func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
		print(parseError.localizedDescription)
	}
	
	
	
	
	
	
	
	
	
	
	
}
