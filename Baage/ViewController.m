//
//  ViewController.m
//  Baage
//
//  Created by Guo on 2017/10/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+send.h"
#import "UIViewController+Screenshot.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self crashLog];
}
- (IBAction)Crash:(id)sender {
    NSArray *array = @[@3,@8,@"guozihui"];
    NSString *str = array[9];
    NSLog(@"%@",str);
}

@end
