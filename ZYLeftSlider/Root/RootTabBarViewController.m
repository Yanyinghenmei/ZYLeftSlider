//
//  RootTabBarViewController.m
//  Lizard
//
//  Created by Daniel on 16/1/21.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "RootTabBarViewController.h"

#import "ZYHeader.h"

#import "ZYNavigationController.h"
#import "LeftItemCell.h"
#import "IWBadgeButton.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

#import "IWBadgeButton.h"

@interface RootTabBarViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSArray *controllers;//控制器数组
@property(nonatomic,strong)NSArray *leftItems;  //标题数组
@property(nonatomic,strong)NSArray *leftDetails;  //副标题
@property(nonatomic,strong)NSArray *leftImages;  //图标数组
@property(nonatomic,strong)IWBadgeButton *badgeBtn;  //消息数字角标

@end

@implementation RootTabBarViewController {
    NSInteger selectCellIndex;
}

- (instancetype)init {
    if (self = [super init]) {
        
        [self setShadow];
        
        [self setTabBar];
        [self setControllers];
        [self CreatLeftView];
        [self setPanGes];
    }
    return self;
}

- (void)setShadow {
    self.view.layer.shadowColor = HEXCOLORV(0xcccccc).CGColor;
    self.view.layer.shadowOpacity = 1;
    self.view.layer.shadowOffset = CGSizeMake(-4, 0);
    self.view.layer.shadowRadius = 5;
}

- (void)setTabBar {
    self.tabBar.hidden = YES;
}

- (void)setControllers {
    FirstViewController *first = [FirstViewController new];
    SecondViewController *second = [SecondViewController new];
    ThirdViewController *third = [ThirdViewController new];
    FourthViewController *fourth = [FourthViewController new];
    
    _controllers = @[first, second, third, fourth];
    
    ZYNavigationController *nav0 = [[ZYNavigationController alloc] initWithRootViewController:first];
    ZYNavigationController *nav1 = [[ZYNavigationController alloc] initWithRootViewController:second];
    ZYNavigationController *nav2 = [[ZYNavigationController alloc] initWithRootViewController:third];
    ZYNavigationController *nav3 = [[ZYNavigationController alloc] initWithRootViewController:fourth];
    
    self.viewControllers = @[nav0,nav1,nav2,nav3];
    
    _leftItems = @[@"first",@"second",@"third",@"fourth"];
    _leftDetails = @[@"第一",@"第二",@"第三",@"第四"];
    _leftImages = @[@"image1",@"image2",@"image3",@"image4"];
    
    //初始控制器
    [self.navigationController pushViewController:first animated:NO];
}

#pragma mark -- leftView and delegate
- (void)CreatLeftView {
    [[[UIApplication sharedApplication].delegate window] insertSubview:self.leftView belowSubview:self.view];
}

- (UITableView *)leftView {
    if (!_leftView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LeftHideFrame.size.width, 180)];
        headerView.backgroundColor = [UIColor whiteColor];
        
        CGFloat footHeight = DeviceHeight-420;
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LeftHideFrame.size.width, footHeight)];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, footHeight-120, LeftHideFrame.size.width, 30)];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = HEXCOLORV(0x999999);
        lab.text = @"–– Yanyinghenmei ––";
        lab.numberOfLines = 0;
        [footerView addSubview:lab];
        
        _leftView = [[UITableView alloc] initWithFrame:LeftHideFrame style:UITableViewStylePlain];
        _leftView.scrollEnabled = NO;
        _leftView.backgroundColor = [UIColor whiteColor];
        _leftView.delegate = self;
        _leftView.dataSource = self;
        _leftView.alpha = 0.95;
        _leftView.tag = 142857;
        _leftView.tableHeaderView = headerView;
        _leftView.tableFooterView = footerView;
        _leftView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //初始选中第一个cell-- reloadData一次 才能设置cell被选中
        [_leftView reloadData];
        
        UITableViewCell *cell = [(UITableView *)_leftView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.selected = YES;
        selectCellIndex = 0;
    }
    return _leftView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _leftImages.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftItemCell *cell = [LeftItemCell cellWithTableView:tableView];
    cell.icon.image = [[UIImage imageNamed:_leftImages[indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.titleLab.text = _leftItems[indexPath.row];
    cell.detailLab.text = _leftDetails[indexPath.row];
    
    //消息提示角标
    if (indexPath.row==0||indexPath.row==2||indexPath.row==4) {
        cell.badgeBtn.badgeValue = @"1234";
    }
    
    if (indexPath.row == _leftItems.count-1) {
        cell.separator.hidden =YES;
    } else {
        cell.separator.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self leftSliderHideAnimation];
    
    // 侧边栏切换, 直接显示根视图 而不是之前push到的页面
    if (_selectViewControllerType == SelectViewControllerTypeRoot) {
        [self lastNavPushToRootViewController];
    }
    
    self.selectedIndex = indexPath.row;
    
    if (selectCellIndex != indexPath.row) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:selectCellIndex inSection:0];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
        cell.selected = NO;
        selectCellIndex = indexPath.row;
    }
}

