// 定义一个结构体，该结构体不包含任何构造器，系统将为之提供1个默认构造器。struct SomeStruct{	var name:String	var count:Int}// 使用扩展来添加构造器extension SomeStruct{	// 通过扩展添加的2个构造器对该类型原有的构造器没有影响	init(name:String)	{		self.name = name		self.count = 0	}	init(count:Int)	{		self.count = count		self.name = ""	}}// 下面使用了SomeStruct的3个构造器，其中第一个构造器是系统提供的var sc1 = SomeStruct(name: "fkit" , count:5)var sc2 = SomeStruct(name: "crazyit")var sc3 = SomeStruct(count: 20)