//
//  VeggieNode.h
//  Veg Bounce
//
//  Created by James Lynch on 9/23/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, VeggieType) {
    VeggieTypeA = 0,
    VeggieTypeB = 1,
    VeggieTypeC = 2,
    VeggieTypeD = 3,
    VeggieTypeE = 4
};


@interface VEBVeggieNode : SKSpriteNode

+ (instancetype) veggieOfType:(VeggieType)type;

@end