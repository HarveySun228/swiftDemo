class Bird{	var name: String!	// 定义普通构造器	init(){}	// 定义可能失败的构造器	init?(name: String) {  // ①		if name.isEmpty {			return nil		}		self.name = name			}}