//
//  GameScene.h
//  Bungee Bounce
//
//  Created by Alek Lord Hurst on 11/11/14.
//  Copyright (c) 2014 Alek Lord Hurst. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate>
{
    CGMutablePathRef pathToDraw;
    SKShapeNode *lineNode;
    SKShapeNode *ball;
    SKShapeNode *box;
}

@property (nonatomic, weak) GameViewController *gameViewController;

@property BOOL contentCreated;

@property int current_score;

@property int start_paddle_x;

@property (nonatomic) SKNode *leftWall;
@property (nonatomic) SKNode *rightWall;
@property (nonatomic) SKNode *bottomWall;

@property uint32_t ballCategory;
@property uint32_t paddleCategory;
@property uint32_t boxCategory;
@property uint32_t screenCategory;


-(void)createBox;
-(void)createBall;
-(void)createWalls;
-(void)createPaddle;
-(void)updatePaddlePhysics;

@end
