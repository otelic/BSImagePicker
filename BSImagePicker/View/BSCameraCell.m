//
//  BSCameraCell.m
//  BSImagePicker
//
//  Created by Johan Forssell on 07/10/14.
//  Copyright (c) 2014 Joakim Gyllström. All rights reserved.
//

#import "BSCameraCell.h"

#import <AVFoundation/AVFoundation.h>

@implementation BSCameraCell

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureSession *)session
{
    return [(AVCaptureVideoPreviewLayer *)[self layer] session];
}

- (void)setSession:(AVCaptureSession *)session
{
    [(AVCaptureVideoPreviewLayer *)[self layer] setSession:session];
}

@end
