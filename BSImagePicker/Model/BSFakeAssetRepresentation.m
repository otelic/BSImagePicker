//
//  BSFakeAssetRepresentation.m
//  PeopleThatMake
//
//  Created by Johan Forssell on 2014-06-23.
//  Copyright (c) 2014 People That Make. All rights reserved.
//

#import "BSFakeAssetRepresentation.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface BSFakeAssetRepresentation ()
@property (strong, nonatomic) UIImage *image;
@end

@implementation BSFakeAssetRepresentation

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
    }
    
    return self;
}

- (CGImageRef)fullScreenImage
{
    return [self.image CGImage];
}

- (float)scale
{
    return self.image.scale;
}

- (ALAssetOrientation)orientation
{
    return ALAssetOrientationUp;
}

@end
