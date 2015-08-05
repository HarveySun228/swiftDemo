class Fruit{	var name: String	var weight: Double	// 定义一个指定构造器	init(name:String , weight: Double)	{		self.name = name		self.weight = weight	}	// 定义2个便利构造器	convenience init(name: String)	{		self.init(name:name , weight: 0.0)	}	convenience init()	{		self.init(name: "水果")		self.weight = 1.0	}}// 该类提供了指定构造器，并未实现父类所有的指定构造器class Apple: Fruit{	var color: String	// 定义一个指定构造器	init(name: String , color: String , weight: Double)	{		self.color = color		super.init(name:name , weight:weight)	}	// 定义一个便利构造器	convenience init(name: String , color:String)	{		self.init(name:name , color:color , weight:0.0)	}}// 该类没有定义任何构造器class Fuji: Apple{	var vitamin: Double = 0.21}