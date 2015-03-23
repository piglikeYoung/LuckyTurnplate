//
//  JHWheel.h
//  幸运转盘
//
//  Created by piglikeyoung on 15/3/21.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHWheel : UIView

+ (instancetype)wheel;

// 提供两个方法供外界调用开始和结束动画

- (void)startRotating;
- (void)stopRotating;

@end
