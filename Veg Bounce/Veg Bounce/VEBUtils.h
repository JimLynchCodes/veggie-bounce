//
//  Utils.h
//  Veg Bounce
//
//  Created by James Lynch on 9/23/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int VeggieMinSpeed = 0;
static const int VeggieMaxSpeed = 0;
static const int MaxLives = 4;
static const int PointsPerHit = 100;

@interface VEBUtils : NSObject

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;

@end

