//
//  PCCHeaderFooterView.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/11.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCHeaderFooterView.h"

@implementation PCCHeaderFooterView {
    BOOL _created; // 是否创建
    UILabel *_titleLabel; // 标题
    UIImageView *_imageView; // 提示图案
    UIButton *_cannalbtn; // 收起按钮
    BOOL   _canFold; // 是否可展开
}

- (void)setFoldSectionHeaderViewWithTitle:(NSString *)itemTitle type:(HerderStyle)type section:(NSInteger)section isFold:(BOOL)canFold {
    if (!_created) {
        [self setUI];
    }
    _titleLabel.text = itemTitle;
//    if (type == HerderStyleNone) {
        _titleLabel.textAlignment = NSTextAlignmentLeft;
//    } else {
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//    }
    _section = section;
    _canFold = canFold;
    if (canFold) {
        _imageView.hidden = NO;
    } else {
        _imageView.hidden = YES;
    }
}

// 设置 UI
- (void)setUI {
    
    _created = YES;
    
    _cannalbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cannalbtn.frame = CGRectMake(0, 0, kScreenWidht, kScreenHeight * 0.078);
    _cannalbtn.backgroundColor = [UIColor colorWithRed:0.00f green:0.76f blue:0.71f alpha:1.00f];
    [_cannalbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_cannalbtn];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidht * 0.05, kScreenHeight * 0.01, kScreenWidht* 0.3 , kScreenHeight * 0.06)];
    //    _titleLabel.backgroundColor = [UIColor colorWithRed:1.00f green:0.84f blue:0.62f alpha:0.00f];
    _titleLabel.font = [UIFont systemFontOfSize:20.0];
    _titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview: _titleLabel];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidht * 0.85, kScreenHeight * 0.03, kScreenHeight * 0.03, kScreenHeight * 0.03)];
    [self.contentView addSubview:_imageView];
    
}

- (void)setFold:(BOOL)fold {
    _fold = fold;
    if (fold) {
        _imageView.image = [UIImage imageNamed:@"down"];
    } else {
        _imageView.image = [UIImage imageNamed:@"up"];
    }
}

#pragma mark --buttonAction
- (void)btnClick:(UIButton *)btn {
    if (_canFold) {
        if ([self.delegate respondsToSelector:@selector(foldHeaderInSection:)]) {
            [self.delegate foldHeaderInSection:_section];
        }
    }
}



@end
