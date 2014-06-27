//
//  BSScrollDelegate.h
//  BSImagePicker
//
//  Created by Johan Forssell on 2014-06-27.
//  Copyright (c) 2014 Joakim Gyllström. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BSScrollDelegate <NSObject>

@optional
- (void)bsScrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)bsScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)bsScrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)bsScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
