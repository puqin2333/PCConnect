//
//  PCCTaskVC.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/29.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCTaskVC.h"
#import "PCCDownloadVC.h"
#import "PCCUploadVC.h"
#import "LDSegmentViewController.h"

@interface PCCTaskVC ()

@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PCCTaskVC

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:0];
    PCCDownloadVC *download = [[PCCDownloadVC alloc] init];
    PCCUploadVC *upload = [[PCCUploadVC alloc] init];

    NSArray *controllerArray = @[download,upload];
    NSArray *titleArray = @[@"下载任务",@"上传任务"];
    for (int i = 0; i < 2; i++) {
        [self.dataSource addObject:controllerArray[i]];
        [titles addObject:titleArray[i]];
    }

    CGRect frame =self.view.frame;

    LDSegmentViewController *segmentVC = [[LDSegmentViewController alloc] init];
    segmentVC.viewControllers = self.dataSource;
    segmentVC.segmentTitles = titles;
    segmentVC.view.frame = frame;
    segmentVC.selectedIndex = 0;
    [self addChildViewController:segmentVC];
    [self.view addSubview:segmentVC.view];
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
