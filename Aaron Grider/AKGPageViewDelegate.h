//
//  AKGPageViewProtocol.h
//  Aaron Grider
//
//  Created by Aaron Grider on 4/11/14.
//  Copyright (c) 2014 Aaron Grider. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AKGPageViewDelegate <NSObject>

- (void)bringForeground:(UIView *)item;
- (void)sendBack:(UIView *)item;
- (void)addParallaxEffect:(UIView *)view effectAmount:(int)amount;

@end

