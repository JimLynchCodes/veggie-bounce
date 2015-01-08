//
//  GameOverNode.m
//  Veg Bounce
//
//  Created by James Lynch on 9/23/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import "VEBGameOverNode.h"
#import "VEBModel.h"

@implementation VEBGameOverNode

+ (instancetype) gameOverAtPosition:(CGPoint)position {
    VEBGameOverNode *gameOver = [self node];
    
    // Display the Game Over label.
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    gameOverLabel.name = @"GameOver";
    gameOverLabel.text = @"Game Over";
    gameOverLabel.fontSize = 48;
    gameOverLabel.position = position;
    gameOverLabel.fontColor = [SKColor blackColor];
    [gameOver addChild:gameOverLabel];
    
    return gameOver;
}

- (void) performAnimation {
    
    // Do a little bounce with the Game Over label text.
    SKLabelNode *label = (SKLabelNode*)[self childNodeWithName:@"GameOver"];
    label.xScale = 0;
    label.yScale = 0;
    SKAction *scaleUp = [SKAction scaleTo:1.2f duration:0.75f];
    SKAction *scaleDown = [SKAction scaleTo:0.9f duration:0.25f];
    
    // Display the 'Touch to Restart' text after Game Over bounce.
    SKAction *run = [SKAction runBlock:^{
        SKLabelNode *touchToRestart = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
        touchToRestart.text = @"Touch To Restart";
        touchToRestart.fontSize = 24;
        touchToRestart.position = CGPointMake(label.position.x, label.position.y-40);
        touchToRestart.fontColor = [SKColor blackColor];
        restart = TRUE;
        [self addChild:touchToRestart];
    }];
    
    SKAction *scaleSequence = [SKAction sequence:@[scaleUp,scaleDown,run]];
    [label runAction:scaleSequence];
    
}


@end

