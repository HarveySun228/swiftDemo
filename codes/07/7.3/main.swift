// 使用Peron类定义一个Person类型的变量var p:Person// 调用Person类的构造器，返回一个Person实例，并该Person实例赋给p变量p = Person()// 访问p的name存储属性，直接为该属性赋值。p.name = "孙悟空"// 调用p的say()方法，声明say()方法时定义了一个形参，// 调用该方法必须为形参指定一个值p.say("Swift语言很简单，学习很容易！")// 直接输出p的name存储属性，将输出 孙悟空println(p.name)var dog = Dog(name:"旺财" , age:4)// 直接输出dog的name存储属性println(dog.name)  // 输出 旺财dog.run()// 调用无参数的构造器创建实例，该Dog实例的所有存储属性都使用默认的初始值var dg = Dog()println(dg.age) // 输出0// 将p变量的值赋值给p2变量var p2 = p// 将p2的name属性设置为猪八戒，由于p和p2引用同一个实例，// 因此p2的name也会随之改变p2.name = "猪八戒"println(p.name)  // 程序复制dog实例的副本，并将副本存入dog2变量中var dog2 = dog// 将dog2的name属性设置为snoopy，对dog的name属性没有任何影响dog2.name = "snoopy"println(dog2.name)  // 输出snoopyprintln(dog.name)  // 输出 旺财