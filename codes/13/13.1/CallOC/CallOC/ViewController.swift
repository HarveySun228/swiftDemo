//
//  ViewController.swift
//  CallOC
//
//  Created by yeeku on 14/10/25.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var sayHi: FKSayHi!
	@IBOutlet var nameTxt: UITextField!
	@IBOutlet var showLabel: UILabel!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		// 创建Objective-C类：FKSayHi的对象
		sayHi = FKSayHi(date: NSDate())
	}
	
	@IBAction func tappedHandler(sender: AnyObject)
	{
		// 调用Objective-C对象的方法
		self.showLabel.text = sayHi.sayHi(self.nameTxt.text)
	}
	
}

