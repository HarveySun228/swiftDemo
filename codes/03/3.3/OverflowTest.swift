var a:Int16 = 20222
a = a &* 6
println(a)  // 输出-9740

var b:UInt16 = 20
b = b &- 24
println(b)  // 输出65532

var c = Int8.min
c = c &- 1
println(c)  // 输出127

let x = 20let y = x &/ 0  // 得到0let z = x &% 0  // 得到0
println(y) 
println(z)