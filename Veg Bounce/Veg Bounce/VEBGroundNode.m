//
//  GroundNode.m
//  Veg Bounce
//
//  Created by James Lynch on 9/23/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import "VEBGroundNode.h"
#import "VEBModel.h"

@implementation VEBGroundNode

+ (instancetype) groundWithSize:(CGSize)size {
    VEBGroundNode *ground = [self spriteNodeWithColor:[SKColor blueColor] size:size];
    ground.name = @"Ground";
    
    // NOTE: Top of ground is 50 pixels from the bottom of the screen
    ground.position = CGPointMake(size.width/2,-50 - size.height);
    [ground setupPhysicsBody];
    return ground;
}


- (void) setupPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryGround;
    self.physicsBody.contactTestBitMask = CollisionCategoryVeggie;
    
    
    
    
}


@end