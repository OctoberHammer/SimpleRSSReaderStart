//
//  NewsTableViewController.swift
//  SimpleRSSReader
//
//  Created by Simon Ng on 13/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
	
	fileprivate var rssItems: [(title: String, link: String, description: String, pubDate: String, guid: String, duration: String, itunesAuthor: String, itunesSubtitle: String, origLink: String)]?
	
	let appDelegate : AppDelegate = AppDelegate().sharedInstance()
	var rssItems1: [Episode]?
	let singletonModel = SingletonModel.sharedInstance
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.register(UINib(nibName: "ExpandedEpisodeCell", bundle: nil), forCellReuseIdentifier: "expandedEpisodeCell")
		
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
				OperationQueue.main.addOperation({ () -> Void in
					self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
			})
    })
		
	}


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
//		guard let rssItems1 = singletonModel.arrayOfEpisodes else {
//			return 0
//		}
		return singletonModel.arrayOfEpisodes.count //rssItems1.count
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
		let item = singletonModel.arrayOfEpisodes[indexPath.row]
			if !item.isSelected {
				let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
				cell.titleLabel.text = item.title
				cell.descriptionLabel.text = item.itunesSubtitle
				cell.dateLabel.text = item.pubDate
				cell.tag = indexPath.row
				return cell
			} else {
				let cell = tableView.dequeueReusableCell(withIdentifier: "expandedEpisodeCell", for: indexPath) as! ExpandedEpisodeCell
				cell.titleLabel.text = item.title
				cell.descriptionLabel.text = item.itunesSubtitle
				cell.dateLabel.text = item.pubDate
				cell.tag = indexPath.row
				cell.fullContentLabel.attributedText = item.reachtextContent
				return cell
			}

//		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let item = singletonModel.arrayOfEpisodes[indexPath.row]
		
		
		item.isSelected = !item.isSelected
		item.reachtextContent = item.description?.html2AttributedString
		if item.isSelected{
			tableView.reloadRows(
				at: [indexPath],
				with:UITableViewRowAnimation.left)
		} else {
			tableView.reloadRows(
				at: [indexPath],
				with:UITableViewRowAnimation.right)
		}
		tableView.deselectRow(at: indexPath, animated:false)
		return
		

	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showSpecificEpisode" {
			let sendingCell = sender as! NewsTableViewCell;
			//print("\(sendingCell.tag)")
			let index = sendingCell.tag;
			let currentEpisode = rssItems1?[index]
			let oneEpisodeViewController = segue.destination as! OneEpisodeViewController
			oneEpisodeViewController.currentEpisode = currentEpisode
		}
	}
}
