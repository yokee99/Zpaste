//
//  deamon.c
//  Zpaste
//
//  Created by 章中元 on 2018/7/29.
//  Copyright © 2018年 章中元. All rights reserved.
//

#include "Deamon.h"



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
