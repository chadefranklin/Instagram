//
//  ProfileViewController.m
//  Instagram
//
//  Created by chadfranklin on 7/11/20.
//  Copyright © 2020 chadfranklin. All rights reserved.
//

#import "ProfileViewController.h"
#import "PostCell.h"
#import "Post.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UITableView *profileFeedTableView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.profileFeedTableView.dataSource = self;
    self.profileFeedTableView.delegate = self;
    
    //[self fetchFeed];
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
