//
//  Header.h
//  Zpaste
//
//  Created by 章中元 on 2018/7/29.
//  Copyright © 2018年 章中元. All rights reserved.
//

#ifndef ZpasteController_h
#define ZpasteController_h

#import <Foundation/Foundation.h>
#import <AppKit/NSPasteboard.h>
#import "Deamon.h"

void list_paste(void);
void pastemain (void);
id ReadArrayStr (int *arg);
void WritePasteString(NSString *str );





#endif /* ZpasteController_h */
