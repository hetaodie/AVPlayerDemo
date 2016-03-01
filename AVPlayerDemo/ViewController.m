//
//  ViewController.m
//  AVPlayerDemo
//
//  Created by Weixu on 16/2/18.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ViewController.h"
#import "PlayerView.h"

@interface ViewController ()<PlayerViewDelegate>
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UILabel *progressShow;
@property (retain, nonatomic) PlayerView *playerView;
@property (retain, nonatomic) IBOutlet UILabel *currentTimes;
@property (retain, nonatomic) IBOutlet UIButton *playButton;
@property (retain, nonatomic) IBOutlet UISlider *progressSlider;

@property (retain, nonatomic) IBOutlet UISlider *volumeSlider;
@property (assign, nonatomic) BOOL isFull;
@property (assign, nonatomic) CGRect oriFrame;
@property (retain, nonatomic) IBOutlet UIButton *btnFull;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFull = NO;
    
    
    _playerView = [[PlayerView alloc] initPlayerViewWithURl:[self getFileUrl] isCircle:NO];
    [_playerView setFrame:self.contentView.bounds];
    [self.contentView addSubview:self.playerView];
    
    [self.contentView bringSubviewToFront:self.btnFull];
    
    
    [self.playerView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    self.playerView.delegate = self;
    [self.playButton setEnabled:NO];
    
    self.volumeSlider.minimumValue = 0.0f;
    self.volumeSlider.maximumValue = 1.0f;
    self.volumeSlider.value = 0.0f;

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.oriFrame = self.contentView.frame;
}

- (void)onPlayerloadSuccessWithTotalSecond:(float)totalSecond{
    [self.progressShow setText:[NSString stringWithFormat:@"%f",totalSecond]];
    [self.playButton setEnabled:YES];
    
    self.progressSlider.minimumValue = 0.0f;
    self.progressSlider.maximumValue = totalSecond;
    self.progressSlider.value = 0.0f;
    
}

- (void)onPlayerloadError:(int)aError{
     [self.progressShow setText:@"失败"];
      [self.playButton setEnabled:NO];
}

- (void)onPlayerCurrentSecond:(float)aCurrentSecond{
    [self.currentTimes setText:[NSString stringWithFormat:@"%f",aCurrentSecond]];
    self.progressSlider.value = aCurrentSecond;
}

- (void)onPlayerFinish{
    NSLog(@"播放结束");
}

- (void)onplaybackStalled{
    NSLog(@"播放异常中断");
}

- (void)onPlayerBufferSecond:(float)aBufferSecond{
    NSLog(@"onPlayerBufferSecond = %f",aBufferSecond);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnPlay:(id)sender {
    [self.playerView play];
}
- (IBAction)btnPause:(id)sender {
    [self.playerView pause];
}
- (IBAction)btnStop:(id)sender {
    [self.playerView stop];
    [_playerView removeFromSuperview];
    [_playerView release];
    
}
- (IBAction)btnChange:(id)sender {
    [self.playerView setNewUrl:[self getFileUrl] isCircle:YES];
}
- (IBAction)btnChange2:(id)sender {
    [self.playerView setNewUrl:[self getNetworkUrl] isCircle:YES];
}
- (IBAction)btnChangeDuan:(id)sender {
    [self.playerView setNewUrl:[self getFileUrl2] isCircle:YES];
}

- (IBAction)progressChange:(id)sender {
}

- (IBAction)VolumeChange:(id)sender {
}

- (IBAction)btnFit:(id)sender {
    [self.playerView setPlayerVideoGravity:PlayerVideoResizeFit];
}

- (IBAction)btnAspect:(id)sender {
    [self.playerView setPlayerVideoGravity:PlayerVideoResizeAspect];
}

- (IBAction)btnFill:(id)sender {
    [self.playerView setPlayerVideoGravity:PlayerVideoAspectFill];
}
- (IBAction)btnMuted:(id)sender {
    BOOL isMuted = [self.playerView getPlayerMute];
    [self.playerView setPlayerMute:!isMuted];
}
- (IBAction)btnShow:(id)sender {
    if (!self.isFull) {
        CGRect frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
        [self.contentView setFrame:frame];
        CGPoint point = self.view.center;
        [self.contentView setCenter:CGPointMake(point.x, point.y)];
        
        CGAffineTransform at =CGAffineTransformMakeRotation(M_PI/2); //先顺时钟旋转90
        [self.contentView setTransform:at];
        

        self.isFull = YES;
    }
    else{
        [self.contentView setFrame:self.oriFrame];
        CGAffineTransform at =CGAffineTransformMakeRotation(0); //先顺时钟旋转90
        [self.contentView setTransform:at];
        self.isFull = NO;
    }

}

/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"testMovie.mov" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl2{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"test2.mp4" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSURL *videoUrl = [NSURL URLWithString:@"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA"];
    return videoUrl;
}

- (void)dealloc {
    [_contentView release];
    [_progressShow release];
    [_currentTimes release];
    [_playButton release];
    [_progressSlider release];
    [_volumeSlider release];
    [_btnFull release];
    [super dealloc];
}
@end
