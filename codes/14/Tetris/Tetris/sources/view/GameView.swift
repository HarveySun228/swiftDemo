//
//  GameView.swift
//  Tetris
//
//  Created by yeeku on 14-10-12.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

import UIKit
import AVFoundation
// 重载+运算符，让+支持Int + Double运算
func + (left: Int , right:Double) -> Double
{
	return Double(left) + right
}
// 重载-运算符，让+支持Int - Double运算
func - (left: Int , right:Double) -> Double
{
	return Double(left) - right
}
protocol GameViewDelegate{
	func updateScore(score: Int)
	func updateSpeed(speed: Int)
}
class GameView: UIView , UIAlertViewDelegate{
	var delegate: GameViewDelegate!
	let TETRIS_ROWS = 22
	let TETRIS_COLS = 15
	let CELL_SIZE : Int
	// 定义绘制网络的笔触的粗细
	let STROKE_WIDTH:Double = 1
	let BASE_SPEED: Double = 0.6
	// 没方块是0
	let NO_BLOCK = 0
	// 记录当前积分
	var curScore:Int = 0
	// 记录当前速度
	var curSpeed = 1
	var curTimer: NSTimer!
	// 定义记录“正在下掉”的四个方块的属性
	var currentFall: [Block]!
	// 定义用于记录俄罗斯方块状态的二维数组的属性
	var tetris_status = [[Int]]()
	// 定义方块的颜色
	let colors = [UIColor.whiteColor().CGColor,
		UIColor.redColor().CGColor,
		UIColor.greenColor().CGColor ,
		UIColor.blueColor().CGColor ,
		UIColor.yellowColor().CGColor ,
		UIColor.magentaColor().CGColor ,
		UIColor.purpleColor().CGColor ,
		UIColor.brownColor().CGColor]
	// 定义几种可能出现的方块组合
	let blockArr: [[Block]]
	var ctx: CGContextRef!
	// 定义一个UIImage实例，该实例代表内存中图片
	var image:UIImage!
	// 定义消除音乐的AVAudioPlayer对象
	var disPlayer:AVAudioPlayer!
	override init(frame:CGRect)
	{
		self.blockArr = [
			// 代表第一种可能出现的方块组合：Z
			[
				Block(x: TETRIS_COLS / 2 - 1 , y:0 , color:1),
				Block(x: TETRIS_COLS / 2 , y:0 ,color:1),
				Block(x: TETRIS_COLS / 2 , y:1 ,color:1),
				Block(x: TETRIS_COLS / 2 + 1 , y:1 , color:1)
			],
			// 代表第二种可能出现的方块组合：反Z
			[
				Block(x: TETRIS_COLS / 2 + 1 , y:0 , color:2),
				Block(x: TETRIS_COLS / 2 , y:0 , color:2),
				Block(x: TETRIS_COLS / 2 , y:1 , color:2),
				Block(x: TETRIS_COLS / 2 - 1 , y:1 , color:2)
			],
			// 代表第三种可能出现的方块组合： 田
			[
				Block(x: TETRIS_COLS / 2 - 1 , y:0 , color:3),
				Block(x: TETRIS_COLS / 2 , y:0 ,  color:3),
				Block(x: TETRIS_COLS / 2 - 1 , y:1 , color:3),
				Block(x: TETRIS_COLS / 2 , y:1 , color:3)
			],
			// 代表第四种可能出现的方块组合：L
			[
				Block(x: TETRIS_COLS / 2 - 1 , y:0 , color:4),
				Block(x: TETRIS_COLS / 2 - 1, y:1 , color:4),
				Block(x: TETRIS_COLS / 2 - 1 , y:2 , color:4),
				Block(x: TETRIS_COLS / 2 , y:2 , color:4)
			],
			// 代表第五种可能出现的方块组合：J
			[
				Block(x: TETRIS_COLS / 2  , y:0 , color:5),
				Block(x: TETRIS_COLS / 2 , y:1, color:5),
				Block(x: TETRIS_COLS / 2  , y:2, color:5),
				Block(x: TETRIS_COLS / 2 - 1, y:2, color:5)
			],
			// 代表第六种可能出现的方块组合 : 条
			[
				Block(x: TETRIS_COLS / 2 , y:0 , color:6),
				Block(x: TETRIS_COLS / 2 , y:1 , color:6),
				Block(x: TETRIS_COLS / 2 , y:2 , color:6),
				Block(x: TETRIS_COLS / 2 , y:3 , color:6)
			],
			// 代表第七种可能出现的方块组合 : ┵
			[
				Block(x: TETRIS_COLS / 2 , y:0 , color:7),
				Block(x: TETRIS_COLS / 2 - 1 , y:1 , color:7),
				Block(x: TETRIS_COLS / 2 , y:1 , color:7),
				Block(x: TETRIS_COLS / 2 + 1, y:1 , color:7)
			]
		]
		// 计算俄罗斯方块的大小
		self.CELL_SIZE = Int(frame.size.width) / TETRIS_COLS
		super.init(frame:frame)
		// 获取消除方块音效的音频文件的URL
		let disMusicURL = NSBundle.mainBundle()
			.URLForResource("dis", withExtension:"wav")
		// 创建AVAudioPlayer对象
		disPlayer = AVAudioPlayer(contentsOfURL:disMusicURL, error: nil)
		disPlayer.numberOfLoops = 0
		
		// 开启内存中的绘图
		UIGraphicsBeginImageContext(self.bounds.size)
		// 获取Quartz 2D绘图的CGContextRef对象
		ctx = UIGraphicsGetCurrentContext()
		// 填充背景色
		CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
		CGContextFillRect(ctx, self.bounds)
		// 绘制俄罗斯方块的网格
		createCells(TETRIS_ROWS, cols:TETRIS_COLS ,
			cellWidth :CELL_SIZE, cellHeight:CELL_SIZE)
		image = UIGraphicsGetImageFromCurrentImageContext()
	}
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// 初始化游戏状态
	func initTetrisStatus()
	{
		var tmpRow = Array(count: TETRIS_COLS, repeatedValue: NO_BLOCK)
		tetris_status = Array(count: TETRIS_ROWS, repeatedValue: tmpRow)
	}
	// 初始化“正在下掉”的方块组合
	func initBlock()
	{
		// 生成一个0~blockArr.count之间的随机数
		let rand = Int(arc4random()) % blockArr.count
		// 随机取出blockArr数组的某个元素作为“正在下掉”的方块组合
		currentFall = blockArr[rand]
	}
	// 定义一个创建绘制俄罗斯方块网格的方法
	func createCells(rows:Int, cols:Int , cellWidth :Int, cellHeight:Int)
	{
		// 开始创建路径
		CGContextBeginPath(ctx)
		// 绘制横向网络对应的路径
		for var i = 0 ; i <= TETRIS_ROWS ; i++
		{
			CGContextMoveToPoint(ctx, 0 , CGFloat(i * CELL_SIZE))
			CGContextAddLineToPoint(ctx , CGFloat(TETRIS_COLS * CELL_SIZE),
				CGFloat(i * CELL_SIZE))
		}
		// 绘制竖向网络对应的路径
		for var i = 0 ; i <= TETRIS_COLS ; i++
		{
			CGContextMoveToPoint(ctx , CGFloat(i * CELL_SIZE) , 0)
			CGContextAddLineToPoint(ctx , CGFloat(i * CELL_SIZE),
				CGFloat(TETRIS_ROWS * CELL_SIZE))
		}
		CGContextClosePath(ctx)
		// 设置笔触颜色
		CGContextSetStrokeColorWithColor(ctx, UIColor(red: 0.9,
			green: 0.9, blue: 0.9, alpha: 1).CGColor)
		// 设置线条粗细
		CGContextSetLineWidth(ctx, CGFloat(STROKE_WIDTH))
		// 绘制线条
		CGContextStrokePath(ctx)
	}
	// 绘制俄罗斯方块的状态
	func drawBlock()
	{
		for var i = 0 ; i < TETRIS_ROWS ; i++
		{
			for var j = 0 ; j < TETRIS_COLS ; j++
			{
				// 有方块的地方绘制颜色
				if tetris_status[i][j] != NO_BLOCK
				{
					// 设置填充颜色
					CGContextSetFillColorWithColor(ctx, colors[tetris_status[i][j]])
					// 绘制矩形
					CGContextFillRect(ctx , CGRectMake(CGFloat(j*CELL_SIZE
						+ STROKE_WIDTH) , CGFloat(i * CELL_SIZE + STROKE_WIDTH),
						CGFloat(CELL_SIZE - STROKE_WIDTH * 2) ,
						CGFloat(CELL_SIZE - STROKE_WIDTH * 2)))
				}
				// 没有方块的地方绘制白色
				else
				{
					// 设置填充颜色
					CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
					// 绘制矩形
					CGContextFillRect(ctx , CGRectMake(CGFloat(j * CELL_SIZE
						+ STROKE_WIDTH) , CGFloat(i * CELL_SIZE + STROKE_WIDTH),
						CGFloat(CELL_SIZE - STROKE_WIDTH * 2) ,
						CGFloat(CELL_SIZE - STROKE_WIDTH * 2)))
				}
			}
		}
	}
	// 判断是否有一行已满
	func lineFull()
	{
		// 依次遍历每一行
		for var i = 0 ; i < TETRIS_ROWS ; i++
		{
			var flag = true
			// 遍历当前行的每个单元格
			for var j = 0 ; j < TETRIS_COLS ; j++
			{
				if tetris_status[i][j] == NO_BLOCK
				{
					flag = false
					break
				}
			}
			// 如果当前行已全部有方块了
			if flag
			{
				// 将当前积分增加100
				curScore += 100
				self.delegate.updateScore(curScore)
				// 如果当前积分达到升级极限。
				if curScore >= curSpeed * curSpeed * 500
				{
					// 速度增加1
					curSpeed += 1
					self.delegate.updateSpeed(curSpeed)
					// 让原有计时器失效，重新开启新的计时器
					curTimer.invalidate()
					curTimer = NSTimer.scheduledTimerWithTimeInterval(
						BASE_SPEED / Double(curSpeed), target: self,
						selector: "moveDown", userInfo: nil, repeats: true)
				}
				// 把当前行的所有方块下移一行。
				for var j = i ; j > 0 ; j--
				{
					for var k = 0 ; k < TETRIS_COLS ; k++
					{
						tetris_status[j][k] = tetris_status[j-1][k]
					}
				}
				// 播放消除方块的音乐
				if !disPlayer.playing
				{
					disPlayer.play()
				}
			}
		}
	}
	// 控制方块组合向下掉落。
	func moveDown()
	{
		// 定义能否向下掉落的旗标
		var canDown = true  // ①
		// 遍历每个方块，判断是否能向下掉
		for var i = 0 ; i < currentFall.count ; i++
		{
			// 判断是否已经到“最底下”
			if currentFall[i].y >= TETRIS_ROWS - 1
			{
				canDown = false
				break
			}
			// 判断下一格是否“有方块”, 如果下一格有方块，不能向下掉
			if tetris_status[currentFall[i].y + 1][currentFall[i].x]
				!= NO_BLOCK
			{
				canDown = false
				break
			}
		}
		// 如果能向下“掉落”
		if canDown
		{
			self.drawBlock()  // ②
			// 将下移前的每个方块的背景色涂成白色
			for var i = 0 ; i < currentFall.count ; i++
			{
				var cur = currentFall[i]
				// 设置填充颜色
				CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
				// 绘制矩形
				CGContextFillRect(ctx, CGRectMake(CGFloat(cur.x * CELL_SIZE
					+ STROKE_WIDTH) , CGFloat(cur.y * CELL_SIZE + STROKE_WIDTH),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2) ,
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2)))
			}
			// 遍历每个方块, 控制每个方块的y坐标加1。
			// 也就是控制方块都下掉一格
			for var i = 0 ; i < currentFall.count ; i++
			{
				currentFall[i].y++
			}
			// 将下移后的每个方块的背景色涂成该方块的颜色值
			for var i = 0 ; i < currentFall.count ; i++
			{
				var cur = currentFall[i]
				// 设置填充颜色
				CGContextSetFillColorWithColor(ctx, colors[cur.color])
				// 绘制矩形
				CGContextFillRect(ctx, CGRectMake(CGFloat(cur.x * CELL_SIZE
					+ STROKE_WIDTH) , CGFloat(cur.y * CELL_SIZE + STROKE_WIDTH),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2) ,
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2)))
			}
		}
		// 不能向下掉落
		else
		{
			// 遍历每个方块, 把每个方块的值记录到tetris_status数组中
			for var i = 0 ; i < currentFall.count ; i++
			{
				var cur = currentFall[i]
				// 如果有方块已经到最上面了，表明输了
				if cur.y < 2
				{
					// 清除计时器
					curTimer.invalidate()
					// 显示提示框
					let alert = UIAlertView(title: "游戏结束",
						message:"游戏已经结束，请问是否重新开始",
						delegate:self,
						cancelButtonTitle:"否")
					alert.addButtonWithTitle("是")
					alert.show()
					return
				}
				// 把每个方块当前所在位置赋为当前方块的颜色值
				tetris_status[cur.y][cur.x] = cur.color
			}
			// 判断是否有“可消除”的行
			lineFull()
			// 开始一组新的方块。
			initBlock()
		}
		// 获取缓冲区的图片
		image = UIGraphicsGetImageFromCurrentImageContext()
		// 通知该组件重绘。
		self.setNeedsDisplay()
	}
	// 定义左移方块组合的方法
	func moveLeft()
	{
		// 定义能否左移的旗标
		var canLeft = true
		for var i = 0 ; i < currentFall.count ; i++
		{
			// 如果已经到了最左边，不能左移
			if currentFall[i].x <= 0
			{
				canLeft = false
				break
			}
			// 或左边的位置已有方块，不能左移
			if tetris_status[currentFall[i].y][currentFall[i].x - 1]
				!= NO_BLOCK
			{
				canLeft = false
				break
			}
		}
		// 如果能左移
		if canLeft
		{
			self.drawBlock()
			
			// 将左移前的每个方块的背景色涂成白色
			for var i = 0 ; i < currentFall.count ; i++
			{
				var cur = currentFall[i]
				// 设置填充颜色
				CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
				// 绘制矩形
				CGContextFillRect(ctx , CGRectMake(CGFloat(cur.x * CELL_SIZE
					+ STROKE_WIDTH), CGFloat(cur.y * CELL_SIZE + STROKE_WIDTH),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2)))
			}
			// 左移所有正在下掉的方块
			for var i = 0 ; i < currentFall.count ; i++
			{
				currentFall[i].x--
			}
			// 将左移后的每个方块的背景色涂成方块对应的颜色
			for var i = 0 ; i < currentFall.count ; i++
			{
				var cur = currentFall[i]
				// 设置填充颜色
				CGContextSetFillColorWithColor(ctx, colors[cur.color])
				// 绘制矩形
				CGContextFillRect(ctx , CGRectMake(CGFloat(cur.x * CELL_SIZE
					+ STROKE_WIDTH), CGFloat(cur.y * CELL_SIZE + STROKE_WIDTH),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2)))
			}
			// 获取缓冲区的图片
			image = UIGraphicsGetImageFromCurrentImageContext()
			// 通知该组件重绘。
			self.setNeedsDisplay()
		}
	}
	// 定义右移方块组合的方法
	func moveRight()
	{
		// 定义能否右移的旗标
		var canRight = true
		for var i = 0 ; i < currentFall.count ; i++
		{
			// 如果已到了最右边，不能右移
			if currentFall[i].x >= TETRIS_COLS - 1
			{
				canRight = false
				break
			}
			// 如果右边的位置已有方块，不能右移
			if tetris_status[currentFall[i].y][currentFall[i].x + 1] != NO_BLOCK
			{
				canRight = false
				break
			}
		}
		// 如果能右移
		if canRight
		{
			self.drawBlock()
			
			// 将右移前的每个方块的背景色涂成白色
			for var i = 0 ; i < currentFall.count ; i++
			{
				var cur = currentFall[i]
				// 设置填充颜色
				CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
				// 绘制矩形
				CGContextFillRect(ctx , CGRectMake(CGFloat(cur.x * CELL_SIZE
					+ STROKE_WIDTH), CGFloat(cur.y * CELL_SIZE + STROKE_WIDTH),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2)))
			}
			// 右移所有正在下掉的方块
			for var i = 0 ; i < currentFall.count ; i++
			{
				currentFall[i].x++
			}
			// 将右移后的每个方块的背景色涂成各方块对应的颜色
			for var i = 0 ; i < currentFall.count ; i++
			{
				var cur = currentFall[i]
				// 设置填充颜色
				CGContextSetFillColorWithColor(ctx, colors[cur.color])
				// 绘制矩形
				CGContextFillRect(ctx , CGRectMake(CGFloat(cur.x * CELL_SIZE
					+ STROKE_WIDTH), CGFloat(cur.y * CELL_SIZE + STROKE_WIDTH),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2)))
			}
			// 获取缓冲区的图片
			image = UIGraphicsGetImageFromCurrentImageContext()
			// 通知该组件重绘。
			self.setNeedsDisplay()
		}
	}
	// 定义旋转方块组合的方法
	func rotate()
	{
		// 定义记录能否旋转的旗标
		var canRotate = true
		for var i = 0 ; i < currentFall.count ; i++
		{
			var preX = currentFall[i].x
			var preY = currentFall[i].y
			// 始终以第三个方块作为旋转的中心,
			// i == 2时，说明是旋转的中心
			if i != 2
			{
				// 计算方块旋转后的x、y坐标
				var afterRotateX = currentFall[2].x + preY - currentFall[2].y
				var afterRotateY = currentFall[2].y + currentFall[2].x - preX
				// 如果旋转后的x、y坐标越界，或旋转后的位置已有方块，表明不能旋转
				if afterRotateX < 0 ||
					afterRotateX > TETRIS_COLS - 1 ||
					afterRotateY < 0 ||
					afterRotateY > TETRIS_ROWS - 1 ||
					tetris_status[afterRotateY][afterRotateX] != NO_BLOCK
				{
					canRotate = false
					break
				}
			}
		}
		// 如果能旋转
		if canRotate
		{
			self.drawBlock()
			// 将旋转移前的每个方块的背景色涂成白色
			for var i = 0 ; i < currentFall.count ; i++
			{
				var cur = currentFall[i]
				// 设置填充颜色
				CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
				// 绘制矩形
				CGContextFillRect(ctx , CGRectMake(CGFloat(cur.x * CELL_SIZE
					+ STROKE_WIDTH), CGFloat(cur.y * CELL_SIZE + STROKE_WIDTH),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2)))
			}
			for var i = 0 ; i < currentFall.count ; i++
			{
				var preX = currentFall[i].x
				var preY = currentFall[i].y
				// 始终以第三个方块作为旋转的中心,
				// i == 2时，说明是旋转的中心
				if i != 2
				{
					currentFall[i].x = currentFall[2].x +
						preY - currentFall[2].y
					currentFall[i].y = currentFall[2].y +
						currentFall[2].x - preX
				}
			}
			// 将旋转后的每个方块的背景色涂成各方块对应的颜色
			for var i = 0 ; i < currentFall.count ; i++
			{
				var cur = currentFall[i]
				// 设置填充颜色
				CGContextSetFillColorWithColor(ctx, colors[cur.color])
				// 绘制矩形
				CGContextFillRect(ctx , CGRectMake(CGFloat(cur.x * CELL_SIZE
					+ STROKE_WIDTH), CGFloat(cur.y * CELL_SIZE + STROKE_WIDTH),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2),
					CGFloat(CELL_SIZE - STROKE_WIDTH * 2)))
			}
			// 获取缓冲区的图片
			image = UIGraphicsGetImageFromCurrentImageContext()
			// 通知该组件重绘。
			self.setNeedsDisplay()
		}
	}
	override func drawRect(rect: CGRect)
	{
		// 获取绘图上下文
		var curCtx = UIGraphicsGetCurrentContext()
		// 将内存中的image图片绘制在该组件的左上角
		image.drawAtPoint(CGPointZero)
	}
	func alertView(alertView: UIAlertView,
		clickedButtonAtIndex buttonIndex: Int)
	{
		// 如果用户单击了“是”按钮，选择重新开始
		if buttonIndex == 1
		{
			self.startGame()
		}
	}
	// 开始游戏
	func startGame()
	{
		// 将当前速度设为1
		self.curSpeed = 1
		self.delegate.updateSpeed(self.curSpeed)
		// 将积分设为0
		self.curScore = 0
		self.delegate.updateScore(self.curScore)
		// 初始化游戏的状态数据
		initTetrisStatus()
		// 初始化4个“向下掉落”的方块
		initBlock()
		// 控制每隔固定时间执行一次向下“掉落”
		curTimer = NSTimer.scheduledTimerWithTimeInterval(BASE_SPEED /
			Double(curSpeed), target: self, selector: "moveDown",
			userInfo: nil, repeats: true)
	}
}

