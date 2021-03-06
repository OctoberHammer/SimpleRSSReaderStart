//
//  MainController.swift
//  MyNavBar
//
//  Created by Ocotober Hammer on 10/24/15.
//  Copyright © 2015 Ocotober Hammer. All rights reserved.
//

import UIKit

extension CAGradientLayer {
	class func gradientLayerForBounds(_ bounds: CGRect, upperColor: UIColor, lowerColor: UIColor) -> CAGradientLayer {
		let layer = CAGradientLayer()
		layer.frame = bounds
		//layer.colors = [UIColor.orangeColor().CGColor, UIColor.yellowColor().CGColor]
		layer.colors = [upperColor.cgColor, lowerColor.cgColor];
		layer.endPoint = CGPoint(x:0, y:0)
		layer.startPoint = CGPoint(x:1, y:0)
		return layer
	}
}




class MainController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.white
        let fontDictionary = [ NSForegroundColorAttributeName:UIColor.white ]
        self.navigationBar.titleTextAttributes = fontDictionary
        self.navigationBar.setBackgroundImage(imageLayerForGradientBackground(), for: UIBarMetrics.default)
        
        /*if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }*/
    }
    
	fileprivate func imageLayerForGradientBackground() -> UIImage {
		
		var updatedFrame = self.navigationBar.bounds
		// take into account the status bar
		updatedFrame.size.height += 20
		//0xfebf00 - более темный
		let upperColor = UIColor(red: 0x39/255.0, green: 0x80/255.0, blue: 0x49/255.0, alpha: 1.0);
		//0xfcda03 - более СВЕТЛЫЙ
		let lowerColor = UIColor(red: 0x93/255.0, green: 0xBE/255.0, blue: 0x2A/255.0, alpha: 1.0);
		let layer = CAGradientLayer.gradientLayerForBounds(updatedFrame, upperColor: upperColor, lowerColor: lowerColor)
		UIGraphicsBeginImageContext(layer.bounds.size)
		layer.render(in: UIGraphicsGetCurrentContext()!)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image!
	}
}
