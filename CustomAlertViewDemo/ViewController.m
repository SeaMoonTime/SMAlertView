//
//  ViewController.m
//  CustomAlertViewDemo
//
//  Created by Yang on 02/05/2018.
//  Copyright © 2018 SeaMoonTime. All rights reserved.
//

#import "ViewController.h"
#import "SMCustomAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClick:(UIButton *)sender {
    
    SMCustomAlertView *alert = [[SMCustomAlertView alloc]initWithFrame:CGRectMake(0, 0, 250, 170) withTitle:@"警告" alertMessage:@"ProcessOn 支持流程图、思维导图、原型图、UML、网络拓扑图等" confirmBlock:^{
        NSLog(@"You confirm the button");
    } cancelBlock:^{
        NSLog(@"You cancel the button");
    }];
    [alert show];
    
}


@end
