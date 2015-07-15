//
//  DetailViewController.m
//  connectProject
//
//  Created by Vanny Nguyen on 7/13/15.
//  Copyright (c) 2015 Vanny Nguyen. All rights reserved.
//

#import "DetailViewController.h"
#import "randomAnnotation.h"
@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize mapView;

#pragma mark - Managing the detail item
-(void)setMap{
    
    mapView.frame = self.view.bounds;
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    MKCoordinateRegion region;
    //center
    CLLocationCoordinate2D center = [self.detailItem coordinate];
    //span
    MKCoordinateSpan span;
    span.latitudeDelta = 0.9f;
    span.longitudeDelta = 0.9f;
    
    region.center = center;
    region.span = span;
    
    //assign region to map
    [mapView setRegion:region animated:YES];
    
    
    
    //annotation
    randomAnnotation *pin = [[randomAnnotation alloc] initWithPosition:center];
    pin.title = [NSString stringWithFormat:@"Lat: %f Long: %f",center.latitude, center.longitude];
    [self.mapView addAnnotation:pin];
}
- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        
       

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMap];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
