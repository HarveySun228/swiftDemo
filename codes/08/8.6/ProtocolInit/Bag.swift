// 实现Initable协议struct Bag : Initable{	var name: String	var weight: Double	// 结构体实现协议的构造器没有太多要求	init(name: String)	{		self.name = name		self.weight = 0.0	}	init(name: String , weight: Double)	{		// 调用同一个类中另外一个重载的构造器		self.init(name: name)		self.weight = weight	}}