- (void)lastNavPushToRootViewController {
    UINavigationController *nav = self.viewControllers[self.selectedIndex];
    
    NSMutableArray *controllers = nav.viewControllers.mutableCopy;
    [controllers removeObjectsInRange:NSMakeRange(1, controllers.count-1)];
    nav.viewControllers = controllers;
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
        if (self.view.frame.origin.x == HideFrame.origin.x) {
            currentState = left;
        } else {
            currentState = rigit;
        }
    }
    if (panGes.state == UIGestureRecognizerStateChanged) {//监听手指移动
        transX = [panGes translationInView:panGes.view].x;//获取手指移动距离
        
        //跳过反向滑动
        if (self.view.frame.origin.x <= HideFrame.origin.x && transX<0) {
            self.view.frame = HideFrame;
            self.leftView.frame = LeftHideFrame;
            return;
        } else if (self.view.frame.origin.x >= ShowFrame.origin.x && transX>0) {
            self.view.frame = ShowFrame;
            self.leftView.frame = LeftShowFrame;
            return;
        }
        
        //View随手指移动
        if (currentState) {
            [UIView animateWithDuration:0.1 animations:^{
                CGRect frame = HideFrame;
                frame.origin.x = HideFrame.origin.x + transX;
                self.view.frame = frame;
                
                CGRect leftFrame = LeftHideFrame;
                leftFrame.origin.x = LeftHideFrame.origin.x + transX/2;
                self.leftView.frame = leftFrame;
            }];
        } else {
            [UIView animateWithDuration:0.1 animations:^{
                CGRect frame = ShowFrame;
                frame.origin.x = ShowFrame.origin.x + transX;
                self.view.frame = frame;
                
                CGRect leftFrame = LeftShowFrame;
                leftFrame.origin.x = LeftShowFrame.origin.x + transX/2;
                self.leftView.frame = leftFrame;
            }];
        }
    }
    //手指离开屏幕
    if (panGes.state == UIGestureRecognizerStateEnded) {
        if (transX>0) {
            if (self.view.frame.origin.x>=Boundary) {
                [UIView animateWithDuration:.3 animations:^{
                    self.view.frame = ShowFrame;
                    self.leftView.frame = LeftShowFrame;
                }];
            } else if (self.view.frame.origin.x<=Boundary) {
                [UIView animateWithDuration:.3 animations:^{
                    self.view.frame = HideFrame;
                    self.leftView.frame = LeftHideFrame;
                }];
            }
        } else if (transX<0) {
            if (self.view.frame.origin.x>=LeftShowFrame.size.width - Boundary) {
                [UIView animateWithDuration:.3 animations:^{
                    self.view.frame = ShowFrame;
                    self.leftView.frame = LeftShowFrame;
                }];
            } else if (self.view.frame.origin.x<=LeftShowFrame.size.width - Boundary) {
                [UIView animateWithDuration:.3 animations:^{
                    self.view.frame = HideFrame;
                    self.leftView.frame = LeftHideFrame;
                }];
            }
        }
    }
}

// 显示侧边栏
- (void)leftSliderShowAnimation {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = ShowFrame;
        self.leftView.frame = LeftShowFrame;
    }];
}

// 隐藏侧边栏
- (void)leftSliderHideAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = HideFrame;
        self.leftView.frame = LeftHideFrame;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
