//
//  SWSHTimeTableViewController.m
//  SWSHTimeTableViewExample
//
//  Created by Nik Macintosh on 2013-07-22.
//  Copyright (c) 2013 GameCall Social Sports. All rights reserved.
//

#import "SWSHTimeTableView.h"
#import "SWSHTimeTableViewController.h"

@interface SWSHTimeTableViewController () <SWSHTimeTableViewDelegate>

@property (strong, nonatomic, readonly) SWSHTimeTableView *timeTableView;

@end

@implementation SWSHTimeTableViewController

@synthesize timeTableView = _timeTableView;

#pragma mark - SWSHTimeTableViewController

- (SWSHTimeTableView *)timeTableView {
    if (!_timeTableView) {
        _timeTableView = [SWSHTimeTableView new];
        
        _timeTableView.day = [NSDate date];
        _timeTableView.delegate = self;
        _timeTableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _timeTableView;
}

#pragma mark - SWSHTimeTableViewDelegate

- (void)timeTableView:(SWSHTimeTableView *)timeTableView didSelectTime:(NSDate *)time {
    static NSDateFormatter *_dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [NSDateFormatter new];
        
        _dateFormatter.dateStyle = NSDateFormatterShortStyle;
        _dateFormatter.timeStyle = NSDateFormatterShortStyle;
    });
    
    NSLog(@"%@", [_dateFormatter stringFromDate:time]);
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.timeTableView];
    
    NSDictionary *views = @{ @"timeTableView": self.timeTableView };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[timeTableView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[timeTableView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
}

- (void)didReceiveMemoryWarning {
    _timeTableView = nil;
    
    [super didReceiveMemoryWarning];
}

@end
