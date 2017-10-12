//
//  PCCCollectionView.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/12.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCCollectionView.h"
#import "PCCDocumentCell.h"

@interface PCCCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) NSArray *imageArray;
@property(nonatomic, strong) NSArray *itemArray;

@end


@implementation PCCCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArray = @[@"视频",@"文档",@"图片",@"音乐",@"压缩包",@"安装包"];
        self.itemArray = @[@"视频",@"文档",@"图片",@"音乐",@"压缩包",@"安装包"];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidht, kScreenHeight * 0.06)];
    headView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidht * 0.25, kScreenHeight * 0.06)];
    titleLabel.backgroundColor = [UIColor colorWithRed:0.00f green:0.76f blue:0.71f alpha:1.00f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"文件分类";
    [headView addSubview:titleLabel];

    
    [self addSubview:self.documentView];
    //注册collectionViewCell: WXYLessonCollectionCell 是我自定义的 cell
    [self.documentView registerClass:[PCCDocumentCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark -- UICollectionView
// 懒加载
- (UICollectionView *)documentView {
    if (_documentView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumLineSpacing = 15.0f; // 设置最小行间距
        layout.minimumInteritemSpacing = 20.0f; // 设置垂直间距
        
        UICollectionView *documentView = [[UICollectionView alloc] initWithFrame:CGRectMake(kScreenWidht * 0.05, kScreenHeight * 0.07, CGRectGetWidth(self.frame) - kScreenWidht * 0.1, CGRectGetHeight(self.frame) - 20) collectionViewLayout:layout];
        documentView.backgroundColor = [UIColor whiteColor];
        documentView.delegate = self;
        documentView.dataSource = self;
        self.documentView = documentView;
    }
    return _documentView;
}

#pragma mark --UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    PCCDocumentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor lightGrayColor];
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.itemLabel.text = _itemArray[indexPath.row];
    cell.totailLabel.text = @"0";
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((CGRectGetWidth(collectionView.frame) - 45)/3 ,(CGRectGetHeight(collectionView.frame) - 20)/2);
}


#pragma mark --UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
}

@end
