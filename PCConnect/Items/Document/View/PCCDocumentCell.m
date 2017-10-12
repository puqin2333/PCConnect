//
//  PCCDocumentCell.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/12.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCDocumentCell.h"
#import <Masonry.h>

@implementation PCCDocumentCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
//        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setUI {
    
    self.imageView = [[UIImageView alloc] init];
//    self.imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(-kScreenHeight * 0.035);
        make.width.mas_equalTo(kScreenWidht * 0.18);
        make.height.mas_equalTo(kScreenWidht * 0.18);
    }];
    
    self.itemLabel = [[UILabel alloc] init];
//    self.itemLabel.backgroundColor = [UIColor blueColor];
    _itemLabel.font = [UIFont systemFontOfSize:14];
    _itemLabel.textColor = [UIColor grayColor];
    _itemLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_itemLabel];
    [_itemLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.imageView.mas_bottom).with.offset(2);
        make.width.mas_equalTo(kScreenWidht * 0.18);
        make.height.mas_equalTo(kScreenWidht * 0.07);
    }];
    
    self.totailLabel = [[UILabel alloc] init];
//    self.totailLabel.backgroundColor = [UIColor grayColor];
    _totailLabel.font = [UIFont systemFontOfSize:13];
    _totailLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_totailLabel];
    [_totailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(_itemLabel.mas_bottom).with.offset(-3);
        make.width.mas_equalTo(kScreenWidht * 0.18);
        make.height.mas_equalTo(kScreenWidht * 0.06);
    }];
}

@end
