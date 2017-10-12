//
//  PCCSettingVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/29.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCSettingVC.h"
#import <Masonry.h>
#import "PCCQuestionVC.h"
#import "PCCFeedbackVC.h"
#import "PCCAboutVC.h"

@interface PCCSettingVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *setListTableView;
@property(nonatomic, strong) NSArray *noticArray;
@property(nonatomic, strong) NSArray *networkArray;
@property(nonatomic, strong) NSArray *aboutArray;

@end

@implementation PCCSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setItemName];
    [self setListTableView];
    
    
}

// 懒加载 UITableView
- (UITableView *)setListTableView {
    if (!_setListTableView) {
        UITableView *setListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        setListTableView.backgroundColor = [UIColor whiteColor];
        setListTableView.delegate = self;
        setListTableView.dataSource = self;
        setListTableView.rowHeight = kScreenHeight * 0.08;
        setListTableView.scrollEnabled = NO;

        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        setListTableView.tableFooterView = view;
        self.setListTableView = setListTableView;
        
        [self.view addSubview:_setListTableView];
        
        [_setListTableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.view.mas_left).with.offset(5 * kScreenRatio);
            make.right.equalTo(self.view.mas_right).with.offset(- 5 * kScreenRatio);
            make.top.equalTo(self.view.mas_top);
            //make.bottom.equalTo(self.tabBarController.tabBar.mas_top).with.offset(2);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        
        
    }
    return _setListTableView;
}

- (void)setItemName {
    if (!_networkArray) {
        self.networkArray = @[@"2G/3G/4G 网络环境下下载",@"2G/3G/4G 网络下显示图片"];
    }
    if (!_noticArray) {
        self.noticArray = @[@"下载完成时提示",@"清除缓存"];
    }
    if (!_aboutArray) {
        self.aboutArray = @[@"常见问题",@"问题反馈",@"关于我们"];
    }
    
}

#pragma mark -- UITableViewDelegate
// 自定义 section
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidht, kScreenRatio * 30)];
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(10 , 5 * kScreenRatio, sectionView.frame.size.width, sectionView.frame.size.height - 5 * kScreenRatio)];
    [lableTitle setBackgroundColor:[UIColor whiteColor]];
    lableTitle.font = [UIFont fontWithName:@"" size:15];
    lableTitle.textColor = [UIColor grayColor];
    lableTitle.textAlignment = NSTextAlignmentLeft;
    if (section == 0) {
        lableTitle.text = @"网络";
    } else if (section == 1) {
        lableTitle.text = @"通知";
    } else {
        lableTitle.text = @"关于";
    }
    [sectionView addSubview:lableTitle];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:{
                self.hidesBottomBarWhenPushed = YES;
                PCCQuestionVC *questionVC = [[PCCQuestionVC alloc] init];
                [self.navigationController pushViewController:questionVC animated:NO];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 1:{
                self.hidesBottomBarWhenPushed = YES;
                PCCFeedbackVC *feedbackVC = [[PCCFeedbackVC alloc] init];
                [self.navigationController pushViewController:feedbackVC animated:NO];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 2:{
                self.hidesBottomBarWhenPushed = YES;
                PCCAboutVC *feedbackVC = [[PCCAboutVC alloc] init];
                [self.navigationController pushViewController:feedbackVC animated:NO];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            default:
                break;
        }
    }
}



#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 2;
    } else {
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
         cell = [[UITableViewCell alloc] initWithStyle:  UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if (indexPath.section == 0 ) {
            UISwitch *switchView = [[UISwitch alloc] init];
            [cell.contentView addSubview: switchView];
            [switchView mas_makeConstraints:^(MASConstraintMaker *make){
                make.right.equalTo(cell.contentView.mas_right).with.offset(-20);
                make.height.mas_equalTo(kScreenHeight *0.07);
                make.width.mas_equalTo(kScreenWidht *0.1);
                make.top.equalTo(cell.contentView.mas_top).with.offset(10);
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = _networkArray[indexPath.row];
        } else if (indexPath.section == 1) {
            UISwitch *switchView = [[UISwitch alloc] init];
            [cell.contentView addSubview: switchView];
            [switchView mas_makeConstraints:^(MASConstraintMaker *make){
                make.right.equalTo(cell.contentView.mas_right).with.offset(-20 * kScreenRatio);
                make.height.mas_equalTo(kScreenHeight *0.07);
                make.width.mas_equalTo(kScreenWidht *0.1);
                make.top.equalTo(cell.contentView.mas_top).with.offset(15 * kScreenRatio);
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = _noticArray[indexPath.row];
        }
        else {
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = _aboutArray[indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
