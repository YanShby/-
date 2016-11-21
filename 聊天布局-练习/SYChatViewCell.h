//
//  SYChatViewCell.h
//  聊天布局-练习
//
//  Created by Yans on 2016/11/7.
//  Copyright © 2016年 Yans. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYChatModel;

@interface SYChatViewCell : UITableViewCell
/**一个cell中的chatModel*/
@property (nonatomic, strong) SYChatModel *chatModel;
@end
