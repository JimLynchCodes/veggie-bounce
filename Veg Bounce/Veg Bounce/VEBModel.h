//
//  VEBModel.h
//  Veg Bounce
//
//  Created by James Lynch on 12/24/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VEBModel : NSObject

typedef NS_OPTIONS(uint32_t, CollisionCategory) {
    CollisionCategoryVeggie        = 1111,
    CollisionCategoryTouch        = 1010,
    CollisionCategoryDebris       = 0010,
    CollisionCategoryGround       = 0000,
    CollisionCategoryWall         = 1001
};

extern NSInteger currentLives;
extern bool gameOver;
extern bool restart;
extern int screenWidth;
extern int screenHeight;

@end
