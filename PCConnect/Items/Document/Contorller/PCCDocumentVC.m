//
//  PCCDocumentVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/29.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCDocumentVC.h"
#import "PCCSearchView.h"
#import "PCCCollectionView.h"

@interface PCCDocumentVC ()

@property(nonatomic, strong) PCCSearchView *searchView;
@property(nonatomic, strong) PCCCollectionView *collectionView;

@end

@implementation PCCDocumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];

}

- (void)setUI {
    self.searchView = [[PCCSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidht, kScreenHeight * 0.35)];
    [self.view addSubview:_searchView];
    
    self.collectionView = [[PCCCollectionView alloc] initWithFrame:CGRectMake(0, kScreenHeight * 0.36, kScreenWidht, kScreenHeight * 0.4)];
    [self.view addSubview:_collectionView];
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
