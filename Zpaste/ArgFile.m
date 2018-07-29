//
//  ArgFile.c
//  Zpaste
//
//  Created by 章中元 on 2018/7/29.
//  Copyright © 2018年 章中元. All rights reserved.
//

#import "ArgFile.h"


void argctl(int argc, const char * argv[]){
    
    if (argc == 1)
        list_paste();
    if (argc != 1){
        if (strcmp(argv[1], "-d")==0){
            pastemain();
            
            /*
             又是一个坑。。
             */
            
            //           printf("%s\n",argv[1]);
            //            NSLog(@"hello");
        }
        else
        {
            printf("Usage:\n paste [options]\n\nOptions:\n          -h : 显示此界面;\n          -d : 在后台运行;\n");
            
        }
        
    }
}
