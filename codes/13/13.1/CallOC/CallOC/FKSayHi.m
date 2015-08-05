//
//  FKSayHi.m
//  CallOC
//
//  Created by yeeku on 14/10/25.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

#import "FKSayHi.h"

@implementation FKSayHi
- (id) initWithDate:(NSDate*) date
{
	self = [super init];
	if (self) {
		self->_curDate = date;
	}
	return self;
}
- (NSString*) sayHi:(NSString*)name
{
	return [NSString stringWithFormat:@"%@,您好，现在时间是%@"
	, name, self.curDate];
}
@end
