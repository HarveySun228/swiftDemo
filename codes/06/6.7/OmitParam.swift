// 省略闭包表达式的形参类型、返回值类型、return关键字、形参名// $0代表该闭包表达式中唯一的形参var square:(Int) -> Int = {$0 * $0}// 使用square调用闭包println(square(5))  // 输出25println(square(6))  // 输出36// 省略闭包表达式的形参类型、返回值类型、形参名，但不能省略return关键字// $0代表该闭包表达式中的第一个形参，$1代表该闭包表达式中的第二个形参var result:Int = {	var result = 1	for i in 1...$1	{		result *= $0	}	return result}(4, 3)println(result)  // 输出64