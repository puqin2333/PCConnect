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

@interface PCCDiskDocumentVC ()<UITableViewDelegate, UITableViewDataSource>

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
    
    self.navigationItem.title = @"磁盘管理";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    self.dataModel = [[PCCDiskDataModel alloc] init];
    
    [self tableView];
}



#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataModel.diskSpaceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PCCDiskCell *cell = nil;
    if (!cell) {
        cell = [PCCDiskCell cellTableViewCell:tableView cellItem:_dataModel.diskPartitionArray[indexPath.row]];
        cell.drawCenterText = @"新加卷1";
        double data =  [_dataModel.diskSpaceArray[indexPath.row] doubleValue];
        [cell upDateChartData:data];
    }
    return cell;
}



- (void)clickLeftBtn {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
