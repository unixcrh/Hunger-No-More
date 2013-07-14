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

@synthesize personNameField, organizationAddressField, organizationCityField, organizationNameField, organizationStateField, organizationWebsiteField, organizationZIPField, requestDescriptionField, neededByPicker, submitButton, scrollView;

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
        [organizationZIPField.text isEqualToString:@""]) {
        UIAlertView *incompleteAlert = [[UIAlertView alloc] initWithTitle:@"Incomplete Form" message:@"Please check to make sure all required fields are complete." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [incompleteAlert show];
        return;
    }
    
    [request setObject:organizationNameField.text forKey:@"OrgName"];
    [request setObject:organizationAddressField.text forKey:@"OrgAddress"];
    [request setObject:organizationCityField.text forKey:@"OrgCity"];
    [request setObject:organizationStateField.text forKey:@"OrgState"];
    [request setObject:organizationZIPField.text forKey:@"OrgZIP"];
    
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
    
    //[newManagedObject setValue:requestBinaryData forKey:@"request"];
    
    NSLog(@"6");
    //[newManagedObject setValue:[NSString stringWithFormat:@"request"] forKey:@"title"];
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