//
//  JXViewController.m
//  JOOXiOSSDK
//
//  Created by jinpingshi on 08/05/2019.
//  Copyright (c) 2019 jinpingshi. All rights reserved.
//

#import "JXViewController.h"
#import <JOOXiOSSDK/JOOXiOSSDK.h>
#import "JXSlider.h"
#import "JXTestViewController.h"
#import <WebKit/WebKit.h>

@interface JXViewController () <JOOXiOSSDKDelegate>

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) IBOutlet UIButton *openJOOXButton;
@property (weak, nonatomic) IBOutlet UITextField *scopeTextField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *loginModeSegmentedControl;
@property (strong, nonatomic) JOOXiOSSDK *sdk;

@end

@implementation JXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    // 填入你的App申请的AppID及AppName
    NSString *appID = @"PLACEHOLDER_APPID";
    NSString *appName = @"PLACEHOLDER_APPNAME";
    
    // 初始化sdk
    self.sdk = [JOOXiOSSDK serviceWithAppID:appID
                                    appName:appName
                                  scopeList:@[
                                      @"public",
                                      @"user_profile",
                                      @"playmusic",
//                                      @"search",
//                                      @"playmv"
                                  ]
                            defaultAuthMode:[self.loginModeSegmentedControl titleForSegmentAtIndex:self.loginModeSegmentedControl.selectedSegmentIndex]
                                   delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.sdk.delegate = self;
}

// app从后台进入前台都会调用这个方法
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self _updateViewWithLoading:NO];
}

- (IBAction)loginButtonClicked:(id)sender
{
    [self _updateViewWithLoading:YES];
    if ([self.sdk.defaultAuthMode isEqualToString:@"ticketToken"]) {
        [self _showAuthTicketTokenAlert];
    } else {
        [self.sdk auth];
    }
}

- (IBAction)logoutButtonClicked:(id)sender {
    // 清除缓存
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        NSLog(@"已清除WKWebView缓存");
    }];
    
    [self.sdk logout];
}

- (IBAction)openJOOXButtonClicked:(id)sender {
    [JOOXiOSSDK openJOOX];
}

- (IBAction)loginModeChanged:(id)sender {
    self.sdk.defaultAuthMode = [self.loginModeSegmentedControl titleForSegmentAtIndex:self.loginModeSegmentedControl.selectedSegmentIndex];
}

#pragma mark - JOOXiOSSDKDelegate
- (void)jxAuthStateUpdate:(JX_AUTH_STATE)authState
{
    if (authState != JX_AUTH_STATE_RUNNING) {
        [self _updateViewWithLoading:NO];
        if (authState == JX_AUTH_STATE_FAILED) {
            [self _showMessage:[NSString stringWithFormat:@"JOOX login failed:%@", self.sdk.error.localizedDescription]];
        } else if (authState == JX_AUTH_STATE_CANCELLED) {
            [self _showMessage:@"JOOX login canceled."];
        } else if (authState == JX_AUTH_STATE_SUCCESS) {
            [self performSegueWithIdentifier:@"gotoTestViewController" sender:self];
        }
    }
}

#pragma mark - set next vc's param
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gotoTestViewController"]) {
        JXTestViewController *testVC = segue.destinationViewController;
        testVC.sdk = self.sdk;
    }
}

#pragma mark - private method
- (void)_updateViewWithLoading:(BOOL)loading
{
    self.loginButton.hidden = loading ? YES : NO;
    self.logoutButton.hidden = loading ? YES : NO;
    self.loadingView.hidden = loading ? NO : YES;
    self.loginModeSegmentedControl.hidden = loading ? YES : NO;
}

-(void)_showMessage:(NSString *)message
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)_showAuthTicketTokenAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please enter ticket token" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.sdk authWithTicketToken:alertController.textFields.firstObject.text];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self _updateViewWithLoading:NO];
    }]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Ticket Token";
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
