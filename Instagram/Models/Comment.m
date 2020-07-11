//
//  Comment.m
//  Instagram
//
//  Created by chadfranklin on 7/11/20.
//  Copyright © 2020 chadfranklin. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@dynamic commentID;
@dynamic userID;
@dynamic author;
@dynamic comment;
@dynamic post;

+ (nonnull NSString *)parseClassName {
    return @"Comment";
}

+ (void) postComment: ( NSString * _Nullable )comment withPost: ( Post * _Nullable)post withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Comment *newComment = [Comment new];
    newComment.author = [PFUser currentUser];
    newComment.comment = comment;
    newComment.post = post;
    
    [newComment saveInBackgroundWithBlock: completion];
}

@end
