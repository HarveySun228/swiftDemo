//
//  ViewController.swift
//  HelloiOS
//
//  Created by yeeku on 14/10/21.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet var myTxt: UILabel!
	@IBOutlet var loginBn: UIButton!
	@IBAction func tappedHandler(sender: UIButton) {
		self.myTxt.text = "IBAction事件机制"
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		println("界面设计文件加载完成!!")
		// 如果程序需要在界面设计文件加载完成后执行某些额外的处理，可在此处编写代码
		// 借助viewWithTag()方法即可通过UI控件的Tag属性来获取该控件
		var myLb = self.view.viewWithTag(12) as UILabel
		// 设置myLb的文本内容
		myLb.text = "欢迎学习iOS开发！"
		// 直接通过IBOutlet属性来访问第一个UILabel控件
		self.myTxt.text = "iOS真有趣！"
		
		// 为loginBn控件的UIControlEventTouchUpInside事件绑定事件处理方法
		// 以当前对象的loginHandler:方法作为事件处理方法
		self.loginBn.addTarget(self, action:"loginHandler:" ,
			forControlEvents:UIControlEvents.TouchUpInside)
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// 此处可考虑释放那些可以以后重建的资源
	}
	func loginHandler(sender:UIButton)
	{
		self.myTxt.text = "通过代码绑定事件处理方法"
	}
}

