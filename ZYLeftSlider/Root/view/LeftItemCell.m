//
//  LeftItemCell.m
//  Lizard
//
//  Created by Daniel on 15/11/27.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "LeftItemCell.h"
#import "IWBadgeButton.h"
#import "ZYHeader.h"

@implementation LeftItemCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _icon.tintColor = SelectedColor;
        _titleLab.textColor = SelectedColor;
        _detailLab.textColor = SelectedColor;
        _badgeBtn.badgeValue = nil;
    } else {
        _icon.tintColor = NormalColor;
        _titleLab.textColor = NormalColor;
        _detailLab.textColor = NormalColor;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(40, 15, 30, 30)];
        _icon.layer.cornerRadius = 15;
        _icon.layer.masksToBounds = YES;
        [self.contentView addSubview:_icon];
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_icon.frame)+15, 10, DeviceWidth-90, 20)];
        _titleLab.font = [UIFont systemFontOfSize:17];
        _titleLab.textColor = HEXCOLORV(0x666666);
        [self.contentView addSubview:_titleLab];
        
        _detailLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_icon.frame)+15, CGRectGetMaxY(_titleLab.frame), DeviceWidth-90, 20)];
        _detailLab.font = [UIFont systemFontOfSize:13];
        _detailLab.textColor = HEXCOLORV(0x999999);
        [self.contentView addSubview:_detailLab];
        
        _separator = [[UIView alloc] initWithFrame:CGRectMake(40, 60-0.5, DeviceWidth-80, 0.5)];
        _separator.backgroundColor = HEXCOLORV(0xcccccc);
        [self.contentView addSubview:_separator];
        
        // 添加一个提醒数字按钮
        _badgeBtn = [[IWBadgeButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_icon.frame)-15, 5, 0, 0)];
        [self.contentView addSubview:_badgeBtn];
        [_badgeBtn addObserver:self forKeyPath:@"titleLabel.text" options:0 context:nil];
        
        self.selectionStyle = 0;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGFloat x = CGRectGetMaxX(_icon.frame)-10;
    CGFloat y = 5;
    CGRect frame = _badgeBtn.frame;
    frame.origin.x = x;
    frame.origin.y = y;
    _badgeBtn.frame = frame;
}

- (void)dealloc {
    [_badgeBtn removeObserver:self forKeyPath:@"titleLabel.text"];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ident = @"LeftItemCell";
    LeftItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[LeftItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    return cell;
}

@end
