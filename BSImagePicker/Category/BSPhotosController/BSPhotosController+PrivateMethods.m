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

#import "BSPhotosController+PrivateMethods.h"
#import "BSImagePickerSettings.h"

@implementation BSPhotosController (PrivateMethods)

#pragma mark - Button actions

- (void)finishButtonPressed:(id)sender {
    //Cancel or finish? Call correct block!
    if(sender == self.cancelButton) {
        if([[BSImagePickerSettings sharedSetting] cancelBlock]) {
            [BSImagePickerSettings sharedSetting].cancelBlock([self.collectionModel.selectedItems copy]);
        }
    } else {
        if([[BSImagePickerSettings sharedSetting] finishBlock]) {
            [BSImagePickerSettings sharedSetting].finishBlock([self.collectionModel.selectedItems copy]);
        }
    }

    //Remove selections if user doesn't want to keep them
    if(![[BSImagePickerSettings sharedSetting] keepSelection]) {
        [self.collectionModel clearSelection];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)albumButtonPressed:(id)sender {
    if([self.chooseAlbumView isDescendantOfView:self.navigationController.view]) {
    [self hideAlbumView];
    } else {
        [self showAlbumView];
    }
}

#pragma mark - Show and hide album view

- (void)showAlbumView {
    [[NSNotificationCenter defaultCenter] postNotificationName:BSIMAGEPICKER_SHOW_ALBUM_VIEW_NOTIFICATION object:nil userInfo:nil];
    
    [self.navigationController.view addSubview:self.coverView];
    [self.navigationController.view addSubview:self.chooseAlbumView];
    
    CGFloat tableViewHeight = MIN(self.tableView.contentSize.height, 240);
    CGRect frame = CGRectMake(0, 0, self.chooseAlbumView.frame.size.width, tableViewHeight+7);
    
    //Remember old values
    CGFloat height = frame.size.height;
    CGFloat width = frame.size.width;

    //Set new frame
    frame.size.height = 0.0;
    frame.size.width = 0.0;
    frame.origin.y = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height/2.0;
    frame.origin.x = (self.view.frame.size.width - frame.size.width)/2.0;
    [self.chooseAlbumView setFrame:frame];
    
    [UIView animateWithDuration:0.7
                          delay:0.0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0
                        options:0
                     animations:^{
        CGRect frame = self.chooseAlbumView.frame;
        frame.size.height = height;
        frame.size.width = width;
        frame.origin.y = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
        frame.origin.x = (self.view.frame.size.width - frame.size.width)/2.0;
        [self.chooseAlbumView setFrame:frame];

        [self.coverView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
    } completion:nil];
}

- (void)hideAlbumView {
    
    __block CGAffineTransform origTransForm = self.chooseAlbumView.transform;
    CGRect end_frame = CGRectMake(self.chooseAlbumView.frame.origin.x, self.chooseAlbumView.frame.origin.y, self.chooseAlbumView.frame.size.width, 0);
    
    [UIView animateWithDuration:0.2f animations:^{
        self.chooseAlbumView.frame = end_frame;
        [self.coverView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];

    } completion:^(BOOL finished) {
        [self.chooseAlbumView removeFromSuperview];
        [self.coverView removeFromSuperview];
        self.chooseAlbumView.alpha = 1;
        self.chooseAlbumView.transform = origTransForm;
    }];
}

#pragma mark - GestureRecognizer

- (void)itemLongPressed:(UIGestureRecognizer *)recognizer {
    if(recognizer.state == UIGestureRecognizerStateBegan && ![[BSImagePickerSettings sharedSetting] previewDisabled]) {
        [recognizer setEnabled:NO];

        CGPoint location = [recognizer locationInView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];

        [self.previewController setCollectionModel:self.collectionModel];
        [self.previewController setCurrentIndexPath:indexPath];
        [self.navigationController pushViewController:self.previewController animated:YES];

        [recognizer setEnabled:YES];
    }
}

@end