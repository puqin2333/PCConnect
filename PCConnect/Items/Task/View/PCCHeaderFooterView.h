//
//  PCCHeaderFooterView.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/11.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HerderStyle) {
    HerderStyleNone,
    HerderStyleTotal
};

@protocol FoldSectionHeaderViewDelegate <NSObject>

- (void)foldHeaderInSection:(NSInteger)SectionHeader;

@end

@interface PCCHeaderFooterView : UITableViewHeaderFooterView

@property(nonatomic, assign) BOOL fold; // 是否折叠
@property(nonatomic, assign) NSInteger section; //选中的section
@property(nonatomic, weak) id<FoldSectionHeaderViewDelegate> delegate;

- (void)setFoldSectionHeaderViewWithTitle:(NSString *)itemTitle type:(HerderStyle)type section:(NSInteger)section isFold:(BOOL)canFold;

@end
