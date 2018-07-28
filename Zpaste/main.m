//
//  main.m
//  Zpaste
//
//  Created by 章中元 on 2018/7/28.
//  Copyright © 2018年 章中元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/NSPasteboard.h>
#import <stdio.h>
#import <unistd.h>
#import <sys/param.h>
#import <sys/types.h>
#import <sys/stat.h>




#define NSLog(FORMAT, ...) printf("\033[;32m%s\033[5m\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])



/*
 字符串颜色设置
 "\033[背景颜色;字体颜色m字符串\033[5m\n"
 
 +----------------+----------------+
 | 背景颜色                 字体颜色  |
 +----------------+----------------+
 | 40           黑色           30  |
 | 41           红色           31  |
 | 42           绿色           32  |
 | 43           黄色           33  |
 | 44           蓝色           34  |
 | 45           紫色           35  |
 | 46           青色           36  |
 +---------------------------------+
 */


#define LOCKFILE "/var/run/paste.pid"
int lock_file (int fd ){
    
    struct flock f1;
    
    f1.l_len=0;
    f1.l_start=0;
    f1.l_type=F_WRLCK;
    f1.l_whence=SEEK_SET;
    
    return (fcntl(fd, F_SETLK , &f1)) ;
}
int alone_run (void){
    int fd;
    char buf[16];
    
    
    fd =open(LOCKFILE, O_RDWR|O_CREAT,0666);
    
    if (fd<0) {
        perror("code open ");
        exit(1);
        
    }
    
    
    if (lock_file(fd)<0) {
        if (errno == EACCES||errno==EAGAIN) {
            close(fd);
            printf("alone running \n ");
            return -1;
        }
        
        printf("can't lock %s : %s\n", LOCKFILE,strerror(errno));
        
    }
    
    ftruncate(fd, 0);
    sprintf(buf, "%ld",(long)getpid());
    write(fd,buf, strlen(buf)+1);
    
    return 0;
    
}


void list_paste(void ){
    
    NSArray *pastlist = [NSArray arrayWithContentsOfFile:@"/tmp/PASTLIST.txt"];
    
    NSUInteger count = [pastlist count];
    for (int i = 0 ; i!=count; i++) {
        id obj = [pastlist objectAtIndex:i];
        printf("\033[;33m[%d]:\033[5m",i);
        NSLog(@"%@",obj);
    }
    
    /* 最方便的遍历 由于要输出序号而遗弃
     for (id obj in pastlist ){
     
     NSLog(@"%@",obj);
     }
     */
    
    
    return;
    
}





void make_deamon(void){
    
    /*
     守护进程模块
    */
    pid_t pid ;
    int i ;
    if (pid = fork())
        exit(0);
    else if (pid < 0 )
        exit(1);
    
    
    setsid();
    
    if (pid = fork())
        exit(0);
    else if (pid< 0 )
        exit (1);
    
    
    for (  i = 0 ; i < NOFILE;++i)
        close(i);
    chdir("/tmp");
    
    umask(0);
    return ;
    
}




void pastemain (){
    // insert code here...
    NSString *initchar = @"init char nuihibgyugfbyhiujkjhgfdsdcvbnjytre";
    
    NSMutableArray *strArray = [[NSMutableArray alloc]init];
    
    make_deamon();
    // alone_run();  待优化
    
    while(true){
        
        
        NSPasteboard *applepastes = [NSPasteboard generalPasteboard];
        //            NSInteger *tes = [[applepastes types] containsObject:NSPasteboardTypeString];
        NSString *str = [applepastes stringForType:NSPasteboardTypeString];
        
        if ([str isEqual:initchar] )
        /*
         *必须用到“isEqual:”方法， 坑了我许久！！
         *
         *
         */
            [NSThread sleepForTimeInterval:1];
        //  NSLog(@"%@",str );
        
        
        else if (str != initchar){
            //NSLog(@"%@",str );
            
            //     [NSThread sleepForTimeInterval:1]; 调试用
            [strArray addObject:str];
            [strArray writeToFile:@"PASTLIST.txt"  atomically:YES ];
            //                NSLog(@"数组里有");
            //                for (NSObject *obj in strArray){
            //                   NSLog(@"%@", obj);
            //            }
            
            initchar = [str copy];
            
        }
    }
    
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc == 1)
            list_paste();
        if (argc != 1){
            if (strcmp(argv[1], "-d")==0){
                pastemain();
                
                /*
                 又是一个坑。。
                 */
                
            }
            else
            {
                printf("Usage:\n paste [options]\n\nOptions:\n          -h : 显示此界面;\n          -d : 在后台运行;\n");
                
            }
            
        }
    }
    return 0;
}
