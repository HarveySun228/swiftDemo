var day = Weekday.Saturday// 获取枚举的原始值println(".Saturday的原始值为：\(day.rawValue)") // 输出8day = .Thursdayprintln(".Thursday的原始值为：\(day.rawValue)") // 输出6// 根据原始值来获取枚举值var mySeason = Season(rawValue: "S")if mySeason != nil{    // 使用switch语句判断mySeason    // 需要使用!进行强制解析    switch(mySeason!){        case .Spring:            println("春天不是读书天")        case .Summer:            println("夏日炎炎正好眠")        case .Fall , .Winter:            println("秋多蚊蝇冬日冷")        default:            println("读书只好等明年")    }}