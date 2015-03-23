//
//  ViewController.m
//  幸运转盘
//
//  Created by piglikeyoung on 15/3/21.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "ViewController.h"
#import "JHWheel.h"

@interface ViewController ()
- (IBAction)start:(UIButton *)sender;
- (IBAction)stop:(UIButton *)sender;

@property (weak , nonatomic) JHWheel *wheel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JHWheel *wheel = [JHWheel wheel];
    wheel.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    
    [self.view addSubview:wheel];
    
    self.wheel = wheel;
}

- (IBAction)start:(UIButton *)sender {
    
    [self.wheel startRotating];
}

- (IBAction)stop:(UIButton *)sender {
    
    [self.wheel stopRotating];
}
@end
