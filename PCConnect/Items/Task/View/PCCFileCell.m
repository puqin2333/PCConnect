//
//  PCCFileCell.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/11.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCFileCell.h"
#import <Masonry.h>
#import "UILabel+WXYLabel.h"

@implementation PCCFileCell

+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(CellStyle)cellStyle {
    static NSString *identifier = @"fileCell";
    PCCFileCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PCCFileCell alloc] initWithStyle:UITableViewCellStyleDefault cellStyle:cellStyle reuseIdentifier:identifier];
    }
    return cell;
}

// 构造方法(在初始化对象的时候会调用)
- (id)initWithStyle:(UITableViewCellStyle)style  cellStyle:(CellStyle)cellStyle reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (cellStyle == CellStylePhoneFile) {
            [self setPhoneFileUI];
        } else {
            [self setPCFileUI];
        }
    }
    return self;
}

- (void)setPhoneFileUI {
    
    self.fileView = [[UIImageView alloc] init];
    [self.contentView addSubview:_fileView];
    
    self.fileLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_fileLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_timeLabel];
    
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectButton setImage:[UIImage imageNamed:@"选择1"] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateSelected];
    [self.contentView addSubview:_selectButton];
    
    [_fileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.and.height.mas_equalTo(kScreenHeight * 0.08);
    }];
    [_fileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_fileView.mas_right).with.offset(10);
        make.top.equalTo(_fileView.mas_top);
        make.width.mas_equalTo(kScreenWidht * 0.65);
        make.height.mas_equalTo(kScreenHeight * 0.04);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_fileView.mas_right).with.offset(10);
        make.top.equalTo(_fileLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(kScreenWidht * 0.5);
        make.height.mas_equalTo(kScreenHeight * 0.03);
    }];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.and.height.mas_equalTo(kScreenHeight * 0.03);
    }];
}

- (void)setPCFileUI {
    
    self.fileView = [[UIImageView alloc] init];
    [self.contentView addSubview:_fileView];
    
    self.fileLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_fileLabel];
    
//    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_selectButton setImage:[UIImage imageNamed:@"选择1"] forState:UIControlStateNormal];
//    [_selectButton setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateSelected];
//    [self.contentView addSubview:_selectButton];
    
    [_fileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.and.height.mas_equalTo(kScreenHeight * 0.06);
    }];
    
    [_fileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_fileView.mas_right).with.offset(10);
        make.top.equalTo(_fileView.mas_top);
        make.width.mas_equalTo(kScreenWidht * 0.65);
        make.height.mas_equalTo(kScreenHeight * 0.05);
    }];

//    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
//        make.centerY.equalTo(self.contentView.mas_centerY);
//        make.width.and.height.mas_equalTo(kScreenHeight * 0.03);
//    }];
}


@end
