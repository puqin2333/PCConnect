//
//  PCCUploadVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/11.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCUploadVC.h"
#import "PCCHeaderFooterView.h"
#import "PCCFileCell.h"

@interface PCCUploadVC ()<UITableViewDelegate, UITableViewDataSource,FoldSectionHeaderViewDelegate>

@property(nonatomic, strong) UITableView *uploadListTableView;
@property(nonatomic, strong) NSArray *listArray;
@property(nonatomic, strong) NSDictionary *foldInfoDic; //存储开关字典

@end

@implementation PCCUploadVC

- (UITableView *)uploadListTableView {
    if (!_uploadListTableView) {
        UITableView *uploadListTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, kScreenHeight * 0.1, kScreenWidht - 10, kScreenHeight * 0.7) style: UITableViewStylePlain];
        uploadListTableView.backgroundColor = [UIColor whiteColor];
        uploadListTableView.delegate = self;
        uploadListTableView.dataSource = self;
        uploadListTableView.rowHeight = kScreenHeight * 0.08;
        //        downloadListtableView.scrollEnabled = NO;
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        uploadListTableView.tableFooterView = view;
        self.uploadListTableView = uploadListTableView;
        [self.view addSubview:_uploadListTableView];
    }
    return _uploadListTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setArray];
    [self uploadListTableView];
    
}

- (void)setArray {
    self.listArray = @[@"已上传",@"取消上传",@"正在上传",@"dsadfs",@"dawra"];
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
    sectionView.backgroundColor = [UIColor colorWithRed:1.00f green:0.84f blue:0.62f alpha:1.00f];
    sectionView.layer.cornerRadius = 10.0f;
    if (!sectionView) {
        sectionView = [[PCCHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
        
    }
    if (section == 0) {
        [sectionView setFoldSectionHeaderViewWithTitle:@"上传完成" type: HerderStyleTotal section:0 isFold: YES];
    } else if (section == 1) {
        [sectionView setFoldSectionHeaderViewWithTitle:@"取消上传" type: HerderStyleTotal section:1 isFold: YES];
    }  else if (section == 2){
        [sectionView setFoldSectionHeaderViewWithTitle:@"正在上传" type: HerderStyleTotal section:2 isFold: YES];
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
        cell = [PCCFileCell cellWithTableView:tableView cellStyle:CellStylePCFile];
        cell.fileView.image = [UIImage imageNamed:@"wenjian"];
        cell.fileLabel.text = @"dwardqojfrjawo.jpg";
        cell.timeLabel.text = @"2017-10-13";
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
    [_uploadListTableView reloadSections:set withRowAnimation:UITableViewRowAnimationLeft];
    
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
