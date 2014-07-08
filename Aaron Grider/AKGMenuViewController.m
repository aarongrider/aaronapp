//
//  AKGMenuViewController.m
//  Aaron Grider
//
//  Created by Aaron Grider on 4/8/14.
//  Copyright (c) 2014 Aaron Grider. All rights reserved.
//

#import "AKGMenuViewController.h"
#import "AKGPageViewDelegate.h"
#import "AKGMapPageView.h"
#import "AKGFeedPageView.h"
#import "AKGProjectsPageView.h"
#import "AKGStoryPageView.h"
#import "AKGContactPageView.h"

@implementation AKGMenuViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self)
    {
        // Insert initializer code here
    }
    
    return self;
}

- (void)loadView
{
    // Create a background view
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor clearColor];
    
    // Create CGRects for frames
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect bigRect = screenRect;
    bigRect.size.height *= 1.2;
    
    // Create a screen-sized scroll view and add it to the window
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    scrollView.pagingEnabled = YES;
    
    [backgroundView addSubview:scrollView];
    
    // Tell the scroll view how big its content area is
    scrollView.contentSize = bigRect.size;
    
    // Create menu views
    AKGMapPageView *mapBoxView = [[AKGMapPageView alloc] initWithFrame:CGRectMake(0, 20, 160, 150)];
    [scrollView addSubview:mapBoxView];
    mapBoxView.delegate = self;
    [mapBoxView parallax];
    
    AKGFeedPageView *feedBoxView = [[AKGFeedPageView alloc] initWithFrame:CGRectMake(160, 20, 160, 150)];
    [scrollView addSubview:feedBoxView];
    feedBoxView.delegate = self;
    [feedBoxView parallax];
    
    AKGProjectsPageView *projectsBoxView = [[AKGProjectsPageView alloc] initWithFrame:CGRectMake(0, 170, 160, 150)];
    [scrollView addSubview:projectsBoxView];
    projectsBoxView.delegate = self;
    [projectsBoxView parallax];
    
    AKGStoryPageView *storyBoxView = [[AKGStoryPageView alloc] initWithFrame:CGRectMake(160, 170, 160, 150)];
    [scrollView addSubview:storyBoxView];
    storyBoxView.delegate = self;
    [storyBoxView parallax];
    
    AKGContactPageView *contactBoxView = [[AKGContactPageView alloc] initWithFrame:CGRectMake(0, 320, 160, 150)];
    [scrollView addSubview:contactBoxView];
    contactBoxView.delegate = self;
    [contactBoxView parallax];
    
    // Set backgroundView as the main view of this controller
    self.view = scrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)bringForeground:(UIView *)item
{
    [self.view bringSubviewToFront:item];
}

- (void)sendBack:(UIView *)item
{
    [self.view sendSubviewToBack:item];
}

- (void)addParallaxEffect:(UIView *)view effectAmount:(int)amount
{
    UIInterpolatingMotionEffect *motionEffect;
    motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionEffect.minimumRelativeValue = @(-amount);
    motionEffect.maximumRelativeValue = @(amount);
    [view addMotionEffect:motionEffect];
    
    motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    motionEffect.minimumRelativeValue = @(-amount);
    motionEffect.maximumRelativeValue = @(amount);
    [view addMotionEffect:motionEffect];
}

@end
