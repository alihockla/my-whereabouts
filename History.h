//
//  History.h
//  my-whereabouts
//
//  Created by Ali Hockla on 1/12/15.
//  Copyright (c) 2015 Ali Hockla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

NSMutableArray *loadArray;
BOOL *DeleteAll;

@interface History : UIViewController <UITableViewDataSource, UITableViewDelegate>


- (IBAction)DeleteAll:(id)sender;

@end
