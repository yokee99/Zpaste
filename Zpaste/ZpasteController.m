//
//  ZpasteController.m
//  Zpaste
//
//  Created by 章中元 on 2018/7/29.
//  Copyright © 2018年 章中元. All rights reserved.
//

#import "ZpasteController.h"


void list_paste(void){
    
    
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

void pastemain (void){
    
    NSString *initchar = @"initchar#nuihibgyugfbyhiujkjhgfdsdcvbnjytre";
    
    NSMutableArray *strArray = [[NSMutableArray alloc]init];
    
    make_deamon();
    // alone_run();
    
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

