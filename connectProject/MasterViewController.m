//
//  MasterViewController.m
//  connectProject
//
//  Created by Vanny Nguyen on 7/13/15.
//  Copyright (c) 2015 Vanny Nguyen. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"


#define NUM_OF_COORDS 20;

//constrained max latitude range from (-90,90) to (-80,80)
#define MAX_LAT 160
#define MAX_LONG 360

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

/**
*param: range of return value
*return: random float within given range
*/
-(float)randomCoord:(int) range{
    
    return (drand48()*(float)range)-(range/2);
}

/**
 *return: new CCLocation with random coordinates
 */
-(CLLocation *)generateCoords{
    
    CLLocation *center = [[CLLocation alloc] initWithLatitude:[self randomCoord:MAX_LAT] longitude:[self randomCoord:MAX_LONG]];
    return center;
}

/**
*void: Fill objects array with random coordinates
*/
-(void)fillList{
    _objects = [[NSMutableArray alloc] initWithObjects:[self generateCoords], nil];
    int numCoords = NUM_OF_COORDS;
    for(int i = 0; i < numCoords;i++){
        [self insertNewObject:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //seed drand48()
    srand48(time(0));
    
    [self fillList];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    
    //generate new coordinate and add to top of objects list
    [self.objects insertObject:[self generateCoords] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CLLocation *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    CLLocation *object = self.objects[indexPath.row];
    CLLocationCoordinate2D loc = [object coordinate];
    
    //format display of cells
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.text = [NSString stringWithFormat:@"Coordinate #%li",indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"Lat: %0.6f\nLong: %0.6f",loc.latitude,loc.longitude];
    
    
    //cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
