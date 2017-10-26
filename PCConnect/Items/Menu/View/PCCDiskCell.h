//
//  PCCDiskCell.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/18.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCConnect-Bridging-Header.h"
#import "PCConnect-Swift.h"


@interface PCCDiskCell : UITableViewCell

@property(nonatomic, strong) PieChartView *pieChartView;
@property(nonatomic, strong) NSString *drawCenterText;
@property(nonatomic, strong) NSArray *dataArray;


+ (instancetype)cellTableViewCell:(UITableView *)tableView cellItem:(NSString *)item diskSpace:(double)scale;
- (void)upDateChartData:(double)scale;

@end
