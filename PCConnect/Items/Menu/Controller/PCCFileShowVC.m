//
//  PCCFileShowVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/21.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCFileShowVC.h"
#import "PCCFileCell.h"
#import "PCCFileMessageModel.h"
#import "PCCSocketFile.h"
#import "PCCCommandModel.h"
#import "PCCFileModel.h"
#import "PCCSocketCmd.h"
#import "PCCNoticeVC.h"

@interface PCCFileShowVC () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *fileListTableView;
@property(nonatomic, strong) PCCFileMessageModel *fileModel;
@end

@implementation PCCFileShowVC

// 懒加载
- (UITableView *)fileListTableView {
    if (!_fileListTableView) {
        UITableView *fileListTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidht - 10, kScreenHeight * 0.9) style: UITableViewStylePlain];
        fileListTableView.backgroundColor = [UIColor whiteColor];
        fileListTableView.delegate = self;
//        fileListTableView.dataSource = self;
        fileListTableView.rowHeight = kScreenHeight * 0.1;
        fileListTableView.showsVerticalScrollIndicator = NO;
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        fileListTableView.tableFooterView = view;
        self.fileListTableView = fileListTableView;
        [self.view addSubview:_fileListTableView];
    }
    return _fileListTableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.fileModel = [[PCCFileMessageModel alloc] init];
    
    self.navigationItem.title = @"文件目录";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];


    [self fileListTableView];
    
    
    [self.fileModel postFileData:self.describe];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTableViewDataSource:) name:@"FileListData" object:nil];
}

#pragma mark --通知的方法
- (void)loadTableViewDataSource:(NSNotification *)notification{
    

    self.fileModel.pathArray = notification.userInfo[@"path"];
    self.fileModel.fileNameArray = notification.userInfo[@"name"];
    self.fileModel.isFileArray = notification.userInfo[@"type"];
    
    _fileListTableView.dataSource = self;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_fileModel.isFileArray[indexPath.row]  isEqual: @1]) {
        PCCFileShowVC *fileListVC = [[PCCFileShowVC alloc] init];
        fileListVC.describe = self.fileModel.pathArray[indexPath.row];
        [self.navigationController pushViewController:fileListVC animated:NO];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了删除");
    }];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"下载" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSString *name = _fileModel.fileNameArray[indexPath.row];
        NSString *path = _fileModel.pathArray[indexPath.row];
        NSString *nameString = [name stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *pathString = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
        BOOL type;
        if ([_fileModel.isFileArray[indexPath.row]  isEqual: @1]) {
            type = true;
        } else {
            type = false;
        }
        PCCFileDescribeModel *fielDataModel = [[PCCFileDescribeModel alloc] initWithType:type name:nameString path:pathString];
        NSString *commandStr = [fielDataModel toJSONString];
        NSString *fileStr = [NSString stringWithFormat:@"%@_[%@]_%@",GETFILE,commandStr,END_FLAG];
        NSLog(@"fileStr-%@",fileStr);
        
        PCCNoticeVC *noticeVC = [[PCCNoticeVC alloc] init];
        noticeVC.fileString = fileStr;
        [self presentViewController:noticeVC animated:NO completion:^{
            noticeVC.fileString = fileStr;
        }];
    }];
    editAction.backgroundColor = [UIColor grayColor];
    return @[deleteAction, editAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    editingStyle = UITableViewCellEditingStyleDelete;
}



#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _fileModel.fileNameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PCCFileCell *cell = nil;
    if (!cell) {
        cell = [PCCFileCell cellWithTableView:tableView cellStyle:CellStylePCFile];
        if ([_fileModel.isFileArray[indexPath.row]  isEqual: @1]) {
            cell.fileView.image = [UIImage imageNamed:@"wenjian"];
        } else {
            cell.fileView.image = [UIImage imageNamed:@"txt"];
        }
        cell.fileLabel.text = _fileModel.fileNameArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.selectButton addTarget:self action:@selector(selectBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}


#pragma mark --Taeget-Action

- (void)selectBtn {
    
}

- (void)clickLeftBtn {
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"1111");
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
