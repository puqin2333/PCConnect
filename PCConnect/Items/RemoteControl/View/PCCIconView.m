//
//  PCCIconView.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/30.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCIconView.h"
#import <Masonry.h>

@interface PCCIconView ()

@property(nonatomic, strong) UIView *lineView;

@end
@implementation PCCIconView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUI];
        [self setConstraint];
    }
    return self;
}

- (void)setUI {
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = [UIColor grayColor];
    iconView.layer.masksToBounds = YES;
    iconView.layer.cornerRadius = kScreenWidht * 0.15;
   
    [self addSubview:iconView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"ArialHebrew" size:25];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = @"未连接";
    [self addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:0.20f];
    [self addSubview:lineView];
    
    
    self.iconImageView = iconView;
    self.titleLabel = titleLabel;
    self.lineView = lineView;
}

- (void)setConstraint {
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(kScreenHeight * 0.1);
        make.trailing.mas_equalTo(-kScreenWidht * 0.35);
        make.leading.mas_equalTo(kScreenWidht * 0.35);
        make.height.mas_equalTo(kScreenWidht * 0.3);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_bottom);
        make.trailing.mas_equalTo(-kScreenWidht * 0.1);
        make.leading.mas_equalTo(kScreenWidht * 0.1);
        make.height.mas_equalTo(kScreenWidht * 0.2);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.trailing.mas_equalTo(- 5 * kScreenRatio);
        make.leading.mas_equalTo(5 * kScreenRatio);
        make.bottom.equalTo(self.mas_bottom);
    }];

    
}

@end
