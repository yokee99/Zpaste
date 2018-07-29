//
//  deamon.h
//  Zpaste
//
//  Created by 章中元 on 2018/7/29.
//  Copyright © 2018年 章中元. All rights reserved.
//

#ifndef deamon_h
#define deamon_h

#import <stdio.h>
#import <unistd.h>
#import <sys/param.h>
#import <sys/types.h>
#import <sys/stat.h>
#import <sys/errno.h>
#import <sys/fcntl.h>


#define NSLog(FORMAT, ...) printf("%s", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

#define LOCKFILE "/var/run/paste.pid"

/*
            字符串颜色设置
 "\033[背景颜色;字体颜色m字符串\033[5m\n"
 
 +----------------+----------------+
 | 背景颜色                 字体颜色  |
 +----------------+----------------+
 | 40           黑色           30   |
 | 41           红色           31   |
 | 42           绿色           32   |
 | 43           黄色           33   |
 | 44           蓝色           34   |
 | 45           紫色           35   |
 | 46           青色           36   |
 +---------------------------------+
        \033[;32m%s\033[5m\n
 */




void make_deamon(void);
int lock_file (int fd );
int alone_run (void);

#endif /* deamon_h */
