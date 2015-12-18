//
//  RootViewController.m
//  Lizard
//
//  Created by Daniel on 15/11/25.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "RootViewController.h"

#import "ZYHeader.h"
#import "ZYNavigationController.h"
#import "LeftItemCell.h"
#import "IWBadgeButton.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *leftView;
@property(nonatomic,strong)IWBadgeButton *badgeBtn;  //消息数字角标

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navigationController.delegate = self;
    
    [self setControllers];
    
    //绘制侧边栏
    [self CreatLeftView];
    
    //侧边栏手势
    [(ZYNavigationController *)self.navigationController setLeftView:_leftView];
}

- (void)hideAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        _leftView.frame = HideFrame;
    }];
}

- (void)setControllers {
    FirstViewController *first = [FirstViewController new];
    SecondViewController *second = [SecondViewController new];
    ThirdViewController *third = [ThirdViewController new];
    FourthViewController *fourth = [FourthViewController new];
    self.controllers = @[first, second, third, fourth];
    self.leftItems = @[@"First Controller",@"Second Controller",@"Thrid Controller",@"Fourth Controller"];
    self.leftDetails = @[@"第一页",@"第二页",@"第三页",@"第四页"];
    self.leftImages = @[@"image1.png",@"image2.png",@"image3.png",@"image4.png"];
    
    //初始控制器
    [self.navigationController pushViewController:_controllers[0] animated:NO];
}

#pragma mark -- leftView and delegate
- (void)CreatLeftView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 180)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(0, 32, 50, 20)];
    left.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [left setImage:[UIImage imageNamed:@"0-1"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(hideAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(DeviceWidth-15-30, 27, 30, 30)];
    [right setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [headerView addSubview:left];
    [headerView addSubview:right];
    
    _badgeBtn = [[IWBadgeButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(right.frame)-18, 20, 0, 0)];
    _badgeBtn.badgeValue = @"1234";
    [headerView addSubview:_badgeBtn];
    
    //180+60*4 = 420  为了尽可能地适配更多屏幕 需要计算
    CGFloat footHeight = DeviceHeight-420;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, footHeight)];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, footHeight-90, DeviceWidth, 30)];
    lab.font = [UIFont systemFontOfSize:10];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = HEXCOLORV(0x999999);
    lab.text = @"ZYLeftSlider 1.0\n–– Yanyinghenmei ––";
    lab.numberOfLines = 0;
    [footerView addSubview:lab];
    
    _leftView = [[UITableView alloc] initWithFrame:HideFrame style:UITableViewStylePlain];
    _leftView.scrollEnabled = NO;
    _leftView.backgroundColor = [UIColor whiteColor];
    _leftView.delegate = self;
    _leftView.dataSource = self;
    _leftView.alpha = 0.95;
    _leftView.tag = 142857;
    _leftView.tableHeaderView = headerView;
    _leftView.tableFooterView = footerView;
    _leftView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_leftView reloadData];
    [[[UIApplication sharedApplication].delegate window] addSubview:_leftView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _controllers.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftItemCell *cell = [LeftItemCell cellWithTableView:tableView];
    cell.icon.image = [[UIImage imageNamed:_leftImages[indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.titleLab.text = _leftItems[indexPath.row];
    cell.detailLab.text = _leftDetails[indexPath.row];
    
    cell.badgeBtn.badgeValue = @"1234";
    
    if (indexPath.row == _leftItems.count-1) {
        cell.separator.hidden =YES;
    } else {
        cell.separator.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideAnimation];
    //不要重复跳转同一个页面
    if (self.navigationController.visibleViewController != _controllers[indexPath.row]) {
        NSMutableArray *pushControllers = self.navigationController.viewControllers.mutableCopy;
        [pushControllers removeObjectsInRange:NSMakeRange(1, pushControllers.count-1)];
        self.navigationController.viewControllers = pushControllers;
        [self.navigationController pushViewController:_controllers[indexPath.row] animated:NO];
    }
}

//禁用右滑返回. navigation delegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (navigationController.viewControllers.count==2) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
