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

@property (nonatomic,copy)MailSuccess success;
@property (nonatomic,copy)MailFaild faild;

-(void)alertView:(NSString *)title andDesc:(NSString*)desc;
-(void)sendMail:(NSData*)data success:(MailSuccess)success andFaild:(MailFaild)faild;
-(void)crashLog;

-(void)sendRequest;

@end
