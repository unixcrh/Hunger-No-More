//
//  FulfillDetailViewController.m
//  Hunger No More
//
//  Created by John Luttig on 7/14/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import "FulfillRequestViewController.h"

@interface FulfillRequestViewController ()

@end

@implementation FulfillRequestViewController

@synthesize request, delegate, doneButton, fulfillButton;

@synthesize orgNameLabel, contactLabel, websiteLabel, addressLabel, neededByLabel, descriptionLabel, emailLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) fillFields
{
    [orgNameLabel setText:[request valueForKey:@"orgname"]];
    [descriptionLabel setText:[request valueForKey:@"requestdescription"]];
    [contactLabel setText:[request valueForKey:@"personname"]];
    [addressLabel setText:[NSString stringWithFormat:@"%@, %@",[request valueForKey:@"orgaddress"], [request valueForKey:@"orgcity"]]];
    [neededByLabel setText:[request valueForKey:@"neededbydate"]];
    [websiteLabel setText:[request valueForKey:@"orgwebsite"]];
    [emailLabel setText:[request valueForKey:@"contactemail"]];
    NSLog(@"filled fields");
}

- (IBAction)done:(id)sender
{
    [[self delegate] dismissDetail];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    doneButton.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    doneButton.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    doneButton.radius = 3.0;
    doneButton.margin = 2.0;
    doneButton.depth = 2.0;
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    fulfillButton.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    fulfillButton.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    fulfillButton.radius = 3.0;
    fulfillButton.margin = 2.0;
    fulfillButton.depth = 2.0;
    [fulfillButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fulfill:(id)sender
{
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:[NSArray arrayWithObject:[request valueForKey:@"contactemail"]]];
    [controller setSubject:@"Hunger No More - Request Fulfillment"];
    NSString *message = [NSString stringWithFormat:@"Hi! I saw your request for %@. I'm happy to fulfill this request for you. Please contact me so that we can coordinate a pickup point for your item. Thanks!", [request valueForKey:@"orgname"]];
    [controller setMessageBody:message isHTML:NO];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self becomeFirstResponder];
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end