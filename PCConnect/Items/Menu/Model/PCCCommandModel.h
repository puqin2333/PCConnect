//
//  PCCCommandModel.h
//  PCConnect
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/10/20.
//  Copyright © 2017年 满脸胡茬的怪蜀黍. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PCCCommandModel : JSONModel

@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *describe;
@property(nonatomic, assign) BOOL isback;

- (instancetype)initWithType:(NSString *)type describe:(NSString *)describe isback:(BOOL)isback;
- (NSString *)getCommandJsonString;

@end
