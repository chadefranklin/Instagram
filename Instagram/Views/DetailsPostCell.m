//
//  DetailsPostCell.m
//  Instagram
//
//  Created by chadfranklin on 7/10/20.
//  Copyright © 2020 chadfranklin. All rights reserved.
//

#import "DetailsPostCell.h"
#import "DateTools.h"

@implementation DetailsPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.width / 2;
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
    
    //if(self.timestampLabel){
    self.timestampLabel.text = [post.createdAt timeAgoSinceNow];
    //}
    NSLog(post.createdAt.description);
}

@end
