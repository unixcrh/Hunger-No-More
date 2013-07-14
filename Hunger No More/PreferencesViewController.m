//
//  SettingsViewController.m
//  Hunger No More
//
//  Created by John Luttig on 7/13/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import "PreferencesViewController.h"

@interface PreferencesViewController ()

@end

@implementation PreferencesViewController

@synthesize addressField, cityField, stateField, zipField, emailField, nameField, scrollView;

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
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"email"] != nil) {
        [emailField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"email"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"name"] != nil) {
        [nameField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"name"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"address"] != nil) {
        [addressField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"address"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"city"] != nil) {
        [cityField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"city"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"state"] != nil) {
        [stateField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"state"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"zip"] != nil) {
        [zipField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"zip"]];
    }
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoplainlarge.png"]];
    backgroundImage.frame = CGRectMake(backgroundImage.frame.origin.x-40, backgroundImage.frame.origin.y+200, backgroundImage.frame.size.width, backgroundImage.frame.size.height);
    backgroundImage.alpha = 0.3;
    
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"returning");
    if (textField.returnKeyType == UIReturnKeyNext) {
        NSLog(@"setting first responder to #%i", textField.tag+1);
        [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
    }
    else {
        [self done];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //CGPoint svos = scrollView.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [scrollView setContentOffset:pt animated:YES];
}

- (void)done
{
    NSLog(@"done with settings.");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[nameField text] forKey:@"name"];
    [defaults synchronize];
    [defaults setObject:[emailField text] forKey:@"email"];
    [defaults synchronize];
    [defaults setObject:[addressField text] forKey:@"address"];
    [defaults synchronize];
    [defaults setObject:[cityField text] forKey:@"city"];
    [defaults synchronize];
    [defaults setObject:[stateField text] forKey:@"state"];
    [defaults synchronize];
    [defaults setObject:[zipField text] forKey:@"zip"];
    [defaults synchronize];
    
    [self.view endEditing:YES];
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height - 15);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
