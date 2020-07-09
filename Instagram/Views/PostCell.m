//
//  PostCell.m
//  Instagram
//
//  Created by chadfranklin on 7/9/20.
//  Copyright © 2020 chadfranklin. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

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
    self.imageView.file = post[@"image"];
    [self.imageView loadInBackground];
    
    self.captionLabel.text = post.caption;
    self.usernameLabel.text = post.author.username;
}

@end
