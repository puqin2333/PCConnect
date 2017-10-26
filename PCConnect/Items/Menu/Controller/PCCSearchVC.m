//
//  PCCSearchVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/13.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCSearchVC.h"
#import "PCCSearchView.h"
#import "PCCSocketCmd.h"
#import "PCCCommandModel.h"

@interface PCCSearchVC ()<UISearchBarDelegate>

@property(nonatomic, strong) PCCSearchView *searchView;

@end

@implementation PCCSearchVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"快捷搜索";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
   
    [self setUI];
}


- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.searchView = [[PCCSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidht, kScreenHeight * 0.9)];
    self.searchView.fileSearchbar.delegate = self;
    [self.view addSubview:_searchView];
}


- (void)clickLeftBtn {
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *describeStr = searchBar.text;
    NSString *describeString = [describeStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    PCCCommandModel *commandModel = [[PCCCommandModel alloc] initWithType:@"7" describe:describeString isback:false];
    NSString *commandStr = [commandModel toJSONString];
    NSString *cmdStr = [NSString stringWithFormat:@"%@_%@_%@",COMMAND,commandStr,END_FLAG];
    [[PCCSocketCmd shareInstance] sendCmd:cmdStr];
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
