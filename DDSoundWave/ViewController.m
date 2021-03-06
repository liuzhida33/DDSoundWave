//
//  ViewController.m
//  DDSoundWave
//
//  Created by Teaker on 2018/4/6.
//  Copyright © 2018年 Liuzhida. All rights reserved.
//

#import "ViewController.h"
#import "DDSoundWaveView.h"
#import <UIView+LayoutMethods.h>

@interface ViewController ()
@property (nonatomic, strong) DDSoundWaveView *waveView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:39 / 255.0 green:35 / 255.0 blue:36 / 255.0 alpha:1];
    [self.view addSubview:self.waveView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.waveView setCt_size:CGSizeMake(SCREEN_WIDTH, 80)];
    [self.waveView centerXEqualToView:self.view];
    [self.waveView setCt_y:SCREEN_HEIGHT-self.view.safeAreaBottomGap - 80];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (DDSoundWaveView *)waveView {
    if (!_waveView) {
        _waveView = [[DDSoundWaveView alloc] init];
    }
    return _waveView;
}


@end
