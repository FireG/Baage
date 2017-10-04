//
//  UIViewController+send.m
//  Baage
//
//  Created by Guo on 2017/10/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "UIViewController+send.h"
#import <objc/message.h>

static const char *faild_key = "faild";
static const char *success_key = "success";

@implementation UIViewController (send)

-(void)sendRequest
{
    
}

-(void)crashLog
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingString:@"/Crash"];
    NSFileManager *mf = [NSFileManager defaultManager];
    if(![mf fileExistsAtPath:path])
    {
        return;
    }
    NSArray *array = [mf contentsOfDirectoryAtPath:path error:nil];
    
    MFMailComposeViewController *mfMail = [MFMailComposeViewController new];
    NSString *subject = @"Crash Log";
    NSString *message = @"发现崩溃日志";
    NSArray *recipients = @[@"1216999604@qq.com",@"277121132@qq.com"];
    for (int i=0; i<array.count; i++) {
        NSString *name = array[i];
        NSString *string = [path stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
        if ([string containsString:@".log"]){
            NSData *data = [NSData dataWithContentsOfFile:string];
            [mfMail addAttachmentData:data mimeType:@"" fileName:name];
        }
    }
    [self sendMail:mfMail andSubject:subject andMessageBody:message andRecipients:recipients];
    self.success = ^{
        [mf removeItemAtPath:path error:nil];
    };
}

-(void)sendMail:(NSData*)data success:(MailSuccess)success andFaild:(MailFaild)faild
{
    MFMailComposeViewController *mfMail = [MFMailComposeViewController new];
    NSString *subject = @"Bug_李雷雷";
    NSString *message = @"这个页面有问题";
    NSArray *recipients = @[@"1216999604@qq.com",@"277121132@qq.com"];
    [mfMail addAttachmentData:data mimeType:@"image/jpeg" fileName:@"error"];
    [self sendMail:mfMail andSubject:subject andMessageBody:message andRecipients:recipients];
    if(success && faild){
        self.success = success;
        self.faild = faild;
    }
}

-(void)sendMail:(MFMailComposeViewController*)mf andSubject:(NSString*)subject andMessageBody:(NSString*)message andRecipients:(NSArray*)recipients
{
    if([MFMailComposeViewController canSendMail]){
        mf.mailComposeDelegate = self;
        [mf setSubject:subject];
        [mf setToRecipients:recipients];
        [mf setMessageBody:message isHTML:YES];
        [self presentViewController:mf animated:YES completion:nil];
    }else{
        [self alertView:@"不能调用邮箱" andDesc:@"请尝试下载App原生邮箱，并配置"];
    }
}



-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            
            [self alertView:@"发送成功" andDesc:nil];
            self.success();
            break;
        case MFMailComposeResultSaved:
            [self alertView:@"保存成功" andDesc:nil];
            break;
        case MFMailComposeResultFailed:
            self.faild();
            [self alertView:error.domain andDesc:[NSString stringWithFormat:@"%@",error.userInfo]];
            break;
        case MFMailComposeResultCancelled:
            [self alertView:@"取消发送" andDesc:nil];
            break;
        default:
            [self alertView:@"为什么不发送" andDesc:nil];
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)alertView:(NSString *)title andDesc:(NSString*)desc{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(MailFaild)faild
{
    return objc_getAssociatedObject(self, faild_key);
};

-(void)setFaild:(MailFaild)faild
{
    objc_setAssociatedObject(self, faild_key, faild, OBJC_ASSOCIATION_COPY);
};


-(MailSuccess)success{
    return objc_getAssociatedObject(self, success_key);
};

-(void)setSuccess:(MailSuccess)success{
    objc_setAssociatedObject(self, success_key, success, OBJC_ASSOCIATION_COPY);
}



@end
