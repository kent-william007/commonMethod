//
//  XJCommon.h
//  ninDictionary
//
//  Created by kent on 2018/3/22.
//  Copyright © 2018年 kent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJCommon : NSObject

//遍历字典或数组把所有的NSnull替换为@""
//通常后台返回来的数据不可靠，可能会返回null
//把后台返回来的数据先过滤一遍再返回业务层，防止取值奔溃
+(id)ergodic:(id)dict;

@end
