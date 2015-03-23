//
//  JHWheel.m
//  幸运转盘
//
//  Created by piglikeyoung on 15/3/21.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHWheel.h"
#import "JHWheelButton.h"

@interface JHWheel()

/**
 *  转盘中间的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *centerWheel;
- (IBAction)startBtnClick:(UIButton *)sender;

/**
 *  定义属性记录当前选中的按钮
 */

@property (nonatomic, weak) UIButton *selectButton;

@property (strong , nonatomic) CADisplayLink *link;

@end

@implementation JHWheel

-(void)awakeFromNib
{
    // 0.让父控件可以交互
    self.centerWheel.userInteractionEnabled = YES;
    
    // 1.加载图片
    UIImage *norImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *selImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    // 创建12个按钮添加到中间的轮盘上
    for (int index = 0; index<12; index++) {
        // 1.创建按钮
        JHWheelButton *btn = [[JHWheelButton alloc] init];
        // 2.设置按钮选中状态的图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        // 3.设置按钮的bouns
        btn.bounds = CGRectMake(0, 0, 68, 143);
        
        // 4.设置按钮的锚点
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        // 5.设置按钮的postion
        btn.layer.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        
        // 6让按钮围绕锚点旋转
        // 6.1计算按钮应该旋转的弧度
        CGFloat angle = (30 * index) / 180.0 * M_PI;
        btn.transform = CGAffineTransformMakeRotation(angle);
        
        // 7.监听按钮的点击事件
        [btn addTarget:self action:@selector(update:) forControlEvents:UIControlEventTouchDown];
        
        // 获取当前是否是retain屏
        //        NSLog(@"%.1f", [UIScreen mainScreen].scale);
        
        // 8.切割图片，将切个好的图片设置到按钮上
        CGFloat imageH = JHImageHeight * [UIScreen mainScreen].scale;
        CGFloat imageW = JHImageWidth * [UIScreen mainScreen].scale;
        CGFloat imageY = 0;
        CGFloat imageX = index * imageW;
        CGRect rect = CGRectMake(imageX, imageY, imageW, imageH);
        // 8.1根据rect切割图片
        // CGImage中rect是当做像素来使用
        // UIKit 中是点坐标系
        // 坐标系的特点:如果在非retain屏上 1个点等于1个像素
        //   在retain屏上1个点等于2个像素
        // 剪切默认状态的图片
        CGImageRef norCGImageRef= CGImageCreateWithImageInRect(norImage.CGImage, rect);
        // 将切割好的图片转换为uiimage设置为按钮的背景
        [btn setImage:[UIImage imageWithCGImage:norCGImageRef]  forState:UIControlStateNormal];
        
        //   剪切选中状态图片
        CGImageRef selCGImageRef= CGImageCreateWithImageInRect(selImage.CGImage, rect);
        // 将切割好的图片转换为uiimage设置为按钮的背景
        [btn setImage:[UIImage imageWithCGImage:selCGImageRef]  forState:UIControlStateSelected];
        
        // 添加按钮到中间轮盘图片上
        [self.centerWheel addSubview:btn];
    }
}

+(instancetype)wheel
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JHWheel" owner:nil options:nil]lastObject];
}

-(void) update:(UIButton *) btn
{
    self.selectButton.selected = NO;
    
    btn.selected = YES;
    
    self.selectButton = btn;
}

- (IBAction)startBtnClick:(UIButton *)sender {
    
    // 禁止用户交互
    self.userInteractionEnabled = NO;
    
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"transform.rotation";
    anima.toValue = @(2 * M_PI * 3);
    anima.duration = 3.0;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anima.delegate = self;
    [self.centerWheel.layer addAnimation:anima forKey:nil];
}


-(void)startRotating
{
    // 防止重复创建定时器
    if (self.link != nil) {
        return;
    }
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(centerImageRotation)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

-(void)stopRotating
{
    // 关闭定时器
    [self.link invalidate];
    self.link = nil;
}

-(void)centerImageRotation
{
    self.centerWheel.transform = CGAffineTransformRotate(self.centerWheel.transform, M_PI_4/250);
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
}
@end
