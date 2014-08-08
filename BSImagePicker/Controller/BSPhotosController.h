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

#import "BSScrollDelegate.h"
#import "BSCollectionController.h"
#import "BSTableViewCellFactory.h"
#import "BSPreviewController.h"
#import "BSZoomOutAnimator.h"
#import "BSZoomInAnimator.h"



@interface BSPhotosController : BSCollectionController

extern NSString * const BSIMAGEPICKER_SHOW_ALBUM_VIEW_NOTIFICATION;
extern NSString * const BSIMAGEPICKER_HIDE_ALBUM_VIEW_NOTIFICATION;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) id<BSItemsModel> tableModel;
@property (nonatomic, strong) id<BSTableViewCellFactory> tableCellFactory;

@property (nonatomic, strong) UIView *chooseAlbumView;
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UIBarButtonItem *cancelButton;
@property (nonatomic, strong) UIButton *albumButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;

@property (nonatomic, strong) BSPreviewController *previewController;

@property (nonatomic, strong) BSZoomInAnimator *zoomInAnimator;
@property (nonatomic, strong) BSZoomOutAnimator *zoomOutAnimator;

@property (nonatomic, weak) id<BSScrollDelegate>scrollDelegate;

@end