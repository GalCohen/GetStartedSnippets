//
//  ViewController.m
//  ScrollViews
//
//  Created by Gal Cohen on 2/21/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;

@end

@implementation ViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    First, you need to create an image view with the photo1.png image you added to your project and you set the image view frame
//    (it’s size and position) so it’s the size of the image and sits at point 0,0 within the parent. Finally, the image view gets
//    added as a subview of your scroll view.
    UIImage *image = [UIImage imageNamed:@"photo1.png"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    [self.scrollView addSubview:self.imageView];
    
//    You have to tell your scroll view the size of the content contained within it, so that it knows how far it can scroll horizontally and vertically.
//    In this case, it’s the size of the image.You have to tell your scroll view the size of the content contained within it, so that it knows how far it
//    can scroll horizontally and vertically. In this case, it’s the size of the image.
    self.scrollView.contentSize = image.size;
    

//    Here you’re setting up two gesture recognizers: one for the double-tap to zoom in, and one for the two-finger-tap to zoom out. 
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    Next, you need to work out the minimum zoom scale for the scroll view. A zoom scale of one means that the content is displayed at normal size.
//    A zoom scale below one shows the content zoomed out, while a zoom scale of greater than one shows the content zoomed in.
//    To get the minimum zoom scale, you calculate how far you’d need to zoom out so that the image fits snugly in your scroll view’s bounds based on its width.
//    Then you do the same based upon the image’s height. The minimum of those two resulting zoom scales will be the scroll view’s minimum zoom scale. That gives you
//    a zoom scale where you can see the entire image when fully zoomed out.
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.minimumZoomScale = minScale;
    
//    You set the maximum zoom scale as 1, because zooming in more than the image’s resolution can support will cause it to look blurry. You set the initial zoom scale
//    to be the minimum, so that the image starts fully zoomed out.
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
//    this will center the image within the scroll view.
    [self centerScrollViewContents];
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
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
    
    self.imageView.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
//    First, you need to work out where the tap occurred within the image view. You’ll use this to zoom in directly on that point,
//    which is probably what you’d expect as a use
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
//    Next, you calculate a zoom scale that’s zoomed in 150%, but capped at the maximum zoom scale you specified in viewDidLoad.
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
//    Then you use the location from step #1 to calculate a CGRect rectangle that you want to zoom in on.
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
//    Finally, you need to tell the scroll view to zoom in, and here you animate it
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so you need to re-center the contents
    [self centerScrollViewContents];
}

@end
