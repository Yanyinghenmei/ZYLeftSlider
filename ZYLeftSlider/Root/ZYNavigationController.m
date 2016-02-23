//
//  ZYNavigationController.m
//  Lizard
//
//  Created by Daniel on 15/11/25.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "ZYNavigationController.h"
#import "ZYHeader.h"

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
    NSDictionary *attr = @{NSForegroundColorAttributeName:HEXCOLORV(0x777777),NSFontAttributeName:[UIFont systemFontOfSize:16]};
    [bar setTitleTextAttributes:attr];
    
    //按钮图片渲染
    [bar setTintColor:SelectedColor];
    
    //按钮属性
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSDictionary *itemAttr = @{NSForegroundColorAttributeName:HEXCOLORV(0x516DBE),NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [item setTitleTextAttributes:itemAttr forState:UIControlStateNormal];
    [item setTintColor:SelectedColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    //返回键样式定制
    UIBarButtonItem *backitem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    viewController.navigationItem.backBarButtonItem = backitem;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
//    return self.topViewController;//栈顶的控制器 一般就是当前可见的控制器
    return self.visibleViewController;//当前可见的控制器
}
@end
