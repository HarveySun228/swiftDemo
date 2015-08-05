//
//  ViewController.m
//  CallSwift
//
//  Created by yeeku on 14/10/25.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

#import "ViewController.h"
// 导入系统隐式维护的头文件
#import "CallSwift-swift.h"
// 定义ViewController的扩展
@interface ViewController ()
{
	// 定义类型为SayHi、名为sayHi的成员变量
	SayHi* sayHi;
}
@end
@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// 调用带一个参数的构造器（对应于Objective-C的initWithXxx:方法）创建对象
	sayHi = [[SayHi alloc] initWithDate:[NSDate date]];
}
- (IBAction)tappedHandler:(id)sender {
	// 调用Swift对象的方法
	self.showLabel.text = [sayHi sayHi:self.nameTxt.text];
}
@end
