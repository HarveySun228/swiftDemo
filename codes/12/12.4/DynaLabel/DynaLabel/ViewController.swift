//
//  ViewController.swift
//  DynaLabel
//
//  Created by yeeku on 14/10/23.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var labels = [UILabel]()
	var nextY:CGFloat = 80.0
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.grayColor()
		// 创建UIButtonType.System类型的UIButton对象
		let addBn = UIButton.buttonWithType(UIButtonType.System) as UIButton
		// 设置addBn的大小和位置
		addBn.frame = CGRectMake(30, 30, 60, 40)
		// 为UIButton设置按钮文本
		addBn.setTitle("添加" , forState:UIControlState.Normal)
		// 为addBn的Touch Up Inside事件绑定事件处理方法
		addBn.addTarget(self , action:"add:" ,
			forControlEvents:UIControlEvents.TouchUpInside)
		// 创建UIButtonType.System类型的UIButton对象
		let removeBn = UIButton.buttonWithType(UIButtonType.System) as UIButton
		// 设置removeBn的大小和位置
		removeBn.frame = CGRectMake(230, 30, 60, 40)
		// 为UIButton设置按钮文本
		removeBn.setTitle("删除" , forState:UIControlState.Normal)
		// 为removeBn的Touch Up Inside事件绑定事件处理方法
		removeBn.addTarget(self , action:"remove:" , forControlEvents:UIControlEvents.TouchUpInside)
		self.view.addSubview(addBn)
		self.view.addSubview(removeBn)
	}

	func add(sender:UIButton) {
		// 创建一个UILabel控件
		let label = UILabel(frame:CGRectMake(80, nextY, 160, 30))
		label.text = "疯狂iOS讲义"  // 设置该UILabel显示的文本
		self.labels.append(label)  // 将该UILabel添加到labels数组中
		self.view.addSubview(label)  // 将UILabel控件添加到view父控件内
		nextY += 50  // 控制nextY的值加50
	}
	func remove(sender:UIButton) {
		// 如果labels数组中元素个数大于0，表明有UILabel可删除
		if self.labels.count > 0
		{
			// 将最后一个UILabel从界面上删除
			self.labels.last?.removeFromSuperview()
			self.labels.removeLast()  // 从labels数组中删除最后一个元素
			nextY -= 50  // 控制nextY的值减50
		}
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

