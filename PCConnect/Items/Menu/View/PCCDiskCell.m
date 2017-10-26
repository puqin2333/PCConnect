//
//  PCCDiskCell.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/18.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCDiskCell.h"
#import <Masonry.h>


@implementation PCCDiskCell

+ (instancetype)cellTableViewCell:(UITableView *)tableView cellItem:(NSString *)item diskSpace:(double)scale{
    static NSString * identifier = @"diskCell";
    PCCDiskCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[PCCDiskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier cellItem:item];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellItem:(NSString *)item {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.drawCenterText = item;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    PieChartView* pieChartView = [[PieChartView alloc] init];
    pieChartView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:pieChartView];
    [pieChartView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidht * 0.8, kScreenWidht * 0.6));
        make.center.mas_equalTo(self.contentView);
    }];
    
    [pieChartView setExtraOffsetsWithLeft:10 top:0 right:10 bottom:0];//饼状图距离边缘的间隙
    pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
    pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
    pieChartView.drawSliceTextEnabled = YES;//是否显示区块文本
    
    pieChartView.drawHoleEnabled = YES;//饼状图是否是空心
    pieChartView.holeRadiusPercent = 0.5;//空心半径占比
    pieChartView.holeColor = [UIColor clearColor];//空心颜色
    pieChartView.transparentCircleRadiusPercent = 0.52;//半透明空心半径占比
    pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
    
//    if (pieChartView.isDrawHoleEnabled == YES) {
//        pieChartView.drawCenterTextEnabled = YES;//是否显示中间文字
//
//        //富文本
//        
//        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:self.drawCenterText];
//        [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
//                                    NSForegroundColorAttributeName: [UIColor orangeColor]}
//                            range:NSMakeRange(0, centerText.length)];
//        pieChartView.centerAttributedText = centerText;
//    }
    
    pieChartView.descriptionText = @"示例图";
    pieChartView.descriptionFont = [UIFont systemFontOfSize:10];
    pieChartView.descriptionTextColor = [UIColor grayColor];
    
    pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    pieChartView.legend.formToTextSpace = 5;//文本间隔
    pieChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
    pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
    pieChartView.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
    pieChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
    pieChartView.legend.formSize = 12;//图示大小

    pieChartView.entryLabelColor = [UIColor whiteColor];
    pieChartView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    self.pieChartView = pieChartView;
    
    // 取消 pieChartView 的触摸效果
    self.pieChartView.userInteractionEnabled  = NO;
    
}

- (void)upDateChartData:(double)scale{

    [self setData:scale];
}

- (void)setData:(double)scale {
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    

    [values addObject:[[PieChartDataEntry alloc] initWithValue:scale label:@"当前已用" icon: nil]];
    [values addObject:[[PieChartDataEntry alloc] initWithValue:100 - scale label:@"未使用" icon: nil]];
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@""];
    dataSet.drawIconsEnabled = NO;
    
    dataSet.sliceSpace = 2.0;
    dataSet.iconsOffset = CGPointMake(0, 40);
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
//    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
//    [colors addObjectsFromArray:ChartColorTemplates.joyful];
//    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
//    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    _pieChartView.data = data;
    [_pieChartView highlightValue:nil];
    
}


@end
