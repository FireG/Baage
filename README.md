# Baage
Baage 用拼音读：八阿哥，一个bug的收集工具，截图，捕获崩溃日志

使用：

异常日志捕获

APPDelegate中导入头文件#import "CrashHandler.h"
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CrashExceptionHandler();
    return YES;
}
```

异常日志扫描并发送邮件
App启动第一个页面导入#import "UIViewController+send.h"
```
- (void)viewDidLoad {
    [super viewDidLoad];
    [self crashLog];
}
```


实现摇一摇截图并发送邮件导入 #import "UIViewController+Screenshot.h" 不用写代码


