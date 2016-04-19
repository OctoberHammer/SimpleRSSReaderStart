//
//  OneEpisodeViewController.swift
//  SimpleRSSReader
//
//  Created by Ocotober Hammer on 4/13/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit



class OneEpisodeViewController: UITableViewController, NSURLSessionDownloadDelegate {

	@IBOutlet weak var episodeTitle: UILabel!
	@IBOutlet weak var controllCell: ControllCell!
	@IBOutlet weak var licenceCell: LicenceCell!
	@IBOutlet weak var episodeContentCell: EpisodeContentCell!
	var currentEpisode: Episode?
	
	@IBOutlet weak var licelnseLabel: UILabel!

	@IBOutlet weak var episodeContent: UILabel!
	var activeDownload: (String, Download)?
	
	var downloadTask: NSURLSessionDownloadTask!
	var backgroundSession: NSURLSession!
	
	lazy var downloadSession: NSURLSession =  {
		let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
		let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
		return session
	} ()
	
//	
//	func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
//		print("Finished downloading.")
//	}
//	
	// 1
	func URLSession(session: NSURLSession,
	                downloadTask: NSURLSessionDownloadTask,
	                didFinishDownloadingToURL location: NSURL){
		
		let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
		let documentDirectoryPath:String = path[0]
		let fileManager = NSFileManager()
		let destinationURLForFile = NSURL(fileURLWithPath: documentDirectoryPath.stringByAppendingString("/file.html"))
		print ("\(destinationURLForFile.path!)")
		if fileManager.fileExistsAtPath(destinationURLForFile.path!){
			//showFileWithPath(destinationURLForFile.path!)
		}
		else{
			do {
//				try fileManager.moveItemAtURL(location, toURL: destinationURLForFile)
//				// show file
//				showFileWithPath(destinationURLForFile.path!)
			}catch{
				print("An error occurred while moving file to destination url")
			}
		}
	}
	
	// 2
	func URLSession(session: NSURLSession,
	                downloadTask: NSURLSessionDownloadTask,
	                didWriteData bytesWritten: Int64,
	                             totalBytesWritten: Int64,
	                             totalBytesExpectedToWrite: Int64){
		print(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite))
	}
	
	
	func URLSession(session: NSURLSession,
	                task: NSURLSessionTask,
	                didCompleteWithError error: NSError?){
		downloadTask = nil
		//progressView.setProgress(0.0, animated: true)
		if (error != nil) {
			print(error?.description)
		}else{
			print("The task finished transferring data successfully")
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		
		let titleOfCurrentEpisode = currentEpisode?.title
		let subtitle = currentEpisode?.itunesSubtitle
		episodeTitle.text = currentEpisode?.title
		licelnseLabel.text = "\"ESLPOD\" is a registered trademark by the Center for Educational Development (Reg. U.S. Pat. & Tm. Off.). All podcasts are copyrighted by the Center."
		
//		do {
//			episodeContent.attributedText = try NSAttributedString(data: (currentEpisode!.description?.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true))!, options:[ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
//		} catch {
//				print(error)
//		}
		let backgroundSessionConfiguration =  NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("backgroundSession")
		backgroundSession = NSURLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
		let url = NSURL(string: (currentEpisode?.link)!)!
		print("\(url)")
		downloadTask = backgroundSession.downloadTaskWithURL(url)
		downloadTask.resume()
		// Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

	func startDownload(){
	

	}
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



