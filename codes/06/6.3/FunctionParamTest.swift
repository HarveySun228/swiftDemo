// 定义函数类型的形参，其中fn是(Int) -> Int类型的形参func map(var #data : [Int],  #fn: (Int) -> Int) -> [Int]{	// 遍历data数组中每个元素，并用fn函数计算对data[i]进行计算，	// 然后将计算结果作为新的数组元素	for var i = 0 , len = data.count ; i < len ; i++	{		data[i] = fn(data[i])	}	return data}// 定义一个计算平方的函数func square(val: Int) -> Int{	return val * val}// 定义一个计算立方的函数func cube(val: Int) -> Int{	return val * val * val}// 定义一个计算阶乘的函数func factorial(val: Int) -> Int{	var result = 1	for index in 2...val	{		result *= index	}	return result}var data = [3 , 4 , 9 , 5, 8]println("原数据\(data)")// 下面程序代码3次调用map()函数，每次调用时传入不同的函数println("计算数组元素平方")println(map(data:data , fn:square))println("计算数组元素立方")println(map(data:data , fn:cube))println("计算数组元素阶乘")println(map(data:data , fn:factorial))