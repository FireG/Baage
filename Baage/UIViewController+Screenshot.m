//
//  UIViewController+Screenshot.m
//  Baage
//
//  Created by Guo on 2017/10/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "UIViewController+Screenshot.h"
#import "UIViewController+send.h"
@implementation UIViewController (Screenshot)

//摇一摇时候会调用的方法，开始，取消，结束
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self screenShot];
}

//截屏
-(void)screenShot
{
    UIWindow *screen = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(screen.frame.size);
    [screen.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsGetCurrentContext();
    NSData *screenData = UIImagePNGRepresentation(image);
    
    //    __weak UIViewController *weakSelf = self;
    [self sendMail:screenData success:nil andFaild:^{
        [screenData writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"] atomically:YES];
    }];
    
}


@end
