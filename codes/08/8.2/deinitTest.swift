class Fruit{	var name: String	var weight: Double	// 定义指定构造器	init(name:String)	{		self.name = name		self.weight = 0.0	}	deinit	{		println("程序准备释放Fruit")		// 此处可访问实例属性，可用于释放资源	}}class Apple : Fruit{	var color : String	// 定义指定构造器	init(name:String , weight: Double , color: String)	{		self.color = color		super.init(name: name)	}	// 定义析构器	deinit	{		println("程序准备释放Apple")		// 此处可访问实例属性，可用于释放资源	}}var ap: Apple? = Apple(name: "红富士", weight: 0.34, color: "红色")println(ap!.name + "-->" + ap!.color)ap = nil