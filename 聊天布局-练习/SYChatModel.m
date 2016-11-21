//
//  SYChatModel.m
//  聊天布局-练习
//
//  Created by Yans on 2016/11/7.
//  Copyright © 2016年 Yans. All rights reserved.
//

#import "SYChatModel.h"

@implementation SYChatModel
+ (instancetype)chatModelWithDict:(NSDictionary *)dict {
    SYChatModel *chatModel = [[self alloc] init];
    [chatModel setValuesForKeysWithDictionary:dict];
    return chatModel;
}
@end
