//
//  FulfillOfferViewController.m
//  Hunger No More
//
//  Created by John Luttig on 7/14/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import "FulfillOfferViewController.h"

@interface FulfillOfferViewController ()

@end

@implementation FulfillOfferViewController

@synthesize offer, delegate, doneButton, fulfillButton;

@synthesize typeLabel, descriptionLabel, usebyLabel, amountLabel, emailLabel, addressLabel;

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
    [typeLabel setText:[NSString stringWithFormat:@"%@ %@", [offer valueForKey:@"metric"], [offer valueForKey:@"offertype"]]];
    [descriptionLabel setText:[offer valueForKey:@"offerdescription"]];
    [usebyLabel setText:[offer valueForKey:@"usebydate"]];
    [addressLabel setText:[NSString stringWithFormat:@"%@, %@",[offer valueForKey:@"pickupaddress"], [offer valueForKey:@"pickupcity"]]];
    [emailLabel setText:[offer valueForKey:@"contactemail"]];
    [amountLabel setText:[offer valueForKey:@"amount"]];
    
    NSLog(@"filled offer fields");
}

- (IBAction)done:(id)sender
{
    [[self delegate] dismissDetail];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    [controller setToRecipients:[NSArray arrayWithObject:[offer valueForKey:@"contactemail"]]];
    [controller setSubject:@"Hunger No More - Request Fulfillment"];
    NSString *message = [NSString stringWithFormat:@"Hi! I saw your offer for %@. I'm happy to accept your gracious donation. Please contact me so that we can coordinate a pickup point for your item. Thanks!", [offer valueForKey:@"offertype"]];
    [controller setMessageBody:message isHTML:NO];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self becomeFirstResponder];
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end