//
//  AKGProjectsPageView.h
//  Aaron Grider
//
//  Created by Aaron Grider on 4/9/14.
//  Copyright (c) 2014 Aaron Grider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKGPageViewDelegate.h"

@interface AKGProjectsPageView : UIView

@property (nonatomic, weak) id <AKGPageViewDelegate> delegate;

- (void)expandView;
- (void)contractView;
- (void)parallax;

@end