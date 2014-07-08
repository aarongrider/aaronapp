//
//  AKGProjectsPageView.m
//  Aaron Grider
//
//  Created by Aaron Grider on 4/9/14.
//  Copyright (c) 2014 Aaron Grider. All rights reserved.
//


#import "AKGMenuViewController.h"
#import "AKGProjectsPageView.h"
#import "AKGProjectViewController.h"

@interface AKGProjectsPageView ()

@property CGRect defaultFrame;
@property CGRect defaultBounds;
@property UIButton *backButton;
@property UILabel *menuLabel;
@property UIScrollView *scrollView;
@property AKGProjectViewController *projectViewOne;
@property AKGProjectViewController *projectViewTwo;
@property UIView *overRect;
@property BOOL expanded;

@end

@implementation AKGProjectsPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Set up our default frame and bounds value
        self.defaultFrame = frame;
        self.defaultBounds = CGRectMake(0, 0, self.defaultFrame.size.width, self.defaultFrame.size.height);
        
        // Set background color
        self.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1];
        
        // Create projects views
        
        // Create a screen-sized scroll view and add it to the window
        _scrollView = [[UIScrollView alloc] initWithFrame:self.defaultBounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scrollView];
        
        // Create project views
        self.projectViewOne  = [[AKGProjectViewController alloc] initWithNibName:@"AKGProjectTwoView" bundle:nil];
        self.projectViewOne.view.bounds = self.defaultBounds;
        self.projectViewOne.view.frame = self.defaultBounds;
        [_scrollView addSubview:self.projectViewOne.view];
        
        _scrollView.contentSize = self.defaultBounds.size;
        
        // View to recognise touches
        _overRect = [[UIView alloc] initWithFrame:self.defaultBounds];
        _overRect.backgroundColor = [UIColor clearColor];
        //_overRect.alpha = 0.3;
        [self addSubview:_overRect];
        
        // Create Title Text
        [self createTitleText];
        
        // We are not currently expanded
        self.expanded = false;
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

// When a finger touches the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // If this is the first touch
    NSLog(@"Touched");
    if (self.expanded == false) [self expandView];
    
    // If not...
}

- (void)expandView
{
    CGRect fullFrame = [[UIScreen mainScreen] applicationFrame];
    
    // Resize the view
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         // Set frame and bounds
                         self.center = CGPointMake(fullFrame.size.width / 2, fullFrame.size.height / 2);
                         self.frame = fullFrame;
                         
                         self.projectViewOne.view.frame = self.bounds;
                         self.projectViewOne.view.bounds = self.bounds;
                         
                         self.scrollView.frame = self.bounds;
                         self.scrollView.bounds = self.bounds;
                         
                         _menuLabel.bounds = self.bounds;
                         _menuLabel.center = self.center;
                         _menuLabel.alpha = 0;
                         
                     }
                     completion:^(BOOL finished){
                         if (finished)
                         {
                             
                         }
                     }];
    
    // Create CGRects for frames
    CGRect screenRect = self.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 4.0;
    
    screenRect.origin.x += screenRect.size.width;
    self.projectViewTwo  = [[AKGProjectViewController alloc] initWithNibName:@"AKGProjectOneView" bundle:nil];
    self.projectViewTwo.view.bounds = screenRect;
    self.projectViewTwo.view.frame = screenRect;
    [_scrollView addSubview:self.projectViewTwo.view];
    
    screenRect.origin.x += screenRect.size.width;
    self.projectViewTwo  = [[AKGProjectViewController alloc] initWithNibName:@"AKGProjectThreeView" bundle:nil];
    self.projectViewTwo.view.bounds = screenRect;
    self.projectViewTwo.view.frame = screenRect;
    [_scrollView addSubview:self.projectViewTwo.view];
    
    screenRect.origin.x += screenRect.size.width;
    self.projectViewTwo  = [[AKGProjectViewController alloc] initWithNibName:@"AKGProjectFourView" bundle:nil];
    self.projectViewTwo.view.bounds = screenRect;
    self.projectViewTwo.view.frame = screenRect;
    [_scrollView addSubview:self.projectViewTwo.view];
    
    _scrollView.contentSize = bigRect.size;
    
    [self sendSubviewToBack:_overRect];
    
    [self.delegate bringForeground:self];
    
    // Create the return to menu button
    _backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.backButton addTarget:self
                        action:@selector(contractView)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.backButton setTitle:@"Back" forState:UIControlStateNormal];
    [self.backButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    self.backButton.frame = CGRectMake(self.frame.size.width - 75, self.frame.size.height - 38, 75.0, 38.0);
    self.backButton.alpha = 0.5;
    [self addSubview:self.backButton];
    
    self.expanded = true;
}

- (void)contractView
{
    [self bringSubviewToFront:_overRect];
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         // Set frame and bounds
                         self.frame = self.defaultFrame;
                         self.bounds = self.defaultBounds;
                         
                         _menuLabel.frame = self.defaultBounds;
                         _menuLabel.bounds = self.defaultBounds;
                         _menuLabel.alpha = .5;
                         
                         self.projectViewOne.view.frame = self.defaultBounds;
                         self.projectViewOne.view.bounds = self.defaultBounds;
                         
                         self.scrollView.frame = self.defaultBounds;
                         
                         self.backButton.alpha = 0;
                         
                     }
                     completion:^(BOOL finished){
                         if (finished)
                         {
                             
                             // Get rid of back button
                             [self.backButton removeFromSuperview];
                             [self.delegate sendBack:self];
                    
                         }
                     }];
    
    self.expanded = false;
}

- (void)createTitleText
{
    _menuLabel = [[UILabel alloc] initWithFrame:self.defaultBounds];
    
    // Configure the label's colors and text
    _menuLabel.font = [UIFont systemFontOfSize:35.0f];
    _menuLabel.textColor = [UIColor blackColor];
    _menuLabel.text = @" Projects";
    _menuLabel.alpha = 0.5;
    
    [self.delegate addParallaxEffect:_menuLabel effectAmount:10];
    
    [self addSubview:_menuLabel];
}

- (void)parallax
{
    [self.delegate addParallaxEffect:self.menuLabel effectAmount:10];
}

@end