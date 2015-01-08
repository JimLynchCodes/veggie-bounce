//
//  GameOverNode.h
//  Veg Bounce
//
//  Created by James Lynch on 9/23/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface VEBGameOverNode : SKNode

+ (instancetype) gameOverAtPosition:(CGPoint)position;

- (void) performAnimation;

@end
