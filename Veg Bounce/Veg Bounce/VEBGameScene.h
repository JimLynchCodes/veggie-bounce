//
//  GameScene.h
//  Veg Bounce
//
//  Created by James Lynch on 9/18/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface VEBGameScene : SKScene <SKPhysicsContactDelegate>

@property(nonatomic,strong)NSMutableArray *veggieArray;

@end
