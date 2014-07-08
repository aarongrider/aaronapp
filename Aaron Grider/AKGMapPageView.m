//
//  AKGMapPageView.m
//  Aaron Grider
//
//  Created by Aaron Grider on 4/8/14.
//  Copyright (c) 2014 Aaron Grider. All rights reserved.
//

#import "AKGMapPageView.h"
#import "AKGMenuViewController.h"
#import "AKGMapAnnotation.h"

@interface AKGMapPageView ()

@property CGRect defaultFrame;
@property CGRect defaultBounds;
@property UIButton *backButton;
@property (nonatomic, strong) MKMapView *map;
@property UILabel *menuLabel;
@property BOOL expanded;

@end

@implementation AKGMapPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Set up our default frame and bounds value
        self.defaultFrame = frame;
        self.defaultBounds = CGRectMake(0, 0, self.defaultFrame.size.width, self.defaultFrame.size.height);
        
        // Set background color
        self.backgroundColor = [UIColor clearColor];
        
        // Create map object
        [self createMap];
        
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
    // Resize the view
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         // Set frame and bounds
                         self.bounds = [[UIScreen mainScreen] bounds];
                         self.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
                         
                         _map.bounds = self.bounds;
                         _map.center = self.center;
                         
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
    [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.backButton addTarget:self
                        action:@selector(contractView)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.backButton setTitle:@"Back" forState:UIControlStateNormal];
    [self.backButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    self.backButton.frame = CGRectMake(self.frame.size.width - 75, self.frame.size.height - 38, 75.0, 38.0);
    self.backButton.alpha = 0.5;
    //self.backButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self addSubview:self.backButton];
    
    self.expanded = true;
}

- (void)contractView
{
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         // Set frame and bounds
                         self.frame = self.defaultFrame;
                         self.bounds = self.defaultBounds;
                         
                         _map.frame = self.defaultBounds;
                         _map.bounds = self.defaultBounds;
                         
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
    _menuLabel.text = @" Map";
    _menuLabel.alpha = 0.5;
    
    [self addSubview:_menuLabel];
}

- (void)createMap
{
    _map = [[MKMapView alloc] init];
    _map.frame = self.defaultBounds;
    _map.bounds = self.defaultBounds;
    
    // Add pins
    MapPin *homePin = [[MapPin alloc] initWithCoordinates:CLLocationCoordinate2DMake(42.450257, -83.408978) placeName:@"Home" description:@"This is where I grew up"];
    [_map addAnnotation:homePin];
    
    MapPin *spuPin = [[MapPin alloc] initWithCoordinates:CLLocationCoordinate2DMake(47.651503, -122.361359) placeName:@"Seattle Pacific University" description:@"Where I currently attend college"];
    [_map addAnnotation:spuPin];
    
    MapPin *jamaicaPin = [[MapPin alloc] initWithCoordinates:CLLocationCoordinate2DMake(18.4666700, -77.9167) placeName:@"Jamaica Deaf School" description:@"Traveled here on a humanitarian trip"];
    [_map addAnnotation:jamaicaPin];
    
    MapPin *umPin = [[MapPin alloc] initWithCoordinates:CLLocationCoordinate2DMake(42.276127, -83.740923) placeName:@"University of Michigan" description:@"Attended college here for 2 years"];
    [_map addAnnotation:umPin];
    
    MapPin *applePin = [[MapPin alloc] initWithCoordinates:CLLocationCoordinate2DMake(37.331741, -122.030333) placeName:@"Apple" description:@"World's greatest company"];
    [_map addAnnotation:applePin];
    
    MapPin *subsplashPin = [[MapPin alloc] initWithCoordinates:CLLocationCoordinate2DMake(47.650106, -122.377830) placeName:@"Subsplash" description:@"My internship this summer, making apps!"];
    [_map addAnnotation:subsplashPin];
    
    [self addSubview:_map];
}

- (void)parallax
{
    [self.delegate addParallaxEffect:self.menuLabel effectAmount:10];
}

@end

