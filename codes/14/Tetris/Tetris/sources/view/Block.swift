//
//  Block.swift
//  Tetris
//
//  Created by yeeku on 14-10-12.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

struct Block :Printable
{
	var x: Int
	var y: Int
	var color: Int
	var description :String{
		return "Block[x=\(x), y=\(y), color=\(color)]"
	}
}
