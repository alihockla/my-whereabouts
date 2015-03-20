//
//  ViewController.h
//  my-whereabouts
//
//  Created by Ali Hockla on 1/12/15.
//  Copyright (c) 2015 Ali Hockla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UITableViewController <CLLocationManagerDelegate>

@property (copy, nonatomic) NSMutableArray *saveNote;
@property (copy, nonatomic) NSMutableArray *Data;


@property (weak, nonatomic) IBOutlet UILabel *Latitude;
@property (weak, nonatomic) IBOutlet UILabel *Longitude;
@property (weak, nonatomic) IBOutlet UILabel *Address;
@property (weak, nonatomic) IBOutlet UILabel *Timestamp;
@property (weak, nonatomic) IBOutlet UILabel *MyLocation;
@property (weak, nonatomic) IBOutlet UITextField *NoteText;


- (IBAction)PinMeButtonPressed:(id)sender;
- (IBAction)SaveWhereaboutInfoPressed:(id)sender;


@end

