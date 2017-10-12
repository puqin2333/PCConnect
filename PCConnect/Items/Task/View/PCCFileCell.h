//
//  PCCFileCell.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/11.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellStyle) {
    CellStylePhoneFile,
    CellStylePCFile
};

@interface PCCFileCell : UITableViewCell

@property(nonatomic, strong) UIButton *selectButton;
@property(nonatomic, strong) UILabel *fileLabel;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UIImageView *fileView;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(CellStyle)cellStyle;

@end
