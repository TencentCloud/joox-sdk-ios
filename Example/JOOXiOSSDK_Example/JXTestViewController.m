//
//  JXTestViewController.m
//  JOOXiOSSDK_Example
//
//  Created by JINPING SHI on 2020/2/10.
//  Copyright © 2020 jinpingshi. All rights reserved.
//

#import "JXTestViewController.h"
#import <JOOXiOSSDK/JOOXiOSSDK.h>
#import "JXPlayerSongListViewController.h"
#import "JXOpenAPIViewController.h"

@interface JXTestViewController ()

@property (strong, nonatomic) IBOutlet UITextField *playListIDTextField;
@property (assign, nonatomic) BOOL testAuidoAD;

@end

@implementation JXTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - set next vc's param
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gotoPlayerSongListViewController"]) {
        JXPlayerSongListViewController *playListVC = segue.destinationViewController;
        playListVC.sdk = self.sdk;
        playListVC.playlistID = self.playListIDTextField.text;
        playListVC.isADPlaylist = self.testAuidoAD;
    } else if ([segue.identifier isEqualToString:@"gotoOpenAPIViewController"]) {
        JXOpenAPIViewController *openAPIVC = segue.destinationViewController;
        openAPIVC.sdk = self.sdk;
    }
}

- (IBAction)testSongPlayButtonClicked:(id)sender {
    self.testAuidoAD = NO;
    if (self.playListIDTextField.text.length == 0) {
        [self _showMessage:@"Must input PlayList ID!!!"];
    } else {
        [self performSegueWithIdentifier:@"gotoPlayerSongListViewController" sender:self];
    }
}

- (IBAction)testADButtonClicked:(id)sender {
    self.testAuidoAD = YES;
    [self performSegueWithIdentifier:@"gotoPlayerSongListViewController" sender:self];
}

- (IBAction)backButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)_showMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
