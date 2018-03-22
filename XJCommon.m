//
//  XJCommon.m
//  ninDictionary
//
//  Created by kent on 2018/3/22.
//  Copyright © 2018年 kent. All rights reserved.
//

#import "XJCommon.h"

@implementation XJCommon

//遍历字典或数组把所有的NSnull替换为@""
+(id)ergodic:(id)dict
{
    if ([dict isKindOfClass:[NSDictionary class]]) {
        NSArray *keyArray = [dict allKeys];
        for (int i = 0; i < keyArray.count; i++) {
            NSString *key = keyArray[i];
            NSString *value = dict[key];
            
            if ([value isKindOfClass:[NSDictionary class]] ||
                [value isKindOfClass:[NSArray class]]) {
                NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:dict];
                [tmpDict setObject:[[self class] ergodic:value] forKey:key];
                dict = tmpDict;
            } else if ([value isKindOfClass:[NSNull class]]) {
                NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:dict];
                [tmpDict setObject:@"" forKey:key];
                dict = tmpDict;
            }
        }
        return dict;
    } else if ([dict isKindOfClass:[NSArray class]]) {
        NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:dict];
        for (int i = 0; i < [tmpArray count]; i++) {
            NSObject *object = tmpArray[i];
            if ([object isKindOfClass:[NSDictionary class]] ||
                [object isKindOfClass:[NSArray class]]) {
                [tmpArray replaceObjectAtIndex:i  withObject:[[self class] ergodic:object]];
            }
        }
        return tmpArray;
    } else {
        return dict;
    }
}

@end
