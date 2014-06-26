//
//  PTMAsset.m
//  PeopleThatMake
//
//  Created by Johan Forssell on 2014-06-23.
//  Copyright (c) 2014 People That Make. All rights reserved.
//

#import "BSFakeAsset.h"
#import "BSFakeAssetRepresentation.h"

NSString * const BS_NOTIFICATION_CHOOSE_CAMERA = @"BS_NOTIFICATION_CHOOSE_CAMERA";

@interface BSFakeAsset ()
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) BSFakeAssetRepresentation *representation;
@end


@implementation BSFakeAsset

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
        _representation = [[BSFakeAssetRepresentation alloc] initWithImage:self.image];
    }

    return self;
}

- (CGImageRef)thumbnail
{
    return [self.image CGImage];
}

- (ALAssetRepresentation *)defaultRepresentation
{
    return self.representation;
}

@end
