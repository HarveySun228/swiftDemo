class SomeClass{	func test()	{		println("==test方法==")	}	class func bar(#msg: String)	{		println("==bar类型方法==， 传入参数为：\(msg)")	}}var sc = SomeClass()// 将sc的test方法分离成函数var f1 : ()->() = sc.test  // ①// 将SomeClass类的bar类型方法分离成函数var f2 : (String)->Void = SomeClass.bar  // ②// 下面两行代码的本质完全相同sc.test()f1()// 下面两行代码的本质完全相同SomeClass.bar(msg: "测试信息")f2("测试信息")