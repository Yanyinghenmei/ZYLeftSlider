//
//  LeftItemCell.h
//  Lizard
//
//  Created by Daniel on 15/11/27.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWBadgeButton;
@interface LeftItemCell : UITableViewCell

@property(nonatomic,strong)UIImageView *icon;//头像
@property(nonatomic,strong)UILabel *titleLab;//标题
@property(nonatomic,strong)UILabel *detailLab;//副标题
@property(nonatomic,strong)IWBadgeButton *badgeBtn;//数字
@property(nonatomic,strong)UIView *separator;//线

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
