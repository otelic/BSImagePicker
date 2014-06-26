//
//  PTMAsset.h
//  PeopleThatMake
//
//  Created by Johan Forssell on 2014-06-23.
//  Copyright (c) 2014 People That Make. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

extern NSString * const BS_NOTIFICATION_CHOOSE_CAMERA;


@interface BSFakeAsset : ALAsset

- (instancetype)initWithImage:(UIImage *)image;

@end
