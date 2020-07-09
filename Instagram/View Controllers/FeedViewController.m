//
//  FeedViewController.m
//  Instagram
//
//  Created by chadfranklin on 7/8/20.
//  Copyright © 2020 chadfranklin. All rights reserved.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "PostCell.h"
#import "Post.h"

@interface FeedViewController ()
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;

@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.feedTableView.dataSource = self;
    self.feedTableView.delegate = self;
    
    [self fetchFeed];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchFeed) forControlEvents:UIControlEventValueChanged];
    //[self.moviesTableView addSubview:self.refreshControl];
    [self.feedTableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchFeed{
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.posts = posts;
            [self.feedTableView reloadData];
        }
        else {
            // handle error
        }
        
        [self.refreshControl endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 20;
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    PFObject *post = self.posts[indexPath.row];
    
    [cell setPost:post];
        
    return cell;
}

- (IBAction)onComposePressed:(id)sender {
    
    [self performSegueWithIdentifier:@"composeSegue" sender:nil];
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
