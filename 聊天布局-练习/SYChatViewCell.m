//
//  SYChatViewCell.m
//  聊天布局-练习
//
//  Created by Yans on 2016/11/7.
//  Copyright © 2016年 Yans. All rights reserved.
//

#import "SYChatViewCell.h"
#import "SYChatModel.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface SYChatViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *textButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation SYChatViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textButton.titleLabel.numberOfLines = 0;
    //使button中的label不超过四边边界.
    self.textButton.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
}

- (void)setChatModel:(SYChatModel *)chatModel {
    _chatModel = chatModel;

    if (_chatModel.isHideTime) {
        self.timeLabel.hidden = YES;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    } else {
        self.timeLabel.hidden = NO;
        self.timeLabel.text = chatModel.time;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(15);
        }];
    }
    
    [self settingChatCellWithButton:self.textButton icon:self.iconView];
}

- (void)settingChatCellWithButton:(UIButton *)button icon:(UIImageView *)icon {
    [button setTitle:self.chatModel.text forState:UIControlStateNormal];
    
    [button layoutIfNeeded];
    
    [button updateConstraints:^(MASConstraintMaker *make) {
        CGFloat buttonHeight = button.titleLabel.frame.size.height + 30;
        make.height.equalTo(buttonHeight);
        
        CGFloat iconMaxY = CGRectGetMaxY(icon.frame);
        if (buttonHeight > iconMaxY) {
            self.chatModel.cellHeight = buttonHeight + 40;
        } else {
            self.chatModel.cellHeight = iconMaxY + 25;
        }
    }];

}

@end
