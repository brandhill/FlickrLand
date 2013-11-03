//
//  FLPhotoViewerViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/2.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLPhotoViewerViewController.h"
#import "FLAppTheme.h"
#import "UIImageView+AFNetworking.h"
#import "FLUserData.h"
#import "FlickrKit.h"

@interface FLPhotoViewerViewController ()

@end

@implementation FLPhotoViewerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImage *borderImage = [UIImage imageWithSize:CGSizeMake(54, 54) Color:[UIColor colorWithWhite:1 alpha:0.75] radius:27];
    [_profileBorderView setImage:borderImage];
    
    
    //Set User
    _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 50, 50)];
    [_profileImageView setImage:[UIImage imageNamed:@"placeHolder_userProfile-blue"]];
    [_profileImageView.layer setCornerRadius:25.0f];
    [_profileImageView.layer setMasksToBounds:YES];
    [_profileBorderView addSubview:_profileImageView];
    
    FLUserData *owner = _photoData.owner;
    NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200", owner.facebookID];
    NSURL *profileUrl = [NSURL URLWithString:urlString];
    [_profileImageView setImageWithURL:profileUrl];
    
    if (owner.facebookName.length > 0) {
        [_userNameLabel setText:owner.facebookName];
    }
    else {
        [_userNameLabel setText:owner.flickrName];
    }
    
    //Set Photo
    NSURL *photoUrl = [NSURL URLWithString:_photoData.sourceL];
    
    _photoImageView = [[UIImageView alloc] init];
    __weak UIImageView *photoIamgeViewPointer = _photoImageView;
    __weak UIScrollView *photoScrollViewPointer = _photoScrollView;
    __weak FLPhotoViewerViewController *selfPointer = self;
    __weak UIActivityIndicatorView *indicatorPointer = _indicatorView;
    [_photoImageView setImageWithURLRequest:[NSURLRequest requestWithURL:photoUrl] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        [photoIamgeViewPointer setImage:image];
        [photoIamgeViewPointer setFrameSize:image.size];
        [photoScrollViewPointer setDelegate:selfPointer];
        
        CGRect scrollViewFrame = photoScrollViewPointer.frame;
        CGFloat scaleWidth = scrollViewFrame.size.width / image.size.width;
        CGFloat scaleHeight = scrollViewFrame.size.height / image.size.height;
        CGFloat minScale = MIN(scaleWidth, scaleHeight);
        photoScrollViewPointer.minimumZoomScale = minScale;
        
        photoScrollViewPointer.maximumZoomScale = MAX(scaleHeight, 1.0f);
        photoScrollViewPointer.zoomScale = minScale;
        
        [selfPointer centerScrollViewContents];
        [indicatorPointer stopAnimating];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    [_photoScrollView addSubview:_photoImageView];
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [_photoScrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped:)];
    [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
    [_photoScrollView addGestureRecognizer:tapRecognizer];
}

- (void)viewDidLayoutSubviews {
    
    //Fetch Discription
    __weak UITextView *textViewPointer = _discriptionTextView;
    [[FlickrKit sharedFlickrKit] call:@"flickr.photos.getInfo" args:@{@"photo_id":_photoData.photoID} maxCacheAge:FKDUMaxAgeNeverCache completion:^(NSDictionary *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response) {
                
                NSString *discription = response[@"photo"][@"description"][@"_content"];
                if (discription == nil || discription.length <= 0) discription = @"No Discription";
                
                [textViewPointer setText:discription];
                [textViewPointer setFont:[UIFont systemFontOfSize:14.0f]];
                [textViewPointer setTextColor:[UIColor whiteColor]];
                [textViewPointer setHidden:NO];
                [textViewPointer setAlpha:0];
                [UIView animateWithDuration:0.35f animations:^{
                    [textViewPointer setAlpha:1];
                }];
                
            } else {
            }
        });
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI Events
- (IBAction)cancelButton_touchUpInside:(UIButton *)sender {
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:_originViewContoller.navigationController.view.frame];
    [backgroundView setBackgroundColor:[UIColor colorWithWhite:68/255.0f alpha:1]];
    [backgroundView setAlpha:0.25f];
    [_originViewContoller.navigationController.view addSubview:backgroundView];
    
    UIView *originSnapShot = _originViewContoller.view;
    [originSnapShot setTransform:CGAffineTransformMakeScale(0.8f, 0.8f)];
    //[_originViewContoller.navigationController.view addSubview:originSnapShot];
    //[_originViewContoller.view setHidden:YES];
    
    UIView *currentSnapShot = [self.view snapshotViewAfterScreenUpdates:YES];
    [_originViewContoller.navigationController.view addSubview:currentSnapShot];
    
    [UIView animateWithDuration:0.45f delay:0 usingSpringWithDamping:1.0f initialSpringVelocity:10.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [backgroundView setAlpha:0];
        [originSnapShot setTransform:CGAffineTransformMakeScale(1, 1)];
        [currentSnapShot setFrameOrigin:CGPointMake(0, 568)];
    } completion:^(BOOL finished) {
        
        //[originSnapShot removeFromSuperview];
        [currentSnapShot removeFromSuperview];
        [_originViewContoller.view setHidden:NO];
        [backgroundView removeFromSuperview];
    }];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.photoScrollView.bounds.size;
    CGRect contentsFrame = self.photoImageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.photoImageView.frame = contentsFrame;
}

- (void)scrollViewTapped:(UITapGestureRecognizer *)recognizer {
    
    [_photoScrollView setZoomScale:_photoScrollView.minimumZoomScale animated:YES];
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    
    CGPoint pointInView = [recognizer locationInView:_photoImageView];
    
    CGFloat newZoomScale = _photoScrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, _photoScrollView.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = _photoScrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    [_photoScrollView zoomToRect:rectToZoomTo animated:YES];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return _photoImageView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
    [UIView animateWithDuration:0.35f animations:^{
        
        self.cancelButton.alpha = 0;
        self.starButton.alpha = 0;
        self.profileBorderView.alpha = 0;
        self.userNameLabel.alpha = 0;
        self.discriptionTextView.alpha = 0;
    }];
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    
    [_photoImageView setCenter:CGPointMake(xcenter, ycenter)];
    
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    if (scale <= scrollView.minimumZoomScale) {
        [UIView animateWithDuration:0.35f animations:^{
            
            self.cancelButton.alpha = 1;
            self.starButton.alpha = 1;
            self.profileBorderView.alpha = 1;
            self.userNameLabel.alpha = 1;
            self.discriptionTextView.alpha = 1;
        }];
    }
}

@end
