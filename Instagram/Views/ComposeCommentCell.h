//
//  ComposeCommentCell.h
//  Instagram
//
//  Created by chadfranklin on 7/10/20.
//  Copyright © 2020 chadfranklin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeCommentCellDelegate

- (void)didPostComment:(NSString *)comment;

@end

@interface ComposeCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *postCommentButton;
@property (weak, nonatomic) IBOutlet SZTextView *composeCommentTextView;

@property (strong, nonatomic) Post *post;
@property (nonatomic, weak) id<ComposeCommentCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
