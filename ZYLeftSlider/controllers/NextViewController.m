//
//  NextViewController.m
//  ZYLeftSlider
//
//  Created by Daniel on 16/2/23.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Next";
    self.view.backgroundColor = [UIColor orangeColor];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:self.view.bounds];
    lab.text = self.title;
    lab.font = [UIFont systemFontOfSize:38];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
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
