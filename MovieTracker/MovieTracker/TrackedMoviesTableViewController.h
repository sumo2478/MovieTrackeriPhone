//
//  TrackedMoviesTableViewController.h
//  MovieTracker
//
//  Created by user on 13/12/26.
//  Copyright (c) 2013年 MovieTracker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieTrackerViewController;

@interface TrackedMoviesTableViewController : UITableViewController 

@property (strong,nonatomic) NSArray *movieObjectArray;
@property (strong,nonatomic) NSString *testPassing;
@property (strong, nonatomic) MovieTrackerViewController *delegate;

@end
