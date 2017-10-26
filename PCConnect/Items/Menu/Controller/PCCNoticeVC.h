//
//  PCCNoticeVC.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/25.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PCCNoticeVC : UIViewController

@property(nonatomic, strong) NSString *fileString;
@property (nonatomic, strong) NSMutableData             *muData;
@property (nonatomic, strong) UIWebView                 *webView;
@property (nonatomic, strong) UILabel                   *titleLabel;
@property (nonatomic, strong) UIProgressView            *progress;

@end
