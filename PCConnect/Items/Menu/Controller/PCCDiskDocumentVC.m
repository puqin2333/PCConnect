//
//  PCCDiskDocumentVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/13.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCDiskDocumentVC.h"
#import "PCConnect-Bridging-Header.h"
#import "PCConnect-Swift.h"
#import "PCCDiskCell.h"
#import "PCCDiskDataModel.h"
#import "PCCFileShowVC.h"
#import "PCCFileMessageModel.h"

@interface PCCDiskDocumentVC ()<UITableViewDelegate, UITableViewDataSource,ChartViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) PCCDiskDataModel *dataModel;

@end

@implementation PCCDiskDocumentVC

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidht - 10, kScreenHeight * 0.9) style: UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = kScreenWidht * 0.6;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.allowsSelection = YES;
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        tableView.tableFooterView = view;
        self.tableView = tableView;
        [self.view addSubview:_tableView];
    }
    return  _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataModel = [[PCCDiskDataModel alloc] init];
    
    
    self.navigationItem.title = @"磁盘管理";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTableViewDataSource:) name:@"diskData" object:nil];

 
}

// 通知
- (void)loadTableViewDataSource:(NSNotification *)notification{
    
    self.dataModel.diskPartitionArray = notification.userInfo[@"drive"];
    self.dataModel.diskSpaceArray = notification.userInfo[@"useInfo"];
    self.dataModel.diskArray = notification.userInfo[@"path"];
    
    [self tableView];
}


#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataModel.diskSpaceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PCCDiskCell *cell = nil;
    if (!cell) {
        cell = [PCCDiskCell cellTableViewCell:tableView cellItem:_dataModel.diskPartitionArray[indexPath.row] diskSpace:[_dataModel.diskSpaceArray[indexPath.row] doubleValue]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell.pieChartView.isDrawHoleEnabled == YES) {
            cell.pieChartView.drawCenterTextEnabled = YES;//是否显示中间文字
            
            //富文本
            
            NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:_dataModel.diskPartitionArray[indexPath.row]];
            [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                                        NSForegroundColorAttributeName: [UIColor orangeColor]}
                                range:NSMakeRange(0, centerText.length)];
            cell.pieChartView.centerAttributedText = centerText;
        }
        [cell upDateChartData:[_dataModel.diskSpaceArray[indexPath.row] doubleValue]];
    }
    return cell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PCCFileShowVC *fileListVC = [[PCCFileShowVC alloc] init];
    fileListVC.describe = _dataModel.diskArray[indexPath.row];
    [self.navigationController pushViewController:fileListVC animated:NO];
}

#pragma mark -- ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight {
    
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView {
    NSLog(@"chartValueNothingSelected");
}


#pragma mark -- Target_Action

- (void)clickLeftBtn {
    
    [self.navigationController popViewControllerAnimated:NO];
    
}


- (void)viewWillAppear:(BOOL)animated {
//    self.dataModel = [[PCCDiskDataModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
