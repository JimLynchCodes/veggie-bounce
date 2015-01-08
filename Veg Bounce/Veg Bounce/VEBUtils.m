//
//  Utils.m
//  Veg Bounce
//
//  Created by James Lynch on 9/23/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import "VEBUtils.h"

@implementation VEBUtils

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max {
    if (max != 0)
    {
        return arc4random()%(max - min) + min;
    }
    else
    {
        return 0;
    }
    
}

@end

