//
//  VeggieNode.m
//  Veg Bounce
//
//  Created by James Lynch on 9/23/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import "VEBVeggieNode.h"
#import "VEBModel.h"
#import "VEBUtils.h"

@implementation VEBVeggieNode

+ (instancetype) veggieOfType:(VeggieType)type {

    // Display correct image for veggie depending on the type.
    VEBVeggieNode *veggie;
    if ( type == VeggieTypeA ) {
        veggie = [self spriteNodeWithImageNamed:@"red-pepper-01"];
        veggie.anchorPoint = CGPointMake(.5,.5);
        
    } else if ( type == VeggieTypeB) {
        veggie = [self spriteNodeWithImageNamed:@"eggplant-g-01"];
        veggie.anchorPoint = CGPointMake(.5, .5);
        
    } else if ( type == VeggieTypeC) {
        veggie = [self spriteNodeWithImageNamed:@"red-pepper-01"];
        veggie.anchorPoint = CGPointMake(.5,.5);
    }
    else if ( type == VeggieTypeD) {
        veggie = [self spriteNodeWithImageNamed:@"broc-01"];
    }
    else{
        veggie = [self spriteNodeWithImageNamed:@"broc-01"];
    }
    
    // Scale veggie down a bit with some variation.
    float scale = [VEBUtils randomWithMin:35 max:40] / 50.0f;
    veggie.xScale = scale;
    veggie.yScale = scale;
    veggie.name = @"veggie";
    [veggie setupPhysicsBody];
    
    return veggie;
}

- (void) setupPhysicsBody {
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = YES;
    self.physicsBody.dynamic = YES;
    self.physicsBody.usesPreciseCollisionDetection = TRUE;
    self.physicsBody.categoryBitMask = CollisionCategoryVeggie;
    self.physicsBody.collisionBitMask = CollisionCategoryWall | CollisionCategoryVeggie;
    self.physicsBody.contactTestBitMask = CollisionCategoryVeggie | CollisionCategoryGround; 
}


@end

