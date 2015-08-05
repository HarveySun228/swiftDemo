//
//  ViewController.swift
//  Tetris
//
//  Created by yeeku on 14-10-12.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

import UIKit
// 导入AVFoundation是为了播放背景音乐
import AVFoundation

class ViewController: UIViewController , GameViewDelegate{
	let MARGINE:CGFloat = 10
	let BUTTON_SIZE:CGFloat = 48
	let BUTTON_ALPHA:CGFloat = 0.4
	let TOOLBAR_HEIGHT:CGFloat = 44
	var screenWidth: CGFloat!
	var screenHeight: CGFloat!
	var gameView: GameView!
	// 定义背景音乐的播放对象
	var bgMusicPlayer:AVAudioPlayer!
	// 定义显示当前速度的UILabel
	var speedShow : UILabel!
	// 定义显示当前积分的UILabel
	var scoreShow : UILabel!
	override func viewDidLoad() {
		super.viewDidLoad()
		var rect = UIScreen.mainScreen().bounds
		screenWidth = rect.size.width
		screenHeight = rect.size.height
		// 添加工具条
		self.addToolBar()  // ①
		// 创建GameView控件
		gameView = GameView(frame : CGRectMake(rect.origin.x + MARGINE,
			rect.origin.y + TOOLBAR_HEIGHT + MARGINE * 2,
			rect.size.width - MARGINE * 2, rect.size.height - 80))
		// 将该视图控制器设置为GameView对象的delegate
		gameView.delegate = self
		// 添加绘制游戏状态的自定义View
		self.view.addSubview(gameView)
		// 开始游戏
		gameView.startGame()
		// 添加游戏控制按钮
		self.addButtons()  // ②
		// 获取背景音效的音频文件的URL
		let bgMusicURL = NSBundle.mainBundle()
			.URLForResource("bg", withExtension:"wav")
		// 创建AVAudioPlayer对象
		bgMusicPlayer = AVAudioPlayer(contentsOfURL:bgMusicURL, error: nil)
		bgMusicPlayer.numberOfLoops = -1
		// 播放背景音效
		bgMusicPlayer.play()
	}
	// 定义在程序顶部添加工具条的方法
	func addToolBar()
	{
		let toolBar = UIToolbar(frame: CGRectMake(0, MARGINE * 2,
			screenWidth, TOOLBAR_HEIGHT))
		self.view.addSubview(toolBar)
		// 创建第一个显示"速度:"的标签
		let speedLabel = UILabel(frame: CGRectMake(0, 0 , 50 , TOOLBAR_HEIGHT))
		speedLabel.text = "速度:"
		let speedLabelItem = UIBarButtonItem(customView: speedLabel)
		// 创建第二个显示速度值的标签
		speedShow = UILabel(frame: CGRectMake(0, 0 , 20 , TOOLBAR_HEIGHT))
		speedShow.textColor = UIColor.redColor()
		let speedShowItem = UIBarButtonItem(customView: speedShow)
		// 创建第三个显示"当前积分:"的标签
		let scoreLabel = UILabel(frame: CGRectMake(0, 0 , 90 , TOOLBAR_HEIGHT))
		scoreLabel.text = "当前积分:"
		let scoreLabelItem = UIBarButtonItem(customView: scoreLabel)
		// 创建第四个显示积分值的标签
		scoreShow = UILabel(frame: CGRectMake(0, 0 , 40 , TOOLBAR_HEIGHT))
		scoreShow.textColor = UIColor.redColor()
		let scoreShowItem = UIBarButtonItem(customView: scoreShow)
		let flexItem = UIBarButtonItem(barButtonSystemItem:
			UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
		// 为工具条设置工具项
		toolBar.items = [speedLabelItem, speedShowItem, flexItem,
			scoreLabelItem, scoreShowItem]
	}
	// 定义添加4个控制按钮的方法
	func addButtons()
	{
		// 添加向左的按钮
		let leftBn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
		leftBn.frame = CGRectMake(screenWidth - BUTTON_SIZE * 3 - MARGINE
			, screenHeight - BUTTON_SIZE - MARGINE, BUTTON_SIZE, BUTTON_SIZE)
		leftBn.alpha = BUTTON_ALPHA
		leftBn.setImage(UIImage(named: "left0"), forState:UIControlState.Normal)
		leftBn.setImage(UIImage(named: "left1"), forState:UIControlState.Highlighted)
		self.view.addSubview(leftBn)
		leftBn.addTarget(self, action:"left:",
			forControlEvents:UIControlEvents.TouchUpInside)
		// 添加向下的按钮
		let downBn = UIButton.buttonWithType(UIButtonType.Custom)as! UIButton
		downBn.frame = CGRectMake(screenWidth - BUTTON_SIZE * 2 - MARGINE,
			screenHeight - BUTTON_SIZE - MARGINE , BUTTON_SIZE , BUTTON_SIZE)
		downBn.alpha = BUTTON_ALPHA
		downBn.setImage(UIImage(named: "down0"), forState:UIControlState.Normal)
		downBn.setImage(UIImage(named: "down1"), forState:UIControlState.Highlighted)
		self.view.addSubview(downBn)
		downBn.addTarget(self, action:"down:",
			forControlEvents:UIControlEvents.TouchUpInside)
		// 添加向右的按钮
		let rightBn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
		rightBn.frame = CGRectMake(screenWidth - BUTTON_SIZE * 1 - MARGINE,
			screenHeight - BUTTON_SIZE - MARGINE, BUTTON_SIZE, BUTTON_SIZE)
		rightBn.alpha = BUTTON_ALPHA
		rightBn.setImage(UIImage(named: "right0"), forState:UIControlState.Normal)
		rightBn.setImage(UIImage(named: "right1"),
			forState:UIControlState.Highlighted)
		self.view.addSubview(rightBn)
		rightBn.addTarget(self, action:"right:",
			forControlEvents:UIControlEvents.TouchUpInside)
		// 添加向上的按钮
		let upBn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
		upBn.frame = CGRectMake(screenWidth - BUTTON_SIZE * 2 - MARGINE,
			screenHeight - BUTTON_SIZE * 2 - MARGINE, BUTTON_SIZE, BUTTON_SIZE)
		upBn.alpha = BUTTON_ALPHA
		upBn.setImage(UIImage(named: "up0"), forState:UIControlState.Normal)
		upBn.setImage(UIImage(named: "up1"), forState:UIControlState.Highlighted)
		self.view.addSubview(upBn)
		upBn.addTarget(self, action:"up:", forControlEvents:UIControlEvents.TouchUpInside)
	}
	func left(sender: AnyObject) {
		gameView.moveLeft()
	}
	func right(sender: AnyObject) {
		gameView.moveRight()
	}
	func down(sender: AnyObject) {
		gameView.moveDown()
	}
	func up(sender: AnyObject) {
		gameView.rotate()
	}
	func updateSpeed(speed: Int){
		// 更新显示当前速度的UILabel控件上的文字
		self.speedShow.text = "\(speed)"
	}
	func updateScore(score: Int){
		// 更新显示当前积分的UILabel控件上的文字
		self.scoreShow.text = "\(score)"
	}
}

