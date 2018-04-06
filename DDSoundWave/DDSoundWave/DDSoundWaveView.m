//
//  DDSoundWaveView.m
//  DDSoundWave
//
//  Created by Teaker on 2018/4/6.
//  Copyright © 2018年 Liuzhida. All rights reserved.
//

#import "DDSoundWaveView.h"

#define kNumberOfWaves 5

@interface DDSoundWaveView ()

@property (nonatomic, strong) NSMutableArray<CAShapeLayer *> * waves;
@property (nonatomic, strong) CADisplayLink *displayLink;   //计时器，用于刷新layer布局

@property (nonatomic, strong) UIButton *microphoneBtn;  //话筒
@end

@implementation DDSoundWaveView

#pragma mark - overwrite init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

#pragma mark - Private methods

// 刷新layer布局
- (void)displayWave {
    
}

#pragma mark - Getters

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayWave)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}

@end
