//
//  GameScene.m
//  Veg Bounce
//
//  Created by James Lynch on 9/18/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import "VEBGameScene.h"
#import "VEBVeggieNode.h"
#import "VEBGroundNode.h"
#import "VEBUtils.h"
#import <AVFoundation/AVFoundation.h>
#import "VEBGameOverNode.h"
#import "VEBWallNode.h"
#import "VEBConstants.h"
#import "VEBHudNode.h"
#import "VEBModel.h"

@interface VEBGameScene ()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;
@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *explodeSFX;
@property (nonatomic) SKAction *laserSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@property (nonatomic) AVAudioPlayer *gameOverMusic;
@property (nonatomic) BOOL gameOver;
@property (nonatomic) BOOL restart;
@property (nonatomic) BOOL gameOverDisplayed;
@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic) VEBHudNode *hud;
@end

@implementation VEBGameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        // Initialize game parameters.
        self.lastUpdateTimeInterval = 0;
        self.timeSinceEnemyAdded = 0;
        self.addEnemyTimeInterval = 6;
        self.totalGameTime = 0;
        self.minSpeed = VeggieMinSpeed;
        self.restart = NO;
        self.gameOver = NO;
        self.gameOverDisplayed = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.veggieArray = [[NSMutableArray alloc]init];
        currentLives = 3;
        gameOver = false;
        restart = false;
        screenWidth = self.frame.size.width;
        screenHeight = self.frame.size.height;
        
        // Set up the physics world.
        self.physicsWorld.gravity = CGVectorMake(0, -.5);
        self.physicsWorld.contactDelegate = self;
        
        // Add background
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background.jpg"];
        float scale = .5;
        background.xScale = scale;
        background.yScale = scale;
        background.position = CGPointMake((self.frame.size.width / 2), (self.frame.size.height / 2));
        [self addChild:background];
        
        // Add ground and walls.
        VEBGroundNode *ground = [VEBGroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
        [self addChild:ground];
        
        VEBWallNode *leftWall = [VEBWallNode wallWithSize:CGSizeMake(WALL_WIDTH,self.frame.size.height)];
        leftWall.anchorPoint = CGPointMake(.5,.5);
        leftWall.position = CGPointMake(WALL_WIDTH / 2,self.frame.size.height / 2 - 1);
        [self addChild:leftWall];
        
        VEBWallNode *rightWall = [VEBWallNode wallWithSize:CGSizeMake(WALL_WIDTH,self.frame.size.height)];
        rightWall.anchorPoint = CGPointMake(.5,.5);
        
        int rightWallX = (self.frame.size.width - (WALL_WIDTH/2) + 2);
        rightWall.position = CGPointMake(rightWallX ,
                                         self.frame.size.height / 2);
        rightWall.xScale = -1;
        [self addChild:rightWall];
        
        // Add hud.
        VEBHudNode *hud = [VEBHudNode hudAtPosition:CGPointMake(0, self.frame.size.height - 20) inFrame:self.frame];
        [self addChild:hud];
        self.hud = hud;
        
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (!gameOver)
    {
        
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        CGPoint firstTouchPoint = [touch locationInView:[self view]];
        
        float touchLocationX = firstTouchPoint.x;
        float touchLocationY = location.y;
        
        for (int i=0; i<self.veggieArray.count; i++) {
            VEBVeggieNode *veggie = self.veggieArray[i];
            
            // Do calculations from center of veggie.
            float veggieX = veggie.frame.origin.x + veggie.frame.size.width / 2;
            float veggieY = veggie.frame.origin.y + veggie.frame.size.height / 2;
            
            // If veggie is within click radius.
            if (veggieX - touchLocationX < TOUCH_RADIUS &&
                touchLocationX - veggieX < TOUCH_RADIUS &&
                veggieY - touchLocationY < TOUCH_RADIUS &&
                touchLocationY - veggieY < TOUCH_RADIUS
                )
            {
                
                // Add points and initialize variables.
                [self.hud addPoints:POINTS_PER_BOUNCE];
                float xPower = 0;
                float rotation = 0;
                float ypower = 0;
                
                float ydifference = veggieY - touchLocationY;
                float xdifference = veggieX - touchLocationX;
                
                // get absolute value of x and y differences.
                if (ydifference < 0)
                {
                    ydifference *= -1;
                }
                if (xdifference < 0)
                {
                    xdifference *= -1;
                }
                
                // Calculate yPower based on ydifference;
                ypower = (ydifference - TOUCH_RADIUS) * -1 * POWER_MULTIPLIER;
                [veggie.physicsBody applyImpulse:CGVectorMake(0, ypower)];
                

                // If touch is to the right of center of veggie.
                if ( (veggieX) < touchLocationX)
                {
                    xPower = -1 * xdifference;
                    rotation = .15 + xdifference / 100;
                }
                // If touch is to the left of center of veggie.
                if ((veggieX) > touchLocationX)
                {
                    xPower = xdifference;
                    rotation = -.15 - xdifference / 100;
                    
                }
             
                // Apply x directional force and rotational force based on xdifference.
                [veggie.physicsBody applyTorque:rotation];
                [veggie.physicsBody applyForce:CGVectorMake(xPower, 0)];
                
                // Display explosion at point clicked.
                NSString *greenExplosionPath = [[NSBundle mainBundle] pathForResource:@"GreenMagic" ofType:@"sks"];
                // Play particle effects GreenExplosion
                SKEmitterNode *greenExplosion = [NSKeyedUnarchiver unarchiveObjectWithFile:greenExplosionPath];
                greenExplosion.position = CGPointMake(veggieX, veggieY);
                [self addChild:greenExplosion];
                [greenExplosion runAction:[SKAction waitForDuration:2.0] completion:^{
                    [greenExplosion removeFromParent];
                }];
                
            }
            
        }
    
    }
    
    // Screen touched when it's ok to restart the game.
    else if (restart)
    {
       // Destroy any lingering nodes.
        for (SKNode *node in [self children])
        {
            [node removeFromParent];
        }
        
        // Create a new game scene.
        VEBGameScene *newGameScene = [VEBGameScene sceneWithSize:self.view.bounds.size];
        [self.view presentScene:newGameScene];
    }
    
    
}


