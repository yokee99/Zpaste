//
//  main.m
//  Zpaste
//
//  Created by 章中元 on 2018/7/28.
//  Copyright © 2018年 章中元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZpasteController.h"

#define HELPMSG "Usage:\n Zpaste <commands> [options]\n\nCommands:\n          help : 显示此界面;\n          run  : 在后台运行;\n          list : 列出剪切板;\n          use  : 需加入参数[option],拷贝\n\nVersion 1.1\n"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        if (argc == 1)
            printf(HELPMSG);
            
            //list_paste();
        
        
        
        
       else if (argc == 2){
            if (strcmp(argv[1], "run")==0){
                pastemain();
            }
            else if(strcmp(argv[1], "list")==0)
            {
                list_paste();
            }
            else
            {
                printf(HELPMSG);
            }
            
            
        }
       else if (argc == 3&&strcmp(argv[1],"use")==0){
           int arg = strtol(argv[2], NULL, 10);
           
           NSString *str = ReadArrayStr(arg);
           
           WritePasteString(str);
           NSLog(@"\033[;32m\"%@\" Successfully copied ！\033[5m\n",str);
           }
           
       
        
    }
    return 0;
}
