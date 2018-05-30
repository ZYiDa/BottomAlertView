//
//  ViewController.m
//  BottomAlertView
//
//  Created by 立元通信 on 2018/5/29.
//  Copyright © 2018年 zcz. All rights reserved.
//

#import "ViewController.h"
#import "BottomAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
}

- (IBAction)show:(id)sender {
    [BottomAlertView showAlertWithMessage:@"Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib." andTapAction:nil];
}
- (IBAction)dismiss:(id)sender {
    [BottomAlertView dismissAlertWithDelay:2 complete:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
