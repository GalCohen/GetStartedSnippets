//
//  FourthViewController.m
//  UIComponents
//
//  Created by Gal Cohen on 3/18/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, strong) UIScrollView *myScrollView;
@end

@implementation FourthViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // ImageView
//    UIImage *galaxy = [UIImage imageNamed:@"galaxy"];
    
//    self.myImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    self.myImageView.image = galaxy;
//    self.myImageView.center = self.view.center;
//    [self.view addSubview:self.myImageView];
    
//    self.myImageView = [[UIImageView alloc] initWithImage:galaxy];
//    self.myScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    [self.myScrollView addSubview:self.myImageView];
//    self.myScrollView.contentSize = self.myImageView.bounds.size;
//    self.myScrollView.delegate = self;
////    self.myScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
//    [self.view addSubview:self.myScrollView];
    
    UIImage *galaxy = [UIImage imageNamed:@"galaxy"];
    UIImage *elephant = [UIImage imageNamed:@"elephant"];
    UIImage *frog = [UIImage imageNamed:@"frog"];
    CGRect scrollViewRect = self.view.bounds;
    self.myScrollView = [[UIScrollView alloc] initWithFrame:scrollViewRect];
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.contentSize = CGSizeMake(scrollViewRect.size.width * 3.0f,
                                               scrollViewRect.size.height);
    [self.view addSubview:self.myScrollView];
    CGRect imageViewRect = self.view.bounds;
    UIImageView *iPhoneImageView = [self newImageViewWithImage:galaxy
                                                         frame:imageViewRect];
    [self.myScrollView addSubview:iPhoneImageView];
    /* Go to next page by moving the x position of the next image view */
    imageViewRect.origin.x += imageViewRect.size.width;
    UIImageView *iPadImageView = [self newImageViewWithImage:elephant
                                                       frame:imageViewRect];
    [self.myScrollView addSubview:iPadImageView];
    /* Go to next page by moving the x position of the next image view */
    imageViewRect.origin.x += imageViewRect.size.width;
    UIImageView *macBookAirImageView =
    [self newImageViewWithImage:frog
                          frame:imageViewRect];
    [self.myScrollView addSubview:macBookAirImageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scroll Protocol

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /* Gets called when user scrolls or drags */
    self.myScrollView.alpha = 0.50f;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    /* Gets called only after scrolling */
    self.myScrollView.alpha = 1.0f;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    /* Make sure the alpha is reset even if the user is dragging */
    self.myScrollView.alpha = 1.0f;
}


- (UIImageView *) newImageViewWithImage:(UIImage *)paramImage frame:(CGRect)paramFrame{
    UIImageView *result = [[UIImageView alloc] initWithFrame:paramFrame]; result.contentMode = UIViewContentModeScaleAspectFit;
    result.image = paramImage;
    return result;
}

@end
