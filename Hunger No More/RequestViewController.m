//
//  RequestViewController.m
//  Hunger No More
//
//  Created by John Luttig on 7/13/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import "RequestViewController.h"
#import "StackMob.h"

@interface RequestViewController ()

@end

@implementation RequestViewController

@synthesize personNameField, organizationAddressField, organizationCityField, organizationNameField, organizationStateField, organizationWebsiteField, organizationZIPField, requestDescriptionField, neededByPicker, submitButton, scrollView, placemark, contactEmailField;

@synthesize managedObjectContext = _managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //textFields = [NSArray arrayWithObjects:personNameField, organizationNameField, organizationWebsiteField, organizationAddressField, organizationCityField, organizationStateField, organizationZIPField, nil];
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.scrollView setContentOffset:CGPointZero];
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"returning");
    if (textField.returnKeyType == UIReturnKeyNext) {
        NSLog(@"setting first responder to #%i", textField.tag+1);
        [[self.view viewWithTag:textField.tag+1] becomeFirstResponder];
        //[[textFields objectAtIndex:(textField.tag - 19)] becomeFirstResponder];
    }
    else {
        [self.view endEditing:YES];
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.managedObjectContext = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"email"] != nil) {
        [contactEmailField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"email"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"name"] != nil) {
        [personNameField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"name"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"address"] != nil) {
        [organizationAddressField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"address"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"city"] != nil) {
        [organizationCityField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"city"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"state"] != nil) {
        [organizationStateField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"state"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"zip"] != nil) {
        [organizationZIPField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"zip"]];
    }
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoplainlarge.png"]];
    backgroundImage.frame = CGRectMake(backgroundImage.frame.origin.x-40, backgroundImage.frame.origin.y+200, backgroundImage.frame.size.width, backgroundImage.frame.size.height);
    backgroundImage.alpha = 0.3;
    
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    submitButton.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    submitButton.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    submitButton.radius = 8.0;
    submitButton.margin = 4.0;
    submitButton.depth = 3.0;
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)submit:(id)sender
{
    NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
    
    if ([organizationNameField.text isEqualToString:@""] ||
        [organizationAddressField.text isEqualToString:@""] ||
        [organizationCityField.text isEqualToString:@""] ||
        [organizationStateField.text isEqualToString:@""] ||
        [organizationZIPField.text isEqualToString:@""] ||
        [contactEmailField.text isEqualToString:@""]) {
        UIAlertView *incompleteAlert = [[UIAlertView alloc] initWithTitle:@"Incomplete Form" message:@"Please check to make sure all required fields are complete." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [incompleteAlert show];
        return;
    }
    
    [request setObject:organizationNameField.text forKey:@"OrgName"];
    [request setObject:organizationAddressField.text forKey:@"OrgAddress"];
    [request setObject:organizationCityField.text forKey:@"OrgCity"];
    [request setObject:organizationStateField.text forKey:@"OrgState"];
    [request setObject:organizationZIPField.text forKey:@"OrgZIP"];
    [request setObject:contactEmailField.text forKey:@"ContactEmail"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:neededByPicker.date];
    NSLog(@"%@",dateString);
    [request setObject:dateString forKey:@"NeededByDate"];
     
     
    if (![personNameField.text isEqualToString:@""]){
        [request setObject:personNameField.text forKey:@"PersonName"];
    }
    
    if (![requestDescriptionField.text isEqualToString:@""]){
        [request setObject:requestDescriptionField.text forKey:@"RequestDescription"];
    }
    if (![organizationWebsiteField.text isEqualToString:@""]){
        [request setObject:organizationWebsiteField.text forKey:@"OrgWebsite"];
    }
    NSLog(@"request:%@", request);
    
    [self uploadRequest:request];
}

-(void)uploadRequest:(NSDictionary*) request
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Request" inManagedObjectContext:self.managedObjectContext];
    
    __block NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
    
    //NSData *requestData = [NSKeyedArchiver archivedDataWithRootObject:request];
    // Convert the binary data to string to save on Amazon S3
    //NSString *requestBinaryData = [SMBinaryDataConversion stringForBinaryData:requestData name:@"requestData.txt" contentType:@"text"];
    
    //[newManagedObject setValue:[newManagedObject assignObjectId] forKey:<#(NSString *)#>]
    
    if (![[request objectForKey:@"OrgName"] isEqualToString:@""]) {
        [newManagedObject setValue:[request objectForKey:@"OrgName"] forKey:@"orgname"];
    }
    if (![[request objectForKey:@"OrgAddress"] isEqualToString:@""]) {
        [newManagedObject setValue:[request objectForKey:@"OrgAddress"] forKey:@"orgaddress"];
    }
    if (![[request objectForKey:@"OrgCity"] isEqualToString:@""]) {
        [newManagedObject setValue:[request objectForKey:@"OrgCity"] forKey:@"orgcity"];
    }
    if (![[request objectForKey:@"OrgState"] isEqualToString:@""]) {
        [newManagedObject setValue:[request objectForKey:@"OrgState"] forKey:@"orgstate"];
    }
    if (![[request objectForKey:@"OrgZIP"] isEqualToString:@""]) {
        [newManagedObject setValue:[request objectForKey:@"OrgZIP"] forKey:@"orgzip"];
    }
    if (![[request objectForKey:@"OrgWebsite"] isEqualToString:@""]) {
        [newManagedObject setValue:[request objectForKey:@"OrgWebsite"] forKey:@"orgwebsite"];
    }
    if (![[request objectForKey:@"RequestDescription"] isEqualToString:@""]) {
        [newManagedObject setValue:[request objectForKey:@"RequestDescription"] forKey:@"requestdescription"];
    }
    if (![[request objectForKey:@"PersonName"] isEqualToString:@""]) {
        [newManagedObject setValue:[request objectForKey:@"PersonName"] forKey:@"personname"];
    }
    if (![[request objectForKey:@"NeededByDate"] isEqualToString:@""]) {
        [newManagedObject setValue:[request objectForKey:@"NeededByDate"] forKey:@"neededbydate"];
    }
    if (![[request objectForKey:@"ContactEmail"] isEqualToString:@""]) {
        [newManagedObject setValue:[request objectForKey:@"ContactEmail"] forKey:@"contactemail"];
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSString *locationName = [NSString stringWithFormat:@"%@ %@, %@ %@", [request objectForKey:@"OrgAddress"], [request objectForKey:@"OrgCity"], [request objectForKey:@"OrgState"], [request objectForKey:@"OrgZIP"]];
    
    [geocoder geocodeAddressString:locationName completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        //NSLog(@"placemarks: %@", placemarks);
        [self setPlacemark:[placemarks objectAtIndex:0]];
        NSLog(@"placemark: %@", placemark);
        
        NSString *latString = [NSString stringWithFormat:@"%f", self.placemark.region.center.latitude];
        NSString *lonString = [NSString stringWithFormat:@"%f", self.placemark.region.center.longitude];
        [newManagedObject setValue:latString forKey:@"orglatitude"];
        [newManagedObject setValue:lonString forKey:@"orglongitude"];
        [self saveOffer:newManagedObject];
    }];
}

- (void)saveOffer:(NSManagedObject *)newManagedObject
{
    NSLog(@"objID: %@", [newManagedObject primaryKeyField]);
    [newManagedObject setValue:[newManagedObject assignObjectId] forKey:[newManagedObject primaryKeyField]];
    
    NSLog(@"7");
    // Save the context.
    [self.managedObjectContext saveOnSuccess:^{
        [self.managedObjectContext refreshObject:newManagedObject mergeChanges:YES];
        NSLog(@"Saved request!");
    } onFailure:^(NSError *error) {
        NSLog(@"Error saving: %@", error);
    }];
}

@end