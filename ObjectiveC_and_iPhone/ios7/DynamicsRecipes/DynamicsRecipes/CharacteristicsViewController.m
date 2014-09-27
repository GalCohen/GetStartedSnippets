//
//  CharacteristicsViewController.m
//  DynamicsRecipes
//
//  Created by Gal Cohen on 3/19/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "CharacteristicsViewController.h"

@interface CharacteristicsViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation CharacteristicsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIView *topView = [self newViewWithCenter:CGPointMake(150.0f, 0.0f)
                              backgroundColor:[UIColor greenColor]];
    UIView *bottomView = [self newViewWithCenter:CGPointMake(100.0f, 50.0f)
                                 backgroundColor:[UIColor redColor]];
    [self.view addSubview:topView];
    [self.view addSubview:bottomView];
    
    
    self.animator = [[UIDynamicAnimator alloc]
                     initWithReferenceView:self.view];
    /* Create gravity */
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]
                                  initWithItems:@[topView, bottomView]];
    [self.animator addBehavior:gravity];
    
    
    /* Create collision detection */
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]
                                      initWithItems:@[topView, bottomView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
    
    /* Now specify the elasticity of the items */
    UIDynamicItemBehavior *moreElasticItem = [[UIDynamicItemBehavior alloc]
                                              initWithItems:@[bottomView]];
    moreElasticItem.elasticity = 1.0f;
    UIDynamicItemBehavior *lessElasticItem = [[UIDynamicItemBehavior alloc]
                                              initWithItems:@[topView]];
    [self.animator addBehavior:moreElasticItem];
    lessElasticItem.elasticity = 0.5f;
    [self.animator addBehavior:lessElasticItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *) newViewWithCenter:(CGPoint)paramCenter backgroundColor:(UIColor *)paramBackgroundColor
{
    UIView *newView =
    [[UIView alloc] initWithFrame:
     CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    newView.backgroundColor = paramBackgroundColor;
    newView.center = paramCenter;
    return newView;
}

@end
