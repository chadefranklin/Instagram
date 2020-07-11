//
//  PostDetailsViewController.m
//  Instagram
//
//  Created by chadfranklin on 7/10/20.
//  Copyright © 2020 chadfranklin. All rights reserved.
//

#import "PostDetailsViewController.h"
#import "Post.h"
#import "PostCell.h"
#import "ComposeCommentCell.h"
#import "CommentCell.h"
#import "Comment.h"
#import <Parse/Parse.h>

@interface PostDetailsViewController () <UITableViewDelegate, UITableViewDataSource, ComposeCommentCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView; // contains post and comments
@property (nonatomic, strong) NSMutableArray *comments;
@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.detailsTableView.dataSource = self;
    self.detailsTableView.delegate = self;
    
    PFQuery *postQuery = [Comment query];
    [postQuery whereKey:@"post" equalTo:self.post];
    [postQuery orderByDescending:@"createdAt"];
    //[postQuery includeKey:@"createdAt"]; // don't think this is necessary
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Comment *> * _Nullable comments, NSError * _Nullable error) {
        if (comments) {
            // do something with the data fetched
            self.comments = comments;
            [self.detailsTableView reloadData];
        }
        else {
            // handle error
        }
        
        //[self.refreshControl endRefreshing];
    }];
    
    NSLog(@"details view did load");
    [self.detailsTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return self.posts.count;
    return 2 + self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        NSLog(@"Details Post Cell");
        PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailsPostCell"];
        
        //PFObject *post = self.posts[indexPath.row];
        
        [cell setPost:self.post];
            
        NSLog(@"%d", indexPath.row);
        return cell;
    }
    else if(indexPath.row == 1){
        ComposeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ComposeCommentCell"];
        
        //PFObject *post = self.posts[indexPath.row];
        
        [cell setPost:self.post];
        
        cell.delegate = self;
            
        return cell;
    }
    else{
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        
        [cell setComment:self.comments[indexPath.row - 2]];
        return cell;
    }
}

- (void)didPostComment:(NSString *)comment{
    NSLog(@"did post comment");
    
    Comment *newComment = [Comment new];
    newComment.author = [PFUser currentUser];
    newComment.comment = comment;
    
    [self.comments insertObject:newComment atIndex:0];
    [self.detailsTableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
