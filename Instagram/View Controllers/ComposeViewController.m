//
//  ComposeViewController.m
//  Instagram
//
//  Created by chadfranklin on 7/8/20.
//  Copyright © 2020 chadfranklin. All rights reserved.
//

#import "ComposeViewController.h"
#import <Parse/Parse.h>
#import "Post.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad { // view did appear?
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setImage];
}

- (void)setImage{
    self.imageView.image = self.image;
}

- (IBAction)onPostPressed:(id)sender {
    NSLog(@"onPostPressed");
    [Post postUserImage:self.imageView.image withCaption:self.captionTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"success");
            [self dismissViewControllerAnimated: YES completion: nil];
        } else {
            NSLog(@"fail");
            NSLog(error.description);
        }
    }];
}

- (IBAction)onCancelPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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
