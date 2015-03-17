//
//  BSVideoCamera.m
//

#import "BSVideoCamera.h"

@implementation BSVideoCamera

+ (instancetype)sharedInstance
{
    static BSVideoCamera *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    if(self = [super init]) {
    }
    
    return self;
}

- (GPUImageVideoCamera *)videoCamera
{
    if (!_videoCamera) {
        _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
        _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        _videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    }
    return _videoCamera;
}

@end
