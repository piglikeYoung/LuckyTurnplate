//
//  JHWheelButton.m
//  幸运转盘
//
//  Created by piglikeyoung on 15/3/21.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHWheelButton.h"

@implementation JHWheelButton


/**
 调整按钮中图片显示的大小，x轴居中显示，y轴从18开始
 */
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{

    CGFloat imageX = (contentRect.size.width - JHImageWidth ) * 0.5;
    CGFloat imageY = 18;
    return CGRectMake(imageX, imageY, JHImageWidth, JHImageHeight);
}

-(void)setHighlighted:(BOOL)highlighted
{

}
@end
