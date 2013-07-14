//
//  GiveViewController.m
//  Hunger No More
//
//  Created by John Luttig on 7/13/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import "GiveViewController.h"

@interface GiveViewController ()


@end

@implementation GiveViewController

@synthesize typePicker, descriptionField, metricPicker, amountField, allergyField, usebyPicker, pictureButton, submitButton;

#pragma mark - System Methods

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
    typeArray = [NSArray arrayWithObjects:@"Meat", @"Fish", @"Grain", @"Fruit", @"Vegetable", @"Dessert", @"Other", nil];
    metricArray = [NSArray arrayWithObjects:@"Pounds", @"Kilograms", @"Grams", @"Servings", nil];
    [typePicker reloadAllComponents];
    [metricPicker reloadAllComponents];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PickerView Methods

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"error";
    
    switch ([pickerView tag]) {
        case TAGTYPEPICKER:
            title = [typeArray objectAtIndex:row];
            break;
        case TAGMETRICPICKER:
            title = [metricArray objectAtIndex:row];
            break;
        default:
            title = @"error";
            break;
    }
    return title;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch ([pickerView tag]) {
            case TAGTYPEPICKER:
                return [typeArray count];
            case TAGMETRICPICKER:
                return [metricArray count];
            default:
                return 0;
    }
    
}

#pragma mark - IBActions

//- (IBAction)submit:(id)sender
//{
//    //submit request in give request - STACKMOB
//    //form request ID when submitted to match fulfillment requests
//    NSDictionary *offer = [[]
//}
//                           
//-(void)uploadOffer:(NSDictionary*) request
//{
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Request" inManagedObjectContext:self.managedObjectContext];
//    
//    __block NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
//    
//    //NSData *requestData = [NSKeyedArchiver archivedDataWithRootObject:request];
//    // Convert the binary data to string to save on Amazon S3
//    //NSString *requestBinaryData = [SMBinaryDataConversion stringForBinaryData:requestData name:@"requestData.txt" contentType:@"text"];
//    
//    //[newManagedObject setValue:[newManagedObject assignObjectId] forKey:￼]
//    
//    if (![[request objectForKey:@"OrgName"] isEqualToString:@""]) {
//        [newManagedObject setValue:[request objectForKey:@"OrgName"] forKey:@"orgname"];
//    }
//    if (![[request objectForKey:@"OrgAddress"] isEqualToString:@""]) {
//        [newManagedObject setValue:[request objectForKey:@"OrgAddress"] forKey:@"orgaddress"];
//    }
//    if (![[request objectForKey:@"OrgCity"] isEqualToString:@""]) {
//        [newManagedObject setValue:[request objectForKey:@"OrgCity"] forKey:@"orgcity"];
//    }
//    if (![[request objectForKey:@"OrgState"] isEqualToString:@""]) {
//        [newManagedObject setValue:[request objectForKey:@"OrgState"] forKey:@"orgstate"];
//    }
//    if (![[request objectForKey:@"OrgZIP"] isEqualToString:@""]) {
//        [newManagedObject setValue:[request objectForKey:@"OrgZIP"] forKey:@"orgzip"];
//    }
//    if (![[request objectForKey:@"OrgWebsite"] isEqualToString:@""]) {
//        [newManagedObject setValue:[request objectForKey:@"OrgWebsite"] forKey:@"orgwebsite"];
//    }
//    if (![[request objectForKey:@"RequestDescription"] isEqualToString:@""]) {
//        [newManagedObject setValue:[request objectForKey:@"RequestDescription"] forKey:@"requestdescription"];
//    }
//    if (![[request objectForKey:@"PersonName"] isEqualToString:@""]) {
//        [newManagedObject setValue:[request objectForKey:@"PersonName"] forKey:@"personname"];
//    }
//    if (![[request objectForKey:@"NeededByDate"] isEqualToString:@""]) {
//        [newManagedObject setValue:[request objectForKey:@"NeededByDate"] forKey:@"neededbydate"];
//    }
//    
//    //[newManagedObject setValue:requestBinaryData forKey:@"request"];
//    
//    NSLog(@"6");
//    //[newManagedObject setValue:[NSString stringWithFormat:@"request"] forKey:@"title"];
//    NSLog(@"objID: %@", [newManagedObject primaryKeyField]);
//    [newManagedObject setValue:[newManagedObject assignObjectId] forKey:[newManagedObject primaryKeyField]];
//    
//    NSLog(@"7");
//    // Save the context.
//    [self.managedObjectContext saveOnSuccess:^{
//        [self.managedObjectContext refreshObject:newManagedObject mergeChanges:YES];
//        NSLog(@"Saved request!");
//    } onFailure:^(NSError *error) {
//        NSLog(@"Error saving: %@", error);
//    }];
//}


- (IBAction)selectPicture:(id)sender
{
    //load pictureViewController
    //result saves to donationImage
}

- (IBAction)removeKeyboard:(id)sender
{
    //broken?!??!?
    NSLog(@"touched up inside");
    [self.view endEditing:YES];
}
@end
