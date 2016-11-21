//
//  SYChatModel.h
//  聊天布局-练习
//
//  Created by Yans on 2016/11/7.
//  Copyright © 2016年 Yans. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SYChatType) {
    SYChatTypeMe,
    SYChatTypeOther
};

@interface SYChatModel : NSObject
/**时间*/
@property (nonatomic, strong) NSString *time;
/**文字*/
@property (nonatomic, strong) NSString *text;
/**chatType*/
@property (nonatomic, assign) SYChatType type;
/**cell高度*/
@property (nonatomic, assign) CGFloat cellHeight;
/**是否隐藏时间*/
@property (nonatomic, assign, getter = isHideTime) BOOL hideTime;

+ (instancetype)chatModelWithDict:(NSDictionary *)dict;
@end
