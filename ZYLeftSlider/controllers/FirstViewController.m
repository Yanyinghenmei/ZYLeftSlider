//
//  FirstViewController.m
//  ZYLeftSlider
//
//  Created by Daniel on 15/12/18.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "FirstViewController.h"
#import "NextViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"first";
    
    UILabel *lab = [[UILabel alloc] initWithFrame:self.view.bounds];
    lab.text = self.title;
    lab.font = [UIFont systemFontOfSize:38];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextController)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)nextController {
    [self.navigationController pushViewController:[NextViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
