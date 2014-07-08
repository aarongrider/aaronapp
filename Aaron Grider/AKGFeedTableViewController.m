//
//  AKGFeedTableViewController.m
//  Aaron Grider
//
//  Created by Aaron Grider on 4/11/14.
//  Copyright (c) 2014 Aaron Grider. All rights reserved.
//

#import "AKGFeedTableViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface AKGFeedTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tweetTableView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation AKGFeedTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    return self;
}


- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self twitterTimeline];
    
    [self.tweetTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)twitterTimeline
{
    
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType
                                     options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount =
                 [arrayOfAccounts lastObject];
                 
                 NSURL *requestURL = [NSURL URLWithString:
                                      @"https://api.twitter.com/1.1/statuses/user_timeline.json"];
                 
                 NSDictionary *parameters =
                 @{@"screen_name" : @"@aarongrider",
                   @"include_rts" : @"0",
                   @"trim_user" : @"1",
                   @"count" : @"100"};
                 
                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:parameters];
                 
                 postRequest.account = twitterAccount;
                 
                 [postRequest performRequestWithHandler:
                  ^(NSData *responseData, NSHTTPURLResponse
                    *urlResponse, NSError *error)
                  {
                      self.dataSource = [NSJSONSerialization
                                         JSONObjectWithData:responseData
                                         options:NSJSONReadingMutableLeaves
                                         error:&error];
                      
                      if (self.dataSource.count != 0) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [self.tweetTableView reloadData];
                          });
                      }
                  }];
             }
         } else {
             
             // Handle failure to get account access
         }
     }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Returns the number of rows for the table view using the array instance variable.
    
    return [_dataSource count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Creates each cell for the table view.
    
    static NSString *cellID =  @"CELLID" ;
    
    UITableViewCell *cell = [self.tweetTableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    // Creates an NSDictionary that holds the user's posts and then loads the data into each cell of the table view.
    
    NSDictionary *tweet = _dataSource[indexPath.row];
    
    UIFont *newFont = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.font  = newFont;
    
    cell.textLabel.text = tweet[@"text"];
    cell.textLabel.numberOfLines = 2;
    [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tweetTableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
