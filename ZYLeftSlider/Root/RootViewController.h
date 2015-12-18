//
//  RootViewController.h
//  Lizard
//
//  Created by Daniel on 15/11/25.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController

@property(nonatomic,strong)NSArray *controllers;//控制器数组
@property(nonatomic,strong)NSArray *leftItems;  //标题数组
@property(nonatomic,strong)NSArray *leftDetails;  //副标题
@property(nonatomic,strong)NSArray *leftImages;  //图标数组

@end
