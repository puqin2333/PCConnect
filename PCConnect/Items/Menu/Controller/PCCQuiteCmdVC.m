//
//  PCCQuiteCmdVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/13.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCQuiteCmdVC.h"
#import <Masonry.h>

@interface PCCQuiteCmdVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *cmdListTableView;
@property(nonatomic, strong) NSArray *cmdListArray;

@end

@implementation PCCQuiteCmdVC

// 懒加载 UITableView
- (UITableView *)cmdListTableView {
    if (!_cmdListTableView) {
        UITableView *cmdListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        cmdListTableView.backgroundColor = [UIColor whiteColor];
        cmdListTableView.delegate = self;
        cmdListTableView.dataSource = self;
        cmdListTableView.rowHeight = kScreenHeight * 0.06;
        cmdListTableView.scrollEnabled = YES;
        
        self.cmdListTableView = cmdListTableView;
        [self.view addSubview:_cmdListTableView];
        
        [_cmdListTableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.view.mas_left).with.offset(5 * kScreenRatio);
            make.right.equalTo(self.view.mas_right).with.offset(- 5 * kScreenRatio);
            make.top.equalTo(self.view.mas_top);
            //make.bottom.equalTo(self.tabBarController.tabBar.mas_top).with.offset(2);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        
        
    }
    return _cmdListTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cmdListArray = @[@"任务管理器",@"写字板",@"画图",@"视频播放器",@"记事本",@"讲述人",@"资源管理器",@"注册表",@"计算器",@"SQL SERVER",@"垃圾整理",@"屏幕键盘",@"ODBC数据源管理器",@"注销命令",@"共享文件夹管理器",@"辅助工具管理器"];
    [self cmdListTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cmdListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:  UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        UISwitch *switchView = [[UISwitch alloc] init];
        switchView.on = NO;
        [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview: switchView];
        [switchView mas_makeConstraints:^(MASConstraintMaker *make){
                make.right.equalTo(cell.contentView.mas_right).with.offset(-20);
                make.height.mas_equalTo(kScreenHeight *0.07);
                make.width.mas_equalTo(kScreenWidht *0.1);
                make.top.equalTo(cell.contentView.mas_top).with.offset(10);
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _cmdListArray[indexPath.row];
       
    }
    return cell;
}

#pragma mark-- action
- (void)switchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
    }else {
        NSLog(@"关");
    }
}


@end
