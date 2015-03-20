//
//  History.m
//  my-whereabouts
//
//  Created by Ali Hockla on 1/12/15.
//  Copyright (c) 2015 Ali Hockla. All rights reserved.
//

#import "History.h"
#import "ViewController.h"

@interface History ()

@end

@implementation History


- (IBAction)DeleteAll:(id)sender{
    
    loadArray.removeAllObjects;
}


- (void)viewDidLoad {
    
    DeleteAll = false;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    loadArray = [defaults objectForKey:@"savedNote"];
//    loadArray.removeLastObject;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [loadArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:SimpleIdentifier];
    }
    cell.textLabel.text = loadArray[indexPath.row];

    //cell.textLabel.text = loadArray[indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
