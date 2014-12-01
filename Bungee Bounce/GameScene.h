//
//  GameScene.h
//  Bungee Bounce
//
//  Created by Alek Lord Hurst on 11/11/14.
//  Copyright (c) 2014 Alek Lord Hurst. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>
{
    CGMutablePathRef pathToDraw;
    SKShapeNode *lineNode;
    SKShapeNode *ball;
    SKShapeNode *box;
}

@property BOOL contentCreated;
@property int current_score;
@property int start_paddle_x;
@property uint32_t ballCategory;
@property uint32_t paddleCategory;
@property uint32_t boxCategory;
@property uint32_t screenCategory;


-(void)createBox;
-(void)createBall;
-(void)createPaddle;
-(void)updatePaddlePhysics;

@end
