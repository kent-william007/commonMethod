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
//越狱判断
+ (BOOL)mgjpf
{
    //以下检测的过程是越往下，越狱越高级
    
    //    /Applications/Cydia.app, /privte/var/stash
    //BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        //jailbroken = YES;
        return YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        //jailbroken = YES;
        return YES;
    }
    
    //可能存在hook了NSFileManager方法，此处用底层C stat去检测
    struct stat stat_info;
    if (0 == stat("/Library/MobileSubstrate/MobileSubstrate.dylib", &stat_info)) {
        //jailbroken = YES;
        return YES;
    }
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        //jailbroken = YES;
        return YES;
    }
    if (0 == stat("/var/lib/cydia/", &stat_info)) {
        //jailbroken = YES;
        return YES;
    }
    if (0 == stat("/var/cache/apt", &stat_info)) {
        //jailbroken = YES;
        return YES;
    }
    //    /Library/MobileSubstrate/MobileSubstrate.dylib 最重要的越狱文件，几乎所有的越狱机都会安装MobileSubstrate
    //    /Applications/Cydia.app/ /var/lib/cydia/绝大多数越狱机都会安装
    //    /var/cache/apt /var/lib/apt /etc/apt
    //    /bin/bash /bin/sh
    //    /usr/sbin/sshd /usr/libexec/ssh-keysign /etc/ssh/sshd_config
    
    //可能存在stat也被hook了，可以看stat是不是出自系统库，有没有被攻击者换掉
    //这种情况出现的可能性很小
    int ret;
    Dl_info dylib_info;
    int (*func_stat)(const char *,struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        NSLog(@"lib:%s",dylib_info.dli_fname);      //如果不是系统库，肯定被攻击了
        if (strcmp(dylib_info.dli_fname, "/usr/lib/system/libsystem_kernel.dylib")) {   //不相等，肯定被攻击了，相等为0
            //jailbroken = YES;
            return YES;
        }
    }
    
    //还可以检测链接动态库，看下是否被链接了异常动态库，但是此方法存在appStore审核不通过的情况，这里不作罗列
    //通常，越狱机的输出结果会包含字符串： Library/MobileSubstrate/MobileSubstrate.dylib——之所以用检测链接动态库的方法，是可能存在前面的方法被hook的情况。这个字符串，前面的stat已经做了
    
    //如果攻击者给MobileSubstrate改名，但是原理都是通过DYLD_INSERT_LIBRARIES注入动态库
    //那么可以，检测当前程序运行的环境变量
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    if (env != NULL) {
        //jailbroken = YES;
        return YES;
    }
    return NO;
    //return jailbroken;
}

@end
