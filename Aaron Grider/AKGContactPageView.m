//
//  AKGContactPageView.m
//  Aaron Grider
//
//  Created by Aaron Grider on 4/11/14.
//  Copyright (c) 2014 Aaron Grider. All rights reserved.
//


#import "AKGContactPageView.h"
#import "AKGMenuViewController.h"
#import "AKGContactViewController.h"

@interface AKGContactPageView ()

@property CGRect defaultFrame;
@property CGRect defaultBounds;
@property UIButton *backButton;
@property UILabel *menuLabel;
@property AKGContactViewController *contactViewController;
@property UIView *overRect;
@property BOOL expanded;

@end

@implementation AKGContactPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Set up our default frame and bounds value
        self.defaultFrame = frame;
        self.defaultBounds = CGRectMake(0, 0, self.defaultFrame.size.width, self.defaultFrame.size.height);

        // Set background color
        self.backgroundColor = [UIColor whiteColor];
        
        self.contactViewController = [[AKGContactViewController alloc] initWithNibName:@"AKGContactView" bundle:nil];
        self.contactViewController.view.bounds = self.defaultBounds;
        self.contactViewController.view.frame = self.defaultBounds;
        [self addSubview:self.contactViewController.view];
        
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
    if (self.expanded == false) [self expandView];
    
    // If not...
}

- (void)expandView
{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // Resize the view
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         // Set frame and bounds
                         self.bounds = [[UIScreen mainScreen] bounds];
                         self.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
                         
                         _menuLabel.bounds = self.bounds;
                         _menuLabel.center = self.center;
                         _menuLabel.alpha = 0;
                         
                     }
                     completion:^(BOOL finished){
                         if (finished)
                         {
                             
                         }
                     }];
    
    [self.delegate bringForeground:self];
    
    // Create the return to menu button
    _backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
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
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
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
    _menuLabel.font = [UIFont systemFontOfSize:40.0f];
    _menuLabel.textColor = [UIColor blackColor];
    _menuLabel.text = @" Skills";
    _menuLabel.alpha = 0.5;
    
    [self.delegate addParallaxEffect:_menuLabel effectAmount:10];
    
    [self addSubview:_menuLabel];
}

- (void)parallax
{
    [self.delegate addParallaxEffect:self.menuLabel effectAmount:10];
}

@end

