class User{	var name: String	init?(name: String) {		// 必须先对name实例存储属性设置初始值，然后才能触发构造失败		self.name = ""  // ①		// 如果传入的name参数为空字符串，构造器失败，返回nil		if name.isEmpty {			return nil		}		self.name = name	}}