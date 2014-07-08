//
//  AKGContactViewController.m
//  Aaron Grider
//
//  Created by Aaron Grider on 4/13/14.
//  Copyright (c) 2014 Aaron Grider. All rights reserved.
//

#import "AKGContactViewController.h"
#import <MessageUI/MessageUI.h>

@interface AKGContactViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation AKGContactViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resumeButton:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://aarongrider.com/resume"]];
}

- (IBAction)facebookButton:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com/aarongrider"]];
}

- (IBAction)linkedinButton:(id)sender
{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://linkedin.com/in/aarongrider"]];
}

- (IBAction)emailButton:(id)sender
{
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setToRecipients:[NSArray arrayWithObjects: @"aaron.grider@gmail.com",nil]];
    [mailComposer setSubject:[NSString stringWithFormat: @"Aaron Grider App"]];
    [self presentViewController:mailComposer animated:YES completion:nil];

}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
