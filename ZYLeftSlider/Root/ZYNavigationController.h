//
//  ZYNavigationController.h
//  Lizard
//
//  Created by Daniel on 15/11/25.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYNavigationController : UINavigationController

//侧边栏
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIPanGestureRecognizer *leftPanGes;

//显示侧边栏
- (void)showLeftAnimation;

@end
