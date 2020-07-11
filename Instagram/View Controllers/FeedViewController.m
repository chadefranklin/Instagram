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
#import "ComposeViewController.h"
#import "PostDetailsViewController.h"

@interface FeedViewController ()
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;

@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) UIImage *temporaryImage;
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
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    PFObject *post = self.posts[indexPath.row];
    
    [cell setPost:post];
        
    return cell;
}

- (IBAction)onComposePressed:(id)sender {
    
    //[self performSegueWithIdentifier:@"composeSegue" sender:nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // ask whether to use camera or photo library
        [self composeImageAlert];
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        [self pickImage:NO];
    }
}

- (void)composeImageAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
           message:@"Message"
    preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle cancel response here. Doing nothing will dismiss the view.
                                                      }];
    // add the cancel action to the alertController
    [alert addAction:cancelAction];

    // create an OK action
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             [self pickImage:YES];
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:cameraAction];
    
    // create an OK action
    UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"Photo Library"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             [self pickImage:NO];
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:photoLibraryAction];
}

- (void)pickImage:(BOOL)camera{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if (camera) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"imagePickerController");
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    //self.imageView.image = [self resizeImage:editedImage withSize:CGSizeMake(500, 500)];
    self.temporaryImage = [self resizeImage:editedImage withSize:CGSizeMake(500, 500)];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"composeSegue" sender:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.presentingViewController dismissViewControllerAnimated:true completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
    
    if ([segue.identifier isEqualToString:@"toComposeSegue"]) {
        UINavigationController *composeNavigationController = [segue destinationViewController];
        ComposeViewController *composeViewController = composeNavigationController.viewControllers.firstObject;
        
        composeViewController.image = self.temporaryImage;
    } else if ([segue.identifier isEqualToString:@"toPostDetailsSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.feedTableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        
        PostDetailsViewController *postDetailsViewController = (PostDetailsViewController*)[segue destinationViewController];
        postDetailsViewController.post = post;
    }
}


@end
