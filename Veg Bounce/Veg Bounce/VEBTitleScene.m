//
//  TitleScene.m
//  Veg Bounce
//
//  Created by James Lynch on 9/23/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import "VEBTitleScene.h"
#import "VEBGameScene.h"
#import <AVFoundation/AVFoundation.h>
#import "VEBConstants.h"

@interface VEBTitleScene ()
@property (nonatomic) SKAction *pressStartSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;

@end

@implementation VEBTitleScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        //  Display title screen background image.
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"title-splash-screen-01"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        float scale = .5;
        background.xScale = scale;
        background.yScale = scale;
        background.position = CGPointMake((self.frame.size.width / 2), (self.frame.size.height / 2));
        [self addChild:background];
        
    }
    return self;
}


- (void) didMoveToView:(SKView *)view {
    
    if (DEBUG_MODE)
    {
        SKView * skView = (SKView *)self.view;
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        skView.showsPhysics = YES;
    }
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Display game on first touch.
    VEBGameScene *gameScene = [VEBGameScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:gameScene transition:transition];
}

@end

