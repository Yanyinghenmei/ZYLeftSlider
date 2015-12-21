//
//  UIImage+ZY.m
//  WB
//
//  Created by qianfeng on 15/4/10.
//  Copyright (c) 2015年 Yanyinghenmei. All rights reserved.
//

#import "UIImage+ZY.h"
#import "ZYHeader.h"

@implementation UIImage (ZY)

+ (UIImage *)resizedImageWithNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    
    //保护图片某部分不被拉伸
    return [image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height *0.5];
}

@end
