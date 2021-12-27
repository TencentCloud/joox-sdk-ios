//
//  JXPlayerSongListViewController.m
//  WeMusic
//
//  Created by satyapeng on 27/7/2018.
//

#import "JXPlayerSongListViewController.h"
#import "JXPlayerSongListViewTableViewCell.h"
#import <JOOXiOSSDK/JOOXiOSSDK.h>
//#import "JXOpenAPITopListsParser.h"
//#import "JXOpenAPIOneTopListParser.h"
#import "JXPlayerViewController.h"
#import "JXDemoSongInfo.h"
#import "JXOpenAPIOnePlayListParser.h"
#import "JXAudioADParser.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface JXPlayerSongListViewController () <UITableViewDataSource, UITableViewDelegate, JXPlayerSongListViewTableViewCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (strong, nonatomic) NSMutableArray<JXDemoSongInfo *> *demoSongInfoArray;
@property (strong, nonatomic) NSMutableArray<JXAudioADBaseInfo *> *audioADBaseInfoArray;
@property (assign, nonatomic) NSInteger selectedIndex;

@end

@implementation JXPlayerSongListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _loadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self.mainTableView scrollToRowAtIndexPath:[self currentSongIndexPath] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (IBAction)backButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (NSIndexPath *)currentSongIndexPath {
//    return [NSIndexPath indexPathForRow:self.sdk.currentPlayingObjectIndex inSection:0];
//}

#pragma mark - load data
- (void)_loadData
{
//    self.loadingView.hidden = NO;
//    __weak __typeof(self)weakSelf = self;
//    [self.sdk doJOOXRequestWithUrlPathString:@"v1/toplists"
//                              urlQueryString:@"country=hk&lang=en"
//                                    callback:^(JXOpenAPIWorkResult workResult, NSString * _Nonnull jsonResult) {
//        if (JXOpenAPIWorkResult_Success == workResult) {
//            NSError *error = nil;
//            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[jsonResult dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
//            if (!error) {
//                JXOpenAPITopListsParser *topListsParser = [[JXOpenAPITopListsParser alloc] init];
//                [topListsParser parseJsonDictionary:dataDictionary];
//                if (topListsParser.topListArray.count > 0) {
//                    JXTopListInfo *oneTopList = topListsParser.topListArray[0];
//                    [weakSelf.sdk doJOOXRequestWithUrlPathString:[NSString stringWithFormat:@"v1/toplist/%@/tracks", oneTopList.topListOpenID]
//                                                  urlQueryString:@"country=hk&lang=en&num=50&index=0"
//                                                        callback:^(JXOpenAPIWorkResult workResult2, NSString * _Nonnull jsonResult2) {
//                        self.loadingView.hidden = YES;
//                        NSError *error2 = nil;
//                        NSDictionary *dataDictionary2 = [NSJSONSerialization JSONObjectWithData:[jsonResult2 dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error2];
//                        if (!error2) {
//                            JXOpenAPIOneTopListParser *oneTopListParser = [[JXOpenAPIOneTopListParser alloc] init];
//                            [oneTopListParser parseJsonDictionary:dataDictionary2];
//                            weakSelf.demoSongInfoArray = oneTopListParser.demoSongInfoArray;
//                            [weakSelf _updateViewWhenDataReady];
//                        } else {
//                            [weakSelf _showMessage:[NSString stringWithFormat:@"parse one toplist failed: %@", error2]];
//                        }
//                    }];
//                }
//            } else {
//                self.loadingView.hidden = YES;
//                [weakSelf _showMessage:[NSString stringWithFormat:@"parse toplists failed: %@", error]];
//            }
//        } else {
//            self.loadingView.hidden = YES;
//            [self _showMessage:[NSString stringWithFormat:@"load toplists failed: %d", workResult]];
//        }
//    }];
    self.loadingView.hidden = NO;
    __weak __typeof(self)weakSelf = self;
    if (self.isADPlaylist) {
        [self.sdk getAudioADWithCallback:^(NSError * _Nullable error, NSDictionary * _Nullable jsonDictionary) {
            if (error) {
                [weakSelf _showMessage:error.localizedDescription];
            } else {
                JXAudioADParser *parser = [[JXAudioADParser alloc] init];
                [parser parseJsonDictionary:jsonDictionary];
                weakSelf.audioADBaseInfoArray = [NSMutableArray arrayWithArray:parser.audioADBaseInfoArray];
                [weakSelf _updateViewWhenDataReady];
            }
        }];
    } else {
        [self.sdk doJOOXRequestWithUrlPathString:[NSString stringWithFormat:@"v1/playlist/%@/tracks", self.playlistID]
                                  urlQueryString:@"country=hk&lang=en&num=50&index=0"
                                        callback:^(JX_API_RESPONSE_ERROR_CODE errorCode, NSString * _Nonnull jsonResult) {
            self.loadingView.hidden = YES;
            if (JX_API_RESPONSE_ERROR_CODE_NONE == errorCode) {
                NSError *error = nil;
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:[jsonResult dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
                if (!error) {
                    JXOpenAPIOnePlayListParser *parser = [[JXOpenAPIOnePlayListParser alloc] init];
                    [parser parseJsonDictionary:dataDictionary];
                    weakSelf.demoSongInfoArray = [NSMutableArray arrayWithArray:parser.songInfoArray];
                    [weakSelf _updateViewWhenDataReady];
                } else {
                    [weakSelf _showMessage:[NSString stringWithFormat:@"parse playlist failed: %@", error]];
                }
            } else {
                [weakSelf _showMessage:[NSString stringWithFormat:@"load playlist failed: %ld", (long)errorCode]];
            }
        }];
    }
}

-(void)_showMessage:(NSString *)message
{
    [SVProgressHUD showInfoWithStatus:message];
}

- (void)_updateViewWhenDataReady
{
    self.loadingView.hidden = YES;
    [self.mainTableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (self.audioADBaseInfoArray ? self.audioADBaseInfoArray.count : self.demoSongInfoArray.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXPlayerSongListViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongInfoCell"];
    if (!cell) {
        cell = [[JXPlayerSongListViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SongInfoCell"];
    }
    cell.delegate = self;
    if (self.audioADBaseInfoArray) {
        [cell updateWithAudioADBaseInfo:self.audioADBaseInfoArray[indexPath.row]
                                  index:indexPath.row];
    } else {
        [cell updateWithSongInfo:self.demoSongInfoArray[indexPath.row]
                           index:indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < (self.audioADBaseInfoArray ? self.audioADBaseInfoArray.count : self.demoSongInfoArray.count)) {
        self.selectedIndex = indexPath.row;
        [self performSegueWithIdentifier:@"gotoPlayerViewController" sender:self];
    } else {
        self.selectedIndex = -1;
        [self _showMessage:[NSString stringWithFormat:@"demoSongInfoArray count:%lu is less then indexPath:%ld", (unsigned long)self.demoSongInfoArray.count, (long)indexPath.row]];
    }

//    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
//    [self dismissViewControllerAnimated:YES completion:^{
//        if ([self.delegate respondsToSelector:@selector(playerPlayList:didSelectItem:)]) {
//            [self.delegate playerPlayList:self didSelectItem:indexPath.row];
//        }
//    }];
}

#pragma mark - JXPlayerSongListViewTableViewCellDelegate
- (void)onSongQualityChanged:(JXSongQuality)songQuality
                   songIndex:(NSInteger)songIndex
{
    if (songIndex < self.demoSongInfoArray.count) {
        JXDemoSongInfo *demoSongInfo = self.demoSongInfoArray[songIndex];
        demoSongInfo.quality = songQuality;
        [self.demoSongInfoArray replaceObjectAtIndex:songIndex
                                          withObject:demoSongInfo];
    }
    
}

#pragma mark - set next vc's param
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gotoPlayerViewController"]) {
        JXPlayerViewController *playerVC = segue.destinationViewController;
        playerVC.sdk = self.sdk;
        if (self.audioADBaseInfoArray) {
            playerVC.audioADBaseInfo = self.audioADBaseInfoArray[self.selectedIndex];
        } else if (self.demoSongInfoArray) {
            playerVC.songBaseInfo = self.demoSongInfoArray[self.selectedIndex];
        }
        
    }
}


@end
