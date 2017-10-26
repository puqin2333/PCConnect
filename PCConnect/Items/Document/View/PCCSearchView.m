//
//  PCCSearchView.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/11.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCSearchView.h"
#import <Masonry.h>

@implementation PCCSearchView

// 懒加载自定义UISearchBar

- (UISearchBar *)fileSearchbar {
    
    if (!_fileSearchbar) {
        UISearchBar *fileSearchbar = [[UISearchBar alloc] init];
        fileSearchbar.backgroundColor = [UIColor clearColor];
        fileSearchbar.showsCancelButton = NO;
        fileSearchbar.barTintColor = [UIColor colorWithRed:1.00f green:0.60f blue:0.00f alpha:1.00f];
        fileSearchbar.placeholder = @"搜索查询的内容";
        fileSearchbar.delegate = self;
        
        for (UIView *subView in fileSearchbar.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                    UITextField *textField = [subView.subviews objectAtIndex:0];
                    textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                    
                    
                    //设置默认文字颜色
                    UIColor *color = [UIColor grayColor];
                    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"搜索查询的内容"
                                                                                        attributes:@{NSForegroundColorAttributeName:color}]];
                    //修改默认的放大镜图片
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
                    imageView.backgroundColor = [UIColor clearColor];
                    imageView.image = [UIImage imageNamed:@"search_ misplaces"];
                    textField.leftView = imageView;
                }
            }
        }
 
        [self addSubview:fileSearchbar];
        
        [fileSearchbar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right).with.offset(-60);
            make.height.mas_equalTo(kScreenHeight * 0.08);
        }];
        
        self.fileSearchbar = fileSearchbar;
    }
    return _fileSearchbar;
    
}

- (UITableView *)historyTableView {
    if (!_historyTableView) {
        
        UITableView *historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, kScreenHeight * 0.08, kScreenWidht - 20, kScreenHeight * 0.25)];
        historyTableView.backgroundColor = [UIColor whiteColor];
        historyTableView.delegate = self;
        historyTableView.dataSource = self;
        historyTableView.showsVerticalScrollIndicator = NO;
        historyTableView.scrollEnabled = NO;
        
        self.historyTableView = historyTableView;
        [self addSubview:self.historyTableView];
        [historyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_fileSearchbar.mas_bottom);
            make.left.equalTo(self.mas_left).with.offset(10);
            make.right.equalTo(self.mas_right).with.offset(-10);;
            make.height.mas_equalTo(kScreenHeight * 0.27);
        }];
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidht -20, kScreenHeight * 0.06)];
        UILabel *label = [[UILabel alloc] initWithFrame:headView.frame];
        label.text = @"历史记录";
        label.textColor = [UIColor lightGrayColor];
        label.backgroundColor = [UIColor whiteColor];
        [headView addSubview:label];
        
        historyTableView.rowHeight = kScreenHeight * 0.05;
        self.historyTableView.tableHeaderView = headView;
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        self.historyTableView.tableFooterView = view;
        
    }
    return _historyTableView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self fileSearchbar];
    
    _cancleBtn = [[UIButton alloc] init];
    _cancleBtn.backgroundColor = [UIColor clearColor];
    _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_cancleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [self addSubview:_cancleBtn];
    
    [_cancleBtn addTarget:self action:@selector(cancleBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_fileSearchbar.mas_centerY);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(_fileSearchbar.mas_right).with.offset(10);
    }];
    
    [self historyTableView];
}



- (void)cancleBtnTouched{
    
    [_fileSearchbar resignFirstResponder];
}

#pragma mark --UITableViewDelegate
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    UIView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
//    if (!headerView) {
//        headerView = [[UIView alloc] init];
//    }
//
//
//    return headerView;
//}


#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    }
//    cell.textLabel.text = [_listArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark --searchBar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    // do sth about get search result
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    // when we start to write sth, the record should display to us
    
}



@end
