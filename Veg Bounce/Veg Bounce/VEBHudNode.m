//
//  VEBHubNode.m
//  Veg Bounce
//
//  Created by James Lynch on 12/25/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import "VEBHudNode.h"
#import "VEBConstants.h"
#import "VEBModel.h"
#import "VEBGameOverNode.h"

@implementation VEBHudNode

int _score = 0;
VEBHudNode *hud;
SKSpriteNode *heart1;
SKSpriteNode *heart2;
SKSpriteNode *heart3;

+ (instancetype) hudAtPosition:(CGPoint)position inFrame:(CGRect)frame{
    
    hud = [self node];
    hud.position = position;
    hud.zPosition = 10;
    hud.lives = MAX_LIVES;
    
    // Display hearts.
    heart1 = [SKSpriteNode spriteNodeWithImageNamed:@"heart"];
    heart1.position = CGPointMake(50, -5);
    heart1.name = @"heart1";
    [hud addChild:heart1];
    
    float heartWidth = heart1.frame.size.width;
    
    heart2 = [SKSpriteNode spriteNodeWithImageNamed:@"heart"];
    heart2.position = CGPointMake(50 + heartWidth + HEART_SPACER, -5);
    heart2.name = @"heart2";
    [hud addChild:heart2];
    
    heart3 = [SKSpriteNode spriteNodeWithImageNamed:@"heart"];
    heart3.position = CGPointMake(50 + (heartWidth + HEART_SPACER) * 2, -5);
    heart3.name = @"heart3";
    [hud addChild:heart3];
    
    
    // Display score label.
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Damascus"];
    scoreLabel.name = @"Score";
    NSString *labelText = @"Score: 0";
    scoreLabel.text = labelText;
    scoreLabel.fontColor = [SKColor blackColor];
    scoreLabel.fontSize = 18;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position = CGPointMake(frame.size.width - 50, -10);
    [hud addChild:scoreLabel];
    
    
    return hud;
}



- (void) addPoints:(NSInteger)points {
    self.score += points;
    SKLabelNode *scoreLabel = (SKLabelNode*)[self childNodeWithName:@"Score"];
    NSString *scoreText = [NSString stringWithFormat:@"Score: %ld", (long)self.score];
    scoreLabel.text = scoreText;
}


- (void) updateHearts {
   
    switch (currentLives) {
        case 2:
            [heart3 removeFromParent];
            break;
            
        case 1:
            [heart2 removeFromParent];
            break;
            
        case 0:
            [heart1 removeFromParent];
            [self performGameOver];
            break;
    }
}

- (void) performGameOver {
    
    // Display Game over node
    VEBGameOverNode *gameOverNode = [VEBGameOverNode gameOverAtPosition:CGPointMake(screenWidth / 2, -200)];
    [hud addChild:gameOverNode];
    gameOver = TRUE;
    [gameOverNode performAnimation];    
}

@end
