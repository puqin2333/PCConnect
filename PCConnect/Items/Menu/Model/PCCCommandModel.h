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


- (instancetype)initWithType:(NSString *)type describe:(NSString *)describe isback:(BOOL)isback; //传入参数，将字符串转为 json
// 快捷命令参数
- (instancetype)initWithType:(NSString *)type isback:(BOOL)isback;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString; // json字符串转为字典类型
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;  // josn 字符串转为数组类型

@end


@interface PCCPointModel : JSONModel

@property(nonatomic, assign) BOOL click;
@property(nonatomic, assign) BOOL doubleClick;
@property(nonatomic, assign) BOOL rightClick;
@property(nonatomic, assign) BOOL singleClick;
@property(nonatomic, strong) NSDictionary *map;

// 鼠标命令参数
- (instancetype)initWithTouchClick:(BOOL)isClick singleClick:(BOOL)isSingle doubleClick:(BOOL)isDouble rightClick:(BOOL) isRight map:(NSDictionary *)mapWayPath;

@end

