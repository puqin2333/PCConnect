//
//  PCCItemButton.m
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/9/29.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import "PCCItemButton.h"

@implementation PCCItemButton

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
//    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat imageW = self.bounds.size.width * 0.8;
    CGFloat imageH = self.bounds.size.width * 0.8;
    CGFloat imageX = self.bounds.size.width * 0.1;
    CGFloat imageY = 0;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat titleW = imageW;
    CGFloat titleH = self.bounds.size.height - imageH;
    CGFloat titleX = imageX;
    CGFloat titleY = imageH + 5;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

@end
