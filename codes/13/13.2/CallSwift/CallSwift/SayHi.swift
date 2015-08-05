//
//  SayHi.swift
//  CallSwift
//
//  Created by yeeku on 14/10/25.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

import UIKit

@objc class SayHi: NSObject {
	var curDate : NSDate
	// 定义构造器
	init(date: NSDate!)
	{
		self.curDate = date
	}
	// 定义一个sayHi()方法
	func sayHi(name: String) -> String
	{
		return "\(name),您好，现在时间是：\(self.curDate)"
	}
}
