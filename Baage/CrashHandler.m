//
//  CrashHandler.m
//  Baage
//
//  Created by Guo on 2017/10/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "CrashHandler.h"

@implementation CrashHandler
+(void)saveLog:(NSString *)crashLog andDate:(NSDate *)date
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingString:@"/Crash"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager]createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *logPath = [path stringByAppendingFormat:@"/%@.log",date];
    [crashLog writeToFile:logPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
@end

void ExceptionLog(NSException *exception)
{
    NSDate *date_current = [NSDate date];
    NSDictionary *dictInfo = [[NSBundle mainBundle]infoDictionary];
    NSString *name_App = [dictInfo objectForKey:@"CFBundleDisplayName"];
    NSString *verson_App = [dictInfo objectForKey:@"CFBundleShortVersionString"];
    NSString *build_App = [dictInfo objectForKey:@"CFBundleVersion"];
    NSArray *ecp = exception.callStackSymbols;
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:
                               @"\n\n ******************************异常日志****************************** \n时间:%@\nApp名称:%@\nApp版本:%@\nBuild版本:%@\n异常名称:%@\n异常原因:%@\n堆栈信息:%@",date_current,name_App,verson_App,build_App,name,reason,ecp];
    [CrashHandler saveLog:exceptionInfo andDate:date_current];
#ifdef DEBUG
    NSLog(@"%@",exceptionInfo);
#else
    
#endif
    
    
}

void CrashExceptionHandler(void)
{
    NSSetUncaughtExceptionHandler(&ExceptionLog);
}

