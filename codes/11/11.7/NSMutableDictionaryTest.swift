import Foundation// 创建空的NSMutableDictionary对象let dict:NSMutableDictionary = NSMutableDictionary()// 使用下标法设置key-value对。dict["疯狂Android讲义"] = 89// 由于NSDictionary中已存在该key，因此此处设置的value会覆盖前面的valuedict["疯狂Android讲义"] = 99println(dict as Dictionary)println("--再次添加key-value对--")dict["疯狂Swift讲义"] = 69println(dict as Dictionary)let dict2 = ["疯狂Ajax讲义": 79 , "疯狂iOS讲义": 99]// 将另一个NSDictionary中的key-value对添加到当前NSDictionary中dict.addEntriesFromDictionary(dict2)println(dict as Dictionary)// 根据key来删除key-value对dict.removeObjectForKey("疯狂Ajax讲义")println(dict as Dictionary)