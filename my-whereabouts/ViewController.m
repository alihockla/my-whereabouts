//
//  ViewController.m
//  my-whereabouts
//
//  Created by Ali Hockla on 1/12/15.
//  Copyright (c) 2015 Ali Hockla. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "History.h"
#import "DetailViewController.h"

@interface ViewController () <CLLocationManagerDelegate>


@end

@implementation ViewController {

    CLLocationManager *manager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
}

- (IBAction)SaveWhereaboutInfoPressed:(id)sender { // Save button pressed

    _Data = [@[_Timestamp.text, _Address.text, _NoteText.text] mutableCopy];
    [manager stopUpdatingLocation];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"savedNote"]) {
        _saveNote = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"savedNote"]];
    } else {
        _saveNote = [NSMutableArray array];
    }
    
    // Add new task
    [_saveNote addObjectsFromArray:_Data];
    
    [[NSUserDefaults standardUserDefaults] setObject:_saveNote forKey:@"savedNote"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    
    //NSMutableArray *saveNote = [[NSMutableArray alloc]init];
    
//    [_saveNote addObject:_NoteText.text];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:_saveNote forKey:@"savedNote"];
//    [defaults synchronize];
    
    NSString *alertMessage = [[NSString alloc] initWithFormat:@"Your Whereabout has been saved!"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:alertMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
}


- (void)viewDidLoad {
    
//    _saveNote = [[NSMutableArray alloc]init];
    
    _MyLocation.hidden = YES;
    
    manager = [[CLLocationManager alloc] init];
    
    geocoder = [[CLGeocoder alloc] init];

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.Data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
    }
    else if (cell != nil) {
        NSLog(@"COUNT = %i", self.Data.count);
        [tableView reloadData];
    }
    
    // Configure the cell...
    cell.textLabel.text = self.Data[indexPath.row];
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"ShowDetail"]) {
        NSString *object = nil;
        NSIndexPath *indexPath = nil;
        
        indexPath = [self.tableView indexPathForSelectedRow];
        object = self.Data[indexPath.row];
        
        [[segue destinationViewController] setDetailLabelContents:object];
        
        //        [[segue destinationViewController] setDetailLabelContents:resultString];
        
    }
}

- (IBAction)PinMeButtonPressed:(id)sender {
    
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    manager.requestWhenInUseAuthorization;

    [manager startUpdatingLocation];
    
}

// Get Location : ---------------- 

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location! :(");
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        _MyLocation.hidden = NO;

        self.Latitude.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        self.Longitude.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        
    }
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            
            placemark = [placemarks lastObject];
            
            self.Address.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
            
            NSDate *currentTime = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"hh:mm:ss a"];
            NSString *resultString = [dateFormatter stringFromDate: currentTime];
            
            self.Timestamp.text = resultString;
            
        } else {
            self.Address.text = @"ERROR";
            NSLog(@"%@", error.debugDescription);
            
        }
        
    } ];
    
}

@end
