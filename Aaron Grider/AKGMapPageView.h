//
//  AKGPageView.h
//  Aaron Grider
//
//  Created by Aaron Grider on 4/8/14.
//  Copyright (c) 2014 Aaron Grider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AKGPageViewDelegate.h"

@interface AKGMapPageView : UIView

@property (nonatomic, weak) id <AKGPageViewDelegate> delegate;

- (void)expandView;
- (void)contractView;
- (void)parallax;

@end

