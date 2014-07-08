//
//  AKGStoryViewController.m
//  Aaron Grider
//
//  Created by Aaron Grider on 4/11/14.
//  Copyright (c) 2014 Aaron Grider. All rights reserved.
//

#import "AKGStoryViewController.h"
#import "AKGProjectViewController.h"

@interface AKGStoryViewController ()

@end

@implementation AKGStoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    AKGProjectViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (AKGProjectViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    NSString *nibName;
    
    if (index == 0) nibName = @"AKGStoryOne";
    if (index == 1) nibName = @"AKGStoryTwo";
    if (index == 2) nibName = @"AKGStoryThree";
    if (index == 3) nibName = @"AKGStoryFour";
    if (index == 4) nibName = @"AKGStoryFive";
    
    AKGProjectViewController *childViewController = [[AKGProjectViewController alloc] initWithNibName:nibName bundle:nil];
    
    childViewController.index = index;
    
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(AKGProjectViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(AKGProjectViewController *)viewController index];
    
    index++;
    
    if (index == 5) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 5;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

@end
