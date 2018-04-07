//
//  DDSoundWaveView.m
//  DDSoundWave
//
//  Created by Teaker on 2018/4/6.
//  Copyright © 2018年 Liuzhida. All rights reserved.
//

#import "DDSoundWaveView.h"
#import <UIView+LayoutMethods.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import <AudioToolbox/AudioToolbox.h>

#define kNumberOfWaves 5

@interface DDSoundWaveView ()

@property (nonatomic, strong) NSMutableArray<CAShapeLayer *> * waves;
@property (nonatomic, strong) CADisplayLink *displayLink;   //计时器，用于刷新layer布局
@property (nonatomic, assign) BOOL animated;    //动画是否开始

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
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.microphoneBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.microphoneBtn sizeToFit];
    [self.microphoneBtn centerEqualToView:self];
}

#pragma mark - Event repose

- (void)microphoneDidTap:(UIButton *)sender {
    if (_animated) {
        return;
    }
    __weak __typeof__(self) weak_self = self;
    if ([[AVAudioSession sharedInstance] recordPermission] == AVAudioSessionRecordPermissionUndetermined) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            __strong __typeof__(weak_self) strong_self = weak_self;
            if (!strong_self) return ;
            if (granted) {
                //获取权限方法回调需要返回主线程操作
                dispatch_async(dispatch_get_main_queue(), ^{
                    [strong_self startRecord];
                });
            }
        }];
    }else if ([[AVAudioSession sharedInstance] recordPermission] == AVAudioSessionRecordPermissionDenied) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法使用麦克风" message:@"请在iPhone的""设置-茶刻-麦克风""中打开开关" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (@available(iOS 10, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            } else {
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
#pragma clang diagnostic pop
                
            }
        }]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        return;
    }else {
        [self startRecord];
    }
}

#pragma mark - Private methods

// 开始录音
- (void)startRecord {
    AudioServicesPlaySystemSound(1103);
}

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

- (UIButton *)microphoneBtn {
    if (!_microphoneBtn) {
        _microphoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_microphoneBtn setImage:[UIImage imageNamed:@"robot_microphone"] forState:UIControlStateNormal];
        [_microphoneBtn addTarget:self action:@selector(microphoneDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _microphoneBtn;
}

@end
