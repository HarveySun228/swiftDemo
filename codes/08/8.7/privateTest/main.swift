// Test类是Internal级别的，因此同一个模块可以访问var t = Test()// 下面代码报错t.count += 20  // ①t.increment(20)println(t)