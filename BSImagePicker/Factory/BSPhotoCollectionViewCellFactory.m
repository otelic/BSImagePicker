// The MIT License (MIT)
//
// Copyright (c) 2014 Joakim Gyllström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <AssetsLibrary/AssetsLibrary.h>
#import "BSPhotoCollectionViewCellFactory.h"
#import "BSPhotoCell.h"
#import "BSVideoCell.h"
#import "BSLivePreviewCell.h"
#import "BSFakeAsset.h"

#import "BSVideoCamera.h"


static NSString *kPhotoCellIdentifier =             @"photoCellIdentifier";
static NSString *kVideoCellIdentifier =             @"videoCellIdentifier";
static NSString *kLiveCellIdentifier  =             @"liveCellIdentifier";

@implementation BSPhotoCollectionViewCellFactory

+ (void)registerCellIdentifiersForCollectionView:(UICollectionView *)aCollectionView {
    [aCollectionView registerClass:[BSPhotoCell class] forCellWithReuseIdentifier:kPhotoCellIdentifier];
    [aCollectionView registerClass:[BSVideoCell class] forCellWithReuseIdentifier:kVideoCellIdentifier];
    [aCollectionView registerClass:[BSLivePreviewCell class] forCellWithReuseIdentifier:kLiveCellIdentifier];
}

+ (CGSize)sizeAtIndexPath:(NSIndexPath *)anIndexPath forCollectionView:(UICollectionView *)aCollectionView withModel:(id<BSItemsModel>)aModel {
    CGSize itemSize = CGSizeZero;
    ALAsset *asset = [aModel itemAtIndexPath:anIndexPath];
    
    if([asset isKindOfClass:[ALAsset class]]) {
        itemSize = [[self class] calcSizeForAsset:asset inSection:anIndexPath.section forCollectionView:aCollectionView withModel:aModel];
    }
    
    return itemSize;
}

+ (UIEdgeInsets)edgeInsetAtSection:(NSUInteger)aSection forCollectionView:(UICollectionView *)aCollectionView withModel:(id<BSItemsModel>)aModel {
    return UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
}

+ (CGFloat)minimumLineSpacingAtSection:(NSUInteger)aSection forCollectionView:(UICollectionView *)aCollectionView withModel:(id<BSItemsModel>)aModel {
    return 2.0;
}

+ (CGFloat)minimumItemSpacingAtSection:(NSUInteger)aSection forCollectionView:(UICollectionView *)aCollectionView withModel:(id<BSItemsModel>)aModel {
    return 2.0;
}

+ (CGSize)calcSizeForAsset:(ALAsset *)asset inSection:(NSInteger)section forCollectionView:(UICollectionView *)aCollectionView withModel:(id<BSItemsModel>)aModel
{
    //Get thumbnail size
    CGSize thumbnailSize = CGSizeMake(CGImageGetWidth(asset.thumbnail), CGImageGetHeight(asset.thumbnail));
    
    //We want 3 images in each row. So width should be viewWidth-(4*LEFT/RIGHT_INSET)/3
    //Height should be adapted so we maintain the aspect ratio of thumbnail
    //original height / original width * new width
    
    UIEdgeInsets sectionInsets = [[self class] edgeInsetAtSection:section forCollectionView:aCollectionView withModel:aModel];
    CGFloat minItemSpacing = [[self class] minimumItemSpacingAtSection:section forCollectionView:aCollectionView withModel:aModel];
    
    CGSize itemSize = CGSizeMake((aCollectionView.bounds.size.width - (sectionInsets.left + 2*minItemSpacing + sectionInsets.right))/3.0, 100);
    if ([asset isKindOfClass:[BSFakeAsset class]]) {
        itemSize = CGSizeMake(itemSize.width, itemSize.width);
    }
    else {
        itemSize = CGSizeMake(itemSize.width, thumbnailSize.height / thumbnailSize.width * itemSize.width);
    }
    
    return itemSize;
}

- (UICollectionViewCell *)cellAtIndexPath:(NSIndexPath *)anIndexPath forCollectionView:(UICollectionView *)aCollectionView withModel:(id<BSItemsModel>)aModel {
    ALAsset *asset = [aModel itemAtIndexPath:anIndexPath];
    
    //Deque correct type of cell for the asset
    BSPhotoCell *photoCell = nil;
    if([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
        photoCell = [aCollectionView dequeueReusableCellWithReuseIdentifier:kVideoCellIdentifier forIndexPath:anIndexPath];
        if([asset valueForProperty:ALAssetPropertyDuration] != ALErrorInvalidProperty) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"mm:ss"];
            
            [[(BSVideoCell *)photoCell durationLabel] setText:[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[asset valueForProperty:ALAssetPropertyDuration] doubleValue]]]];
        }
    } else if ([asset isKindOfClass:[BSFakeAsset class]]) {
        photoCell = [aCollectionView dequeueReusableCellWithReuseIdentifier:kLiveCellIdentifier forIndexPath:anIndexPath];
        
        GPUImageVideoCamera *videoCamera = [[BSVideoCamera sharedInstance] videoCamera];
        GPUImageView *liveVideoView = [((BSLivePreviewCell *)photoCell) livePreviewViewAsSubviewWithTintColor:aCollectionView.tintColor];
        
        [videoCamera addTarget:liveVideoView];
        [videoCamera startCameraCapture];    
    }
    else {
        photoCell = [aCollectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellIdentifier forIndexPath:anIndexPath];
    }
    
    if([asset isKindOfClass:[ALAsset class]] && [photoCell respondsToSelector:@selector(imageView)]) {
        [photoCell.imageView setImage:[UIImage imageWithCGImage:asset.thumbnail]];
    }
    
    [photoCell setSelected:[aModel isItemAtIndexPathSelected:anIndexPath] animated:NO];
    
    photoCell.tintColor = aCollectionView.tintColor;
    
    return photoCell;
}

@end
