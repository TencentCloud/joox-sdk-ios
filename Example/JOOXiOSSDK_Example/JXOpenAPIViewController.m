//
//  JXOpenAPIViewController.m
//  JOOXiOSSDK_Example
//
//  Created by JINPING SHI on 2020/2/11.
//  Copyright © 2020 jinpingshi. All rights reserved.
//

#import "JXOpenAPIViewController.h"
#import <JOOXiOSSDK/JOOXiOSSDK.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface JXOpenAPIViewController ()
@property (strong, nonatomic) IBOutlet UITextField *pathTextField;
@property (strong, nonatomic) IBOutlet UITextField *queryTextField;
@property (strong, nonatomic) IBOutlet UITextView *resultTextView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@end

@implementation JXOpenAPIViewController

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
- (IBAction)backButtonDidClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doRequestButtonDidClicked:(id)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    self.loadingView.hidden = NO;
    if (self.pathTextField.text.length == 0) {
        self.loadingView.hidden = YES;
        [self _showMessage:@"path can not be empty!!!"];
    } else {
        __weak __typeof(self)wself = self;
        [self.sdk doJOOXRequestWithUrlPathString:self.pathTextField.text
                                  urlQueryString:self.queryTextField.text
                                        callback:^(JX_API_RESPONSE_ERROR_CODE errorCode, NSString * _Nonnull jsonResult) {
            self.loadingView.hidden = YES;
            if (JX_API_RESPONSE_ERROR_CODE_NONE == errorCode) {
                wself.resultTextView.text = jsonResult;
            } else {
                [wself _showMessage:[NSString stringWithFormat:@"request failed: %ld", (long)errorCode]];
            }
        }];
    }
}

-(void)_showMessage:(NSString *)message
{
    [SVProgressHUD showInfoWithStatus:message];
}

@end
