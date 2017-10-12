//
//  PCCDownloadVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/11.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCDownloadVC.h"
#import "PCCHeaderFooterView.h"
#import "PCCFileCell.h"

@interface PCCDownloadVC ()<UITableViewDelegate, UITableViewDataSource,FoldSectionHeaderViewDelegate>

@property(nonatomic, strong) UITableView *downloadListTableView;
@property(nonatomic, strong) NSArray *listArray;
@property(nonatomic, strong) NSDictionary *foldInfoDic; //存储开关字典

@end

@implementation PCCDownloadVC

- (UITableView *)downloadListTableView {
    if (!_downloadListTableView) {
        UITableView *downloadListtableView = [[UITableView alloc] initWithFrame:CGRectMake(5, kScreenHeight * 0.1, kScreenWidht - 10, kScreenHeight * 0.7) style: UITableViewStylePlain];
        downloadListtableView.backgroundColor = [UIColor whiteColor];
        downloadListtableView.delegate = self;
        downloadListtableView.dataSource = self;
        downloadListtableView.rowHeight = kScreenHeight * 0.1;
        downloadListtableView.showsVerticalScrollIndicator = NO;
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        downloadListtableView.tableFooterView = view;
        self.downloadListTableView = downloadListtableView;
        [self.view addSubview:_downloadListTableView];
    }
    return _downloadListTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setArray];
    [self downloadListTableView];
    
}

- (void)setArray {
    self.listArray = @[@"已下载",@"取消下载",@"正在下载",@"dsadfs",@"dawra"];
    self.foldInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                   @"0":@"0",
                                                                   @"1":@"0",
                                                                   @"2":@"0",
                                                                   }];
}

#pragma mark -- UITableViewDelegate
// 自定义 section
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    PCCHeaderFooterView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!sectionView) {
        sectionView = [[PCCHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
        
    }
    if (section == 0) {
        [sectionView setFoldSectionHeaderViewWithTitle:@"下载完成" type: HerderStyleTotal section:0 isFold: YES];
    } else if (section == 1) {
        [sectionView setFoldSectionHeaderViewWithTitle:@"取消下载" type: HerderStyleTotal section:1 isFold: YES];
    }  else if (section == 2){
        [sectionView setFoldSectionHeaderViewWithTitle:@"正在下载" type: HerderStyleTotal section:2 isFold: YES];
    }
    sectionView.delegate = self;
    NSString *key = [NSString stringWithFormat:@"%d",(int)section];
    BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
    sectionView.fold = folded;
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScreenHeight * 0.08;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}



#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    
    if (section == 0) {
        return folded?_listArray.count:0;
    } else if (section == 1) {
        return folded?_listArray.count:0;
    } else {
        return folded?_listArray.count:0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PCCFileCell *cell = nil;
    if (!cell) {
        cell = [PCCFileCell cellWithTableView:tableView cellStyle:CellStylePhoneFile];
        cell.fileView.image = [UIImage imageNamed:@"wenjian"];
        cell.fileLabel.text = @"dwardqojfrjawo.jpg";
        cell.timeLabel.text = @"2017-10-13";
        [cell.selectButton addTarget:self action:@selector(selectBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


#pragma mark --FoldSectionHeaderViewDelegate
- (void)foldHeaderInSection:(NSInteger)SectionHeader {
    
    NSString *key = [NSString stringWithFormat:@"%d",(int)SectionHeader];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    NSString *fold = folded ? @"0" : @"1";
    [_foldInfoDic setValue:fold forKey:key];
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:SectionHeader];
    [_downloadListTableView reloadSections:set withRowAnimation:UITableViewRowAnimationLeft];
    
}

#pragma mark --action

- (void)selectBtn {
    
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
