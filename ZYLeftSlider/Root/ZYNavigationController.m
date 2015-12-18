//
//  ZYNavigationController.m
//  Lizard
//
//  Created by Daniel on 15/11/25.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "ZYNavigationController.h"
#import "ZYHeader.h"

#define Boundary 90 //滑动分界

@interface ZYNavigationController ()
@end

@implementation ZYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTheme];
}

//主题
- (void)setNavigationBarTheme {
    //title属性
    UINavigationBar *bar = [UINavigationBar appearance];
    NSDictionary *attr = @{NSForegroundColorAttributeName:HEXCOLORV(0x999999),NSFontAttributeName:[UIFont systemFontOfSize:16]};
    [bar setTitleTextAttributes:attr];
    
    //按钮图片渲染
    [bar setTintColor:HEXCOLORV(SelectedColor)];
    
    //按钮属性
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSDictionary *itemAttr = @{NSForegroundColorAttributeName:HEXCOLORV(SelectedColor),NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [item setTitleTextAttributes:itemAttr forState:UIControlStateNormal];
    [item setTintColor:HEXCOLORV(SelectedColor)];
}

//侧边栏
- (void)setLeftViewControlWithView:(UIView *)view {
    self.leftView = view;
    [self setPanGes];
}
- (void)setLeftView:(UIView *)leftView {
    _leftView = leftView;
    [self setPanGes];
}

- (void)setPanGes {
    _leftPanGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesClick:)];
    [[[UIApplication sharedApplication].delegate window] addGestureRecognizer:_leftPanGes];
}

- (void)gesClick:(UIPanGestureRecognizer *)panGes {
    static CGFloat transX;   //相对于初始位置的坐标
    static BOOL currentState;//初始移动方向
    if (panGes.state == UIGestureRecognizerStateBegan) {
        BOOL left = YES;
        BOOL rigit = NO;
        if (_leftView.frame.origin.x == HideFrame.origin.x) {
            currentState = left;
        } else {
            currentState = rigit;
        }
    }
    if (panGes.state == UIGestureRecognizerStateChanged) {//监听手指移动
        transX = [panGes translationInView:panGes.view].x;//获取手指移动距离
        
        //跳过反向滑动
        if (_leftView.frame.origin.x <= HideFrame.origin.x && transX<0) {
            _leftView.frame = HideFrame;
            return;
        } else if (_leftView.frame.origin.x >= ShowFrame.origin.x && transX>0) {
            _leftView.frame = ShowFrame;
            return;
        }
        
        //View随手指移动
        if (currentState) {
            [UIView animateWithDuration:0.2 animations:^{
                CGRect frame = HideFrame;
                frame.origin.x = HideFrame.origin.x + transX;
                _leftView.frame = frame;
            }];
        } else {
            [UIView animateWithDuration:0.2 animations:^{
                CGRect frame = ShowFrame;
                frame.origin.x = ShowFrame.origin.x + transX;
                _leftView.frame = frame;
            }];
        }
    }
    //手指离开屏幕
    if (panGes.state == UIGestureRecognizerStateEnded) {
        if (transX>0) {
            if (_leftView.frame.origin.x>=Boundary-DeviceWidth) {
                [UIView animateWithDuration:0.5 animations:^{
                    _leftView.frame = ShowFrame;
                }];
            } else if (_leftView.frame.origin.x<=Boundary-DeviceWidth) {
                [UIView animateWithDuration:0.5 animations:^{
                    _leftView.frame = HideFrame;
                }];
            }
        } else if (transX<0) {
            if (_leftView.frame.origin.x>=Boundary) {
                [UIView animateWithDuration:0.5 animations:^{
                    _leftView.frame = ShowFrame;
                }];
            } else if (_leftView.frame.origin.x<=Boundary) {
                [UIView animateWithDuration:0.5 animations:^{
                    _leftView.frame = HideFrame;
                }];
            }
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    //返回键样式定制
    
    if (self.viewControllers.count!=1 && self.viewControllers.count!=2) {
        UIBarButtonItem *backitem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        viewController.navigationItem.backBarButtonItem = backitem;
    } else {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"侧边栏" style:UIBarButtonItemStylePlain target:self action:@selector(showLeftAnimation)];
        viewController.navigationItem.leftBarButtonItem= left;
    }
    
    //不隐藏
    self.navigationBar.hidden = NO;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
//    return self.topViewController;//栈顶的控制器 一般就是当前可见的控制器
    return self.visibleViewController;//当前可见的控制器
}

- (void)showLeftAnimation {
    [UIView animateWithDuration:0.6 animations:^{
        [[[UIApplication sharedApplication].delegate window] viewWithTag:142857].frame = ShowFrame;
    }];
}

@end
