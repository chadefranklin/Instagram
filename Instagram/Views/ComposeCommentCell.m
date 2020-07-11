//
//  ComposeCommentCell.m
//  Instagram
//
//  Created by chadfranklin on 7/10/20.
//  Copyright © 2020 chadfranklin. All rights reserved.
//

#import "ComposeCommentCell.h"
#import <Parse/Parse.h>
#import "Comment.h"

@implementation ComposeCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
}

- (IBAction)onPostCommentPressed:(id)sender {
    if(![self.composeCommentTextView.text isEqual:@""]){
        /*
        // Create the comment
        PFObject *myComment = [PFObject objectWithClassName:@"Comment"];
        myComment[@"content"] = self.composeCommentTextView.text;

        // Add a relation between the Post and Comment
        myComment[@"post"] = self.post;
        
        myComment[@"author"] = self.post.author;
        
        

        // This will save both myPost and myComment
        [myComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded){
                [self.delegate didPostComment:self.composeCommentTextView.text];
                self.composeCommentTextView.text = @"";
            } else {
                NSLog(@"failed to post comment");
            }
        }];
        */
        
        [Comment postComment:self.composeCommentTextView.text withPost:self.post withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded){
                [self.delegate didPostComment:self.composeCommentTextView.text];
                self.composeCommentTextView.text = @"";
            } else {
                NSLog(@"failed to post comment");
                NSLog(error.description);
            }
        }];
    }
}


@end
