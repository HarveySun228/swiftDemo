//
//  FKSayHi.h
//  CallOC
//
//  Created by yeeku on 14/10/25.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKSayHi : NSObject
// 合成一个名为curDate的属性
@property (nonatomic, copy) NSDate* curDate;
- (id) initWithDate:(NSDate*) date;
- (NSString*) sayHi:(NSString*)name;
@end
