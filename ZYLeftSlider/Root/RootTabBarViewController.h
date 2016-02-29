//
//  RootTabBarViewController.h
//  Lizard
//
//  Created by Daniel on 16/1/21.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SelectViewControllerType) {
    SelectViewControllerTypeRoot,
    SelectViewControllerTypeCurrent
};

@interface RootTabBarViewController : UITabBarController
@property(nonatomic,strong)UITableView *leftView;
@property(nonatomic,strong)UIPanGestureRecognizer *leftPanGes;

/**
 *  返回上一个navController时, 是否直接回到navController的rootViewController
 */
@property(nonatomic,assign)SelectViewControllerType selectViewControllerType;

// 显示侧边栏
- (void)leftSliderShowAnimation;
// 隐藏侧边栏
- (void)leftSliderHideAnimation;

@end
