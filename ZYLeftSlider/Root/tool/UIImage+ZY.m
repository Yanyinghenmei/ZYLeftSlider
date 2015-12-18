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

+ (UIImage *)imageWithNamed:(NSString *)name {
    if (iOS8) {
        NSString *newName = [NSString stringWithFormat:@"%@%@", name, @"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil) {
            image = [UIImage imageNamed:name];
        }
        return image;
    } else {
        UIImage *image = [UIImage imageNamed:name];
        return image ;
    }
}

+ (UIImage *)resizedImageWithNamed:(NSString *)name {
    UIImage *image = [UIImage imageWithNamed:name];
    
    //保护图片某部分不被拉伸
    return [image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height *0.5];
}

@end
