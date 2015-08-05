//
//  CustomView.swift
//  CustomView
//
//  Created by yeeku on 14/10/23.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

import UIKit

class CustomView: UIView
{
	// 定义两个变量记录当前触碰点的坐标
	var curX : CGFloat! = 0
	var curY : CGFloat! = 0
	override func touchesMoved(touches:NSSet, withEvent event:UIEvent)
	{
		// 获取触碰事件的UITouch事件
		let touch: AnyObject? = touches.anyObject()
		// 得到触碰事件在当前组件上的触碰点
		let lastTouch = touch?.locationInView(self)
		// 获取触碰点的坐标
		curX = lastTouch?.x
		curY = lastTouch?.y
		// 通知该组件重绘
		self.setNeedsDisplay()
	}
	// 重写该方法来绘制该UI控件
	override func drawRect(rect:CGRect)
	{
		// 获取绘图上下文
		let ctx = UIGraphicsGetCurrentContext()
		// 设置填充颜色
		CGContextSetFillColorWithColor(ctx, UIColor.redColor().CGColor)
		// 以触碰点为圆心，绘制一个圆形
		CGContextFillEllipseInRect(ctx, CGRectMake(curX - 10
			, curY - 10, 20 , 20));
	}
}
