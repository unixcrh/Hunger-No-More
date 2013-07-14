//
//  GiveViewController.m
//  Hunger No More
//
//  Created by John Luttig on 7/13/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import "GiveItemsViewController.h"


@interface GiveItemsViewController ()


@end

@implementation GiveItemsViewController

@synthesize typeAndMetricPicker, descriptionField, amountField, allergyField, usebyPicker, pictureButton, submitButton, pickupAddressField, pickupCityField, pickupStateField, pickupZIPField, scrollView, donationImage, placemark, imageView, saveImageButton, contactEmailField;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize backButton;

#pragma mark - System Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        donationImage = [[UIImage alloc] init];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    typeArray = [NSArray arrayWithObjects:@"Meat", @"Fish", @"Grain", @"Fruit", @"Vegetable", @"Dessert", @"Other", nil];
    metricArray = [NSArray arrayWithObjects:@"Pounds of", @"Kilograms of", @"Grams of", @"Servings of", nil];
    [typeAndMetricPicker reloadAllComponents];
    self.managedObjectContext = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"address"] != nil) {
        [pickupAddressField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"address"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"city"] != nil) {
        [pickupCityField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"city"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"state"] != nil) {
        [pickupStateField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"state"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"zip"] != nil) {
        [pickupZIPField setText:[[NSUserDefaults standardUserDefaults] objectForKey: @"zip"]];
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
    
    pictureButton.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    pictureButton.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    pictureButton.radius = 8.0;
    pictureButton.margin = 4.0;
    pictureButton.depth = 3.0;
    [pictureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    backButton.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    backButton.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    backButton.radius = 3.0;
    backButton.margin = 2.0;
    backButton.depth = 2.0;
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.scrollView setContentOffset:CGPointZero];
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"we got a memory warning, but fuck it!");
    //[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PickerView Methods

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"error";
    
    switch (component) {
        case 0:
            title = [metricArray objectAtIndex:row];
            break;
        case 1:
            title = [typeArray objectAtIndex:row];
            break;
        default:
            title = @"error";
            break;
    }
    return title;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
            case 0:
                return [metricArray count];
            case 1:
                return [typeArray count];
            default:
                return 0;
    }
    
}

#pragma mark - TextField Delegate Methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //CGPoint svos = scrollView.contentOffset;
    CGPoint pt;
    CGRect rc = [textView bounds];
    rc = [textView convertRect:rc toView:scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [scrollView setContentOffset:pt animated:YES];

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
    }
    else {
        [self.view endEditing:YES];
    }
    return YES;
}

#pragma mark - IBActions

