extension String{	// 定义一个嵌套枚举	enum Suit : String	{		case Diamond = "♦"		case Club = "♣"		case Heart = "❤"		case Spade = "♠"	}	// 通过扩展为String增加一个类型方法，用于判断指定字符串属于哪种花色	static func judgeSuit(s: String) -> Suit?	{		switch(s)		{			case "♦":				return .Diamond			case "♣":				return .Club			case "❤":				return .Heart			case "♠":				return .Spade			default:				return nil		}	}}// 使用String包含的嵌套枚举var s1: String.Suit? = String.judgeSuit("❤")println(s1)  // 输出 Optional((Enum Value))var s2: String.Suit? = String.judgeSuit("j")println(s2)  // 输出 nil