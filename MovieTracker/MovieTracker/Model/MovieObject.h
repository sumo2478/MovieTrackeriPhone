//
//  MovieObject.h
//  MovieTracker
//
//  Created by user on 13/12/24.
//  Copyright (c) 2013年 MovieTracker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieObject : NSObject

@property (weak, nonatomic) NSString *movieTitle;
@property (weak, nonatomic) NSString *dvdReleaseDate;
@property (weak, nonatomic) NSString *theaterReleaseDate;
@property (weak, nonatomic) NSString *imageURL;



@end
