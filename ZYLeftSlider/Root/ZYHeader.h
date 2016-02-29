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

#define Boundary 60 //滑动分界
#define HideFrame CGRectMake(0, 0, DeviceWidth, DeviceHeight)
#define ShowFrame CGRectMake(DeviceWidth*0.4, 0, DeviceWidth, DeviceHeight)

#define LeftHideFrame CGRectMake(-DeviceWidth*0.4/2, 0, DeviceWidth *0.4, DeviceHeight)
#define LeftShowFrame CGRectMake(0, 0, DeviceWidth *0.4, DeviceHeight)

//16进制转化为RGB颜色
#define HEXCOLORV(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define SelectedColor [UIColor purpleColor]
#define NormalColor [UIColor lightGrayColor]

#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

#endif /* ZYHeader_h */
