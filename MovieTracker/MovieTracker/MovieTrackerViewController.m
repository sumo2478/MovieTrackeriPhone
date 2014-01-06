//
//  MovieTrackerViewController.m
//  MovieTracker
//
//  Created by user on 13/12/24.
//  Copyright (c) 2013年 MovieTracker. All rights reserved.
//

#import "MovieTrackerViewController.h"
#import "MovieObject.h"
#define API_KEY @"w7udff7zxx37pc6jeu6tx8vt"
#define MAX_SEARCH_MOVIES ((int)50)


@interface MovieTrackerViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchBarTextField;
@property (weak, nonatomic) IBOutlet UITableView *movieInformationTableView;
@property (strong, nonatomic) NSMutableArray *movieObjectsDisplayArray;


@end

@implementation MovieTrackerViewController

- (IBAction)searchMovie:(id)sender {
    
    

	NSString *movieSearchName = self.searchBarTextField.text;
    movieSearchName = [movieSearchName stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=%@&q=%@&page_limit=%d",API_KEY,movieSearchName,MAX_SEARCH_MOVIES]];
    
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
   
    int totalMovies = [json[@"total"] intValue];
    if (MAX_SEARCH_MOVIES < totalMovies)
        totalMovies = MAX_SEARCH_MOVIES;
    [self.movieObjectsDisplayArray removeAllObjects];
    
    for (int i = 0; i < totalMovies; i++) {
        [self storeMovieObject:movieSearchName withIndex:i withJsonDictionary:json];
    }
    /*
    MovieObject *searchedMovieObject = [[MovieObject alloc]init];
    
    NSArray *movies = json[@"movies"];
    searchedMovieObject.movieTitle = movies[0][@"title"];
    NSDictionary *releaseDates = movies[0][@"release_dates"];
    searchedMovieObject.dvdReleaseDate = releaseDates[@"dvd"];
    searchedMovieObject.theaterReleaseDate = releaseDates[@"theater"];
    searchedMovieObject.imageURL = movies[0][@"posters"][@"thumbnail"];
    //NSLog(@"%@",movies[0][@"posters"][@"thumbnail"]);
    //NSLog(@"%@",searchedMovieObject.imageURL);
    //NSLog(@"%@",movies[0][@"release_dates"]);
    //NSLog(@"dvd release date is %@",dvdReleaseDate);
    //NSLog(@"theater release date is %@",theaterReleaseDate);
    
    //self.movieInformationTableView
    
    
    
    self.movieInformation.text = [NSString stringWithFormat:@"Movie: %@\ndvd release date: %@\ntheater release date: %@",searchedMovieObject.movieTitle,searchedMovieObject.dvdReleaseDate,searchedMovieObject.theaterReleaseDate];
    */
    
    [self.movieInformationTableView reloadData];
    
}
- (void)storeMovieObject:(NSString *)movieTitle withIndex:(int)index withJsonDictionary:(NSMutableDictionary *)json
{
    
    MovieObject *searchedMovieObject = [[MovieObject alloc]init];
    NSArray *movies = json[@"movies"];
    searchedMovieObject.movieTitle = movies[index][@"title"];
    NSDictionary *releaseDates = movies[index][@"release_dates"];
    searchedMovieObject.dvdReleaseDate = releaseDates[@"dvd"];
    searchedMovieObject.theaterReleaseDate = releaseDates[@"theater"];
    searchedMovieObject.imageURL = movies[index][@"posters"][@"thumbnail"];
    
    [self.movieObjectsDisplayArray addObject:searchedMovieObject];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.searchBarTextField)
        [theTextField resignFirstResponder];
    
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBarTextField.delegate = self;
    self.movieInformationTableView.dataSource = self;
    
    self.movieObjectsDisplayArray = [[NSMutableArray alloc]init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movieObjectsDisplayArray count];
}

//4
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //5
    static NSString *cellIdentifier = @"SettingsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //5.1 you do not need this if you have set SettingsCell as identifier in the storyboard (else you can remove the comments on this code)
    if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
       }
    
    //6
    MovieObject *object = [self.movieObjectsDisplayArray objectAtIndex:indexPath.row];
    
    //7
    [cell.textLabel setText:object.movieTitle];
    [cell.detailTextLabel setText:object.dvdReleaseDate];
    
    NSString *imageIcon = object.imageURL;
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageIcon]];
    cell.imageView.image = [UIImage imageWithData:imageData];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button addTarget:self action: @selector(addbuttonTapped:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    //button.tag = indexPath.row;
    cell.accessoryView = button;
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return cell;
}
- (void)addbuttonTapped:(id)sender withEvent: (UIEvent *) event
{
    //UIButton *btn = (UIButton *)sender;
    //NSLog(@"btn.tag %d",btn.tag);
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView: self.movieInformationTableView];
    NSIndexPath * indexPath = [self.movieInformationTableView indexPathForRowAtPoint: location];
    NSLog(@"%d", indexPath.row);
    
    TrackedMoviesTableViewController *trackedMoviesTableViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    trackedMoviesTableViewController.delegate  = self;
    trackedMoviesTableViewController.testPassing = @"IT PASSED";
    [self.navigationController pushViewController:trackedMoviesTableViewController animated:YES];
    
}



@end
