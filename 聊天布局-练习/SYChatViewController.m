//
//  SYChatViewController.m
//  聊天布局-练习
//
//  Created by Yans on 2016/11/7.
//  Copyright © 2016年 Yans. All rights reserved.
//

#import "SYChatViewController.h"
#import "SYChatModel.h"
#import "SYChatViewCell.h"

@interface SYChatViewController () <UITableViewDelegate, UITableViewDataSource>
/**存放chatModel*/
@property (nonatomic, strong) NSArray *chatModels;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomSpacing;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@end

@implementation SYChatViewController

- (NSArray *)chatModels {
    if (_chatModels == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *chatArray = [NSMutableArray array];
        //记录上一条chatModel
        SYChatModel *lastChat = nil;
        for (NSDictionary *dict in dictArray) {
            SYChatModel *chatModel = [SYChatModel chatModelWithDict:dict];
            //判断两条消息是否相等
            chatModel.hideTime = [chatModel.time isEqualToString:lastChat.time];
            [chatArray addObject:chatModel];
            
            lastChat = chatModel;
        }
        _chatModels = chatArray;
    }
    return _chatModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //成为监听者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowOrHide:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - keyboard Event
- (void)keyboardShowOrHide:(NSNotification *)notification {
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.textViewBottomSpacing.constant = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SYChatModel *chatModel = self.chatModels[indexPath.row];
    
    SYChatViewCell *cell = nil;
   
    if (chatModel.type == SYChatTypeMe) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"chatCellForMe" forIndexPath:indexPath];
    } else if (chatModel.type == SYChatTypeOther) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"chatCellForOther" forIndexPath:indexPath];
    }
  
    cell.chatModel = self.chatModels[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SYChatModel *chatModel = self.chatModels[indexPath.row];
    return chatModel.cellHeight;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 退出键盘
    [self.view endEditing:YES];
}

@end
