//
//  PostDetailsViewController.h
//  Instagram
//
//  Created by chadfranklin on 7/10/20.
//  Copyright © 2020 chadfranklin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostDetailsViewController : UIViewController
@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
