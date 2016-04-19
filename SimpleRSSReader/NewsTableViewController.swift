//
//  NewsTableViewController.swift
//  SimpleRSSReader
//
//  Created by Simon Ng on 13/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
	
	private var rssItems: [(title: String, link: String, description: String, pubDate: String, guid: String, duration: String, itunesAuthor: String, itunesSubtitle: String, origLink: String)]?
	
	let appDelegate : AppDelegate = AppDelegate().sharedInstance()
	var rssItems1: [Episode]?
	let singletonModel = SingletonModel.sharedInstance
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.registerNib(UINib(nibName: "ExpandedEpisodeCell", bundle: nil), forCellReuseIdentifier: "expandedEpisodeCell")
		
		if Reachability.isConnectedToNetwork() == true {
			print("Internet connection OK")
		} else {
			print("Internet connection FAILED")
		}
		
		let singletonModel = SingletonModel.sharedInstance

		
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableViewAutomaticDimension
		
		let feedParser = FeedParser()
		feedParser.parseFeed("https://feeds.feedburner.com/EnglishAsASecondLanguagePodcast",
			completionHandler: {
				(rssItems: [(title: String, link: String, description: String, pubDate: String, guid: String, duration: String, itunesAuthor: String, itunesSubtitle: String, origLink: String)]) -> Void
			in
				self.rssItems = rssItems
				self.rssItems1 =  self.appDelegate.rssItems
				NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
					self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
			})
    })
		
	}


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
//		guard let rssItems1 = singletonModel.arrayOfEpisodes else {
//			return 0
//		}
		return singletonModel.arrayOfEpisodes.count //rssItems1.count
    }

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsTableViewCell
		let item = singletonModel.arrayOfEpisodes[indexPath.row]
			if !item.isSelected {
				let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsTableViewCell
				cell.titleLabel.text = item.title
				cell.descriptionLabel.text = item.itunesSubtitle
				cell.dateLabel.text = item.pubDate
				cell.tag = indexPath.row
				return cell
			} else {
				let cell = tableView.dequeueReusableCellWithIdentifier("expandedEpisodeCell", forIndexPath: indexPath) as! ExpandedEpisodeCell
				cell.titleLabel.text = item.title
				cell.descriptionLabel.text = item.itunesSubtitle
				cell.dateLabel.text = item.pubDate
				cell.tag = indexPath.row
				cell.fullContentLabel.attributedText = item.reachtextContent
				return cell
			}

//		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		let item = singletonModel.arrayOfEpisodes[indexPath.row]
		
		
		item.isSelected = !item.isSelected
		item.reachtextContent = item.description?.html2AttributedString
		if item.isSelected{
			tableView.reloadRowsAtIndexPaths(
				[indexPath],
				withRowAnimation:UITableViewRowAnimation.Left)
		} else {
			tableView.reloadRowsAtIndexPaths(
				[indexPath],
				withRowAnimation:UITableViewRowAnimation.Right)
		}
		tableView.deselectRowAtIndexPath(indexPath, animated:false)
		return
		

	}
	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showSpecificEpisode" {
			let sendingCell = sender as! NewsTableViewCell;
			//print("\(sendingCell.tag)")
			let index = sendingCell.tag;
			var currentEpisode = rssItems1?[index]
			var oneEpisodeViewController = segue.destinationViewController as! OneEpisodeViewController
			oneEpisodeViewController.currentEpisode = currentEpisode
		}
	}
}
