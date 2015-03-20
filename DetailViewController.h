//
//  DetailViewController.h
//  my-whereabouts
//
//  Created by Ali Hockla on 1/14/15.
//  Copyright (c) 2015 Ali Hockla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSString *DetailLabelContents;
@property (weak, nonatomic) IBOutlet UILabel *DetailLabel;

@end
