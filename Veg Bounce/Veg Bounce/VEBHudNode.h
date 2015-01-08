//
//  VEBHubNode.h
//  Veg Bounce
//
//  Created by James Lynch on 12/25/14.
//  Copyright (c) 2014 Jim Lynch Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface VEBHudNode : SKNode

@property (nonatomic) NSInteger lives;
@property (nonatomic) NSInteger score;
@property (nonatomic) SKSpriteNode *heart1;
@property (nonatomic) SKSpriteNode *heart2;
@property (nonatomic) SKSpriteNode *heart3;

+ (instancetype) hudAtPosition:(CGPoint)position inFrame:(CGRect)frame;

- (void) addPoints:(NSInteger)points;
-(void) updateHearts;

@end
