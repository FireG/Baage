//
//  UIViewController+send.h
//  Baage
//
//  Created by Guo on 2017/10/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

typedef void(^MailSuccess)(void);
typedef void(^MailFaild)(void);


@interface UIViewController (send)<MFMailComposeViewControllerDelegate>
//成功回调，运行时添加
@property (nonatomic,copy)MailSuccess success;
//失败回调，运行时添加
@property (nonatomic,copy)MailFaild faild;
//弹框
-(void)alertView:(NSString *)title andDesc:(NSString*)desc;
//发送邮件方法，传递回调
-(void)sendMail:(NSData*)data success:(MailSuccess)success andFaild:(MailFaild)faild;
//崩溃Bug检测，在App着陆页调用
-(void)crashLog;
//预留接口
-(void)sendRequest;

@end
