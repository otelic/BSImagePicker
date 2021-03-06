//
//  LivePreviewCell.h
//  Pods
//
//  Created by Johan Forssell on 07/10/14.
//
//

#import <UIKit/UIKit.h>
#import "GPUImageView.h"

@interface BSLivePreviewCell : UICollectionViewCell

@property (strong, nonatomic) GPUImageView *livePreviewView;
@property (strong, nonatomic) UIImageView  *overlay;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (GPUImageView *)livePreviewViewAsSubviewWithTintColor:(UIColor *)tintColor;

@end