- (IBAction)back:(id)sender
{
    //TODO
    NSLog(@"popping back");
    [self dismissViewControllerAnimated:YES completion:nil];
    //[delegate dismissView];
}
- (IBAction)submit:(id)sender
{
    NSMutableDictionary *offer = [[NSMutableDictionary alloc] init];
    NSLog(@"submitting");
    if ([descriptionField.text isEqualToString:@""] ||
        [amountField.text isEqualToString:@""] ||
        [pickupAddressField.text isEqualToString:@""] ||
        [pickupCityField.text isEqualToString:@""] ||
        [pickupStateField.text isEqualToString:@""] ||
        [pickupZIPField.text isEqualToString:@""] ||
        [contactEmailField.text isEqualToString:@""]) {
        NSLog(@"amount: %@", amountField.text);
        NSLog(@"descr: %@", descriptionField.text);
        NSLog(@"addr: %@", pickupAddressField.text);
        NSLog(@"city: %@", pickupCityField.text);
        NSLog(@"state: %@", pickupStateField.text);
        NSLog(@"zip: %@", pickupZIPField.text);
        UIAlertView *incompleteAlert = [[UIAlertView alloc] initWithTitle:@"Incomplete Form" message:@"Please check to make sure all required fields are complete." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [incompleteAlert show];
        return;
    }
    
    [offer setObject:descriptionField.text forKey:@"offerdescription"];
    [offer setObject:amountField.text forKey:@"amount"];
    [offer setObject:pickupAddressField.text forKey:@"pickupaddress"];
    [offer setObject:pickupCityField.text forKey:@"pickupcity"];
    [offer setObject:pickupStateField.text forKey:@"pickupstate"];
    [offer setObject:pickupZIPField.text forKey:@"pickupzip"];
    [offer setObject:contactEmailField.text forKey:@"contactemail"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:usebyPicker.date];
    NSLog(@"%@",dateString);
    [offer setObject:dateString forKey:@"usebydate"];
    
    NSString *type = @"error";
    type = [typeArray objectAtIndex:[typeAndMetricPicker selectedRowInComponent:1]];
    [offer setObject:type forKey:@"offertype"];
    
    NSString *metric = @"error";
    metric = [metricArray objectAtIndex:[typeAndMetricPicker selectedRowInComponent:0]];
    [offer setObject:metric forKey:@"metric"];
    
    if (![allergyField.text isEqualToString:@""]){
        [offer setObject:allergyField.text forKey:@"allergyinfo"];
    }
    if (donationImage != nil) {
        NSLog(@"donation image found");
        [offer setObject:donationImage forKey:@"image"];
    }
    
    NSLog(@"offer:%@", offer);
    
    [self uploadOffer:offer];
}

-(void)uploadOffer:(NSDictionary*) offer
{
    NSLog(@"uploading offer");
    //[(AppDelegate *)[[UIApplication sharedApplication] delegate] changeSchema: @"offer"];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Offer" inManagedObjectContext:self.managedObjectContext];
    
    __block NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
    
    if (![[offer objectForKey:@"allergyinfo"] isEqualToString:@""]) {
        [newManagedObject setValue:[offer objectForKey:@"allergyinfo"] forKey:@"allergyinfo"];
    }
    if (![[offer objectForKey:@"contactemail"] isEqualToString:@""]) {
        [newManagedObject setValue:[offer objectForKey:@"contactemail"] forKey:@"contactemail"];
    }
    if (![[offer objectForKey:@"amount"] isEqualToString:@""]) {
        [newManagedObject setValue:[offer objectForKey:@"amount"] forKey:@"amount"];
    }
    if (![[offer objectForKey:@"metric"] isEqualToString:@""]) {
        [newManagedObject setValue:[offer objectForKey:@"metric"] forKey:@"metric"];
    }
    if (![[offer objectForKey:@"offerdescription"] isEqualToString:@""]) {
        [newManagedObject setValue:[offer objectForKey:@"offerdescription"] forKey:@"offerdescription"];
    }
    if (![[offer objectForKey:@"offertype"] isEqualToString:@""]) {
        [newManagedObject setValue:[offer objectForKey:@"offertype"] forKey:@"offertype"];
    }
    if (![[offer objectForKey:@"pickupaddress"] isEqualToString:@""]) {
        [newManagedObject setValue:[offer objectForKey:@"pickupaddress"] forKey:@"pickupaddress"];
    }
    if (![[offer objectForKey:@"pickupcity"] isEqualToString:@""]) {
        [newManagedObject setValue:[offer objectForKey:@"pickupcity"] forKey:@"pickupcity"];
    }
    if (![[offer objectForKey:@"pickupstate"] isEqualToString:@""]) {
        [newManagedObject setValue:[offer objectForKey:@"pickupstate"] forKey:@"pickupstate"];
    }
    if (![[offer objectForKey:@"pickupzip"] isEqualToString:@""]) {
        [newManagedObject setValue:[offer objectForKey:@"pickupzip"] forKey:@"pickupzip"];
    }
    if (![[offer objectForKey:@"usebydate"] isEqualToString:@""]) {
        [newManagedObject setValue:[offer objectForKey:@"usebydate"] forKey:@"usebydate"];
    }
    if ([offer objectForKey:@"image"] != nil) {
        NSData *imageData = UIImageJPEGRepresentation([offer objectForKey:@"image"], 0.7);
    
        NSString *picData = [SMBinaryDataConversion stringForBinaryData:imageData name:@"offerimage.jpg" contentType:@"image/jpg"];
    
        [newManagedObject setValue:picData forKey:@"image"];
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSString *locationName = [NSString stringWithFormat:@"%@ %@, %@ %@", [offer objectForKey:@"pickupaddress"], [offer objectForKey:@"pickupcity"], [offer objectForKey:@"pickupstate"], [offer objectForKey:@"pickupzip"]];
    
    [geocoder geocodeAddressString:locationName completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        NSLog(@"placemarks: %@", placemarks);
        [self setPlacemark:[placemarks objectAtIndex:0]];
        NSLog(@"placemark: %@", placemark);
        NSString *latString = [NSString stringWithFormat:@"%f", self.placemark.region.center.latitude];
        NSString *lonString = [NSString stringWithFormat:@"%f", self.placemark.region.center.longitude];
        //NSLog(@"latString: %@", latString);
        //NSLog(@"lonString: %@", lonString);
        [newManagedObject setValue:latString forKey:@"pickuplatitude"];
        [newManagedObject setValue:lonString forKey:@"pickuplongitude"];
        [self saveOffer:newManagedObject];
    }];
    NSLog(@"done uploading offer");
}

- (void)saveOffer:(NSManagedObject *)newManagedObject
{
    NSLog(@"objID: %@", [newManagedObject primaryKeyField]);
    [newManagedObject setValue:[newManagedObject assignObjectId] forKey:[newManagedObject primaryKeyField]];
    
    NSLog(@"7");
    // Save the context.
    [self.managedObjectContext saveOnSuccess:^{
        [self.managedObjectContext refreshObject:newManagedObject mergeChanges:YES];
        NSLog(@"Saved offer!");
    } onFailure:^(NSError *error) {
        NSLog(@"Error saving: %@", error);
    }];
}

- (IBAction)selectPicture:(id)sender
{
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    imagePickController.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickController.delegate=self;
    imagePickController.allowsEditing=TRUE;
    [self presentViewController:imagePickController animated:YES completion:nil];
}

-(IBAction)saveImageAction:(id)sender
{
    NSLog(@"saving donation image action");
    [self setDonationImage:imageView.image];
    NSLog(@"donationIMG: %@", donationImage);
    //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    saveImageButton.enabled=FALSE;
}

#pragma mark - When finish shoot

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"finished picking");
    //UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    //imageView.image=image;
    [self setDonationImage:[info objectForKey:UIImagePickerControllerEditedImage]];
    NSLog(@"donIMG: %@", donationImage);
    saveImageButton.enabled=TRUE;
    [self dismissViewControllerAnimated:YES completion:nil];
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    //[saveImageButton setTarget:@selector(saveImageAction:)];
    //[saveImageButton]
}

- (IBAction)removeKeyboard:(id)sender
{
    //broken?!??!?
    NSLog(@"touched up inside");
    [self.view endEditing:YES];
}
@end
