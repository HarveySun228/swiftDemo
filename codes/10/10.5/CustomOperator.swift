// 声明新的运算符：**infix operator ** {}// 为新的运算符定义函数，用对整数执行乘方运算func ** (base: Int, exponent: Int) -> Int {	var result = 1	for _ in 1 ... exponent	{		result *= base	}	return result}// 为新的运算符定义函数，用对Double执行乘方运算func ** (base: Double, exponent: Int) -> Double {	var result = 1.0	for _ in 1 ... exponent	{		result *= base	}	return result}let a = 20let b = 2// 使用**运算符println("\(a)的\(b)次方为：\(a ** b)")let c = 2.4let d = 3// 使用**运算符println("\(c)的\(d)次方为：\(c ** d)")