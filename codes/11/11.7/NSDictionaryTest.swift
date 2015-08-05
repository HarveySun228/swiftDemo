import Foundation@objc class User : Printable{	var name: String	var pass: String	init(name: String , pass: String)	{		self.name = name		self.pass = pass	}	func say(content: String)	{		println("\(self.name)说：\(content)")	}	// 重写description属性，可以直接看到User对象的状态	var description: String	{		return "User[name=\(self.name), pass=\(self.pass)]"	}	// 重写isEqual()方法，重写该方法的比较标准是，	// 如果两个User的name、pass相等，即可认为两个User相等。	func isEqual(other:AnyObject) -> Bool	{		if self === other		{			return true		}		if other is User		{			let target = (other as User)			return self.name == target.name				&& self.pass == target.pass		}		return false	}}// 直接使用Swift的Dictionary创建NSDictionary对象let dict:NSDictionary = ["one": User(name:"sun" , pass:"123"),	"two": User(name:"bai" , pass:"345"),	"three": User(name:"sun" , pass:"123"),	"four": User(name:"tang" , pass:"178"),	"five": User(name:"niu" , pass:"155")]println(dict as Dictionary)println("dict包含\(dict.count)个key-value对")println("dict的所有key为：\(dict.allKeys)")let result = dict.allKeysForObject(User(name:"sun" , pass:"123"))println("User[name=sun,pass=123]对应的所有key为：\(result)")// 获取遍历dict所有value的枚举器let en = dict.objectEnumerator()// 使用枚举器来遍历dict中所有valuefor var value: AnyObject? = en.nextObject() ; value != nil ; value = en.nextObject(){	println(value)}// 使用闭包来迭代执行该集合中所有key-value对dict.enumerateKeysAndObjectsUsingBlock()// 该集合包含多少个key-value对，下面的闭包就执行相应的次数{(key: AnyObject!, value :AnyObject!, stop: UnsafeMutablePointer<ObjCBool>) in	println("key的值为：\(key)")	value.say("疯狂iOS讲义")}