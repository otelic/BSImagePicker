//
//  LivePreviewCell.m
//  Pods
//
//  Created by Johan Forssell on 07/10/14.
//
//

#import "BSLivePreviewCell.h"

@implementation BSLivePreviewCell

- (void)commonInit
{
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Not selectable

- (void)setSelected:(BOOL)selected {
    [self setSelected:NO animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO];
}

#pragma mark - Camera view

- (GPUImageView *)livePreviewViewAsSubviewWithTintColor:(UIColor *)tintColor
{
    if (!self.livePreviewView) {
        self.livePreviewView = [[GPUImageView alloc] initWithFrame:self.bounds];
        self.livePreviewView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
        [self addSubview:self.livePreviewView];
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CameraOverlay" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *filePath = [bundle pathForResource:@"camera-on-tile@2x" ofType:@"png"];
        UIImage *overlay = [[UIImage imageWithContentsOfFile:filePath] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.overlay = [[UIImageView alloc] initWithFrame:self.bounds];
        self.overlay.image = overlay;
        self.overlay.tintColor = tintColor;
        [self addSubview:self.overlay];
    }
    
    return self.livePreviewView;
}

- (void)setTintColor:(UIColor *)tintColor
{
    tintColor = tintColor;
    self.overlay.tintColor = tintColor;
}

@end