- (void) addVeggie {
    
    // Create a veggie of random type.
    NSUInteger randomVeggie = [VEBUtils randomWithMin:0 max:4];
    VEBVeggieNode *veggie = [VEBVeggieNode veggieOfType:randomVeggie];
    
    float dy = [VEBUtils randomWithMin:VeggieMinSpeed max:VeggieMaxSpeed];
    veggie.physicsBody.velocity = CGVectorMake(0, dy);
    
    float y = self.frame.size.height + veggie.size.height;

    int min = veggie.size.width+10;
    int max = self.frame.size.width-veggie.size.width-10;
    
    
    int x = min + arc4random() %(max+1);
    
    veggie.position = CGPointMake(x,y);
    [self addChild:veggie];
    [self.veggieArray addObject:veggie];
    
    
    
    // Add a random bit of rotation to the veggie.
    int randomInt = [VEBUtils randomWithMin:1 max:20];
    NSLog(@"Got a random int: %d", randomInt);
    
    // Returns only either 1 or 2 since arch4random() returns a random from min to max-1
    int randomDirection = [VEBUtils randomWithMin:1 max:3];
    if (randomDirection == 1)
    {
        randomInt *= -1;
    }
    
    CGFloat initialTorque =  (float)randomInt / (20 * TORQUE_MODIFIER);
    [veggie.physicsBody applyTorque:initialTorque];
    NSLog(@"Giving veggie initial torque %f, direction: %d", initialTorque, randomDirection);
    
}


- (void) update:(NSTimeInterval)currentTime {
//    if ( self.lastUpdateTimeInterval ) {
//        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
//        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
//    }
//    
//    if ( self.timeSinceEnemyAdded > self.addEnemyTimeInterval && !gameOver ) {
//        [self addVeggie];
//        self.timeSinceEnemyAdded = 0;
//    }
//    
//    self.lastUpdateTimeInterval = currentTime;
//    
//    if ( self.totalGameTime > 480 ) {
//        // 480 / 60 = 8 minutes
//        self.addEnemyTimeInterval = 2;
//        self.minSpeed = -160;
//        
//    } else if ( self.totalGameTime > 240 ) {
//        // 240 / 60 = 4 minutes
//        self.addEnemyTimeInterval = 2.6;
//        self.minSpeed = -150;
//    } else if ( self.totalGameTime > 120 ) {
//        // 120 / 60 = 2 minutes
//        self.addEnemyTimeInterval = 3;
//        self.minSpeed = -125;
//        
//    } else if ( self.totalGameTime > 10 ) {
//        self.addEnemyTimeInterval = 4;
//        self.minSpeed = -100;
//    }
//    
//    if ( self.gameOver && !self.gameOverDisplayed ) {
//        //   [self performGameOver];
//    }
    
    
}


- (void)removeOneLife {
    currentLives --;
    [self.hud updateHearts];
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask ) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // If a veggie came into contact with something
    if (firstBody.categoryBitMask == CollisionCategoryVeggie ||
        secondBody.categoryBitMask ==
        CollisionCategoryVeggie)
    {
        // If that something was the ground.
        if (firstBody.categoryBitMask == CollisionCategoryGround ||
            secondBody.categoryBitMask ==
            CollisionCategoryGround)
        {
            
            // Save the veggie contact.body as a VEBVeggieNode.
            VEBVeggieNode *veggie;
            if (firstBody.categoryBitMask == CollisionCategoryVeggie)
            {
                veggie = (VEBVeggieNode *)firstBody.node;
            }
            else{
                veggie = (VEBVeggieNode *)secondBody.node;
            }
            
            
            [self removeOneLife];
            [veggie removeFromParent];
        }
        
    }
    
}

@end




