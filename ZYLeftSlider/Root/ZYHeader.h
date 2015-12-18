//
//  ZYHeader.h
//  ZYLeftSlider
//
//  Created by Daniel on 15/12/18.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#ifndef ZYHeader_h
#define ZYHeader_h

#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
//  5.获得RGB颜色
#define HEXCOLORV(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define HideFrame CGRectMake(-DeviceWidth, 0, DeviceWidth, DeviceHeight)
#define ShowFrame CGRectMake(0, 0, DeviceWidth, DeviceHeight)

#define SelectedColor 0xff5473
#define NormalColor 0xcccccc

#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

#endif /* ZYHeader_h */
