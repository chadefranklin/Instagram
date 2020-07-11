//
//  Comment.h
//  Instagram
//
//  Created by chadfranklin on 7/11/20.
//  Copyright © 2020 chadfranklin. All rights reserved.
//

#import <Parse/Parse.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comment : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *commentID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) Post *post;

+ (void) postComment: ( NSString * _Nullable )comment withPost: ( Post * _Nullable)post withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
