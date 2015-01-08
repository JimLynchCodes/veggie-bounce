//
//  VEBWallNode.m
//  Veg Bounce
//
//  Created by James Lynch on 12/24/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import "VEBWallNode.h"
#import "VEBModel.h"
#import "VEBConstants.h"

@implementation VEBWallNode

+ (instancetype) wallWithSize:(CGSize)size; {
    VEBWallNode *wall = [self spriteNodeWithImageNamed:@"wall-01.jpg"];
    wall.name = @"Ground";
    wall.anchorPoint = CGPointMake(.5,1);
    [wall setupPhysicsBody];
    
    return wall;
}


- (void) setupPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryWall;
    self.physicsBody.collisionBitMask = CollisionCategoryDebris | CollisionCategoryVeggie;
    self.physicsBody.contactTestBitMask = CollisionCategoryVeggie;
}

@end
