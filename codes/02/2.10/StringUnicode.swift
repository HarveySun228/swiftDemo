let cn = "china,🇨🇳"
// 访问字符串底层的UTF-8编码
for codeUnit in cn.utf8
{
	print("\(codeUnit) ")
}
println()
// 访问字符串底层的UTF-16编码
for codeUnit in cn.utf16
{
	print("\(codeUnit) ")
}
println()
// 访问字符串底层的Unicode标量
for scalar in cn.unicodeScalars
{
	print("\(scalar.value) ")
}
println()