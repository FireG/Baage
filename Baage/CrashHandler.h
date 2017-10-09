//
//  CrashHandler.h
//  Baage
//
//  Created by Guo on 2017/10/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrashHandler : NSObject

@end

//函数方法，AppDelegate中调用
void CrashExceptionHandler(void);
