//
//  BSCameraCell.h
//  BSImagePicker
//
//  Created by Johan Forssell on 07/10/14.
//  Copyright (c) 2014 Joakim Gyllström. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface BSCameraCell : UICollectionViewCell

@property (nonatomic) AVCaptureSession *session;

@end
