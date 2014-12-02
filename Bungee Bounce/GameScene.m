//
//  GameScene.m
//  Bungee Bounce
//
//  Created by Alek Lord Hurst on 11/11/14.
//  Copyright (c) 2014 Alek Lord Hurst. All rights reserved.
//

#import "GameScene.h"
#import "GameViewController.h"

@implementation GameScene
@synthesize gameViewController;
@synthesize contentCreated;
@synthesize ballCategory;
@synthesize paddleCategory;
@synthesize boxCategory;
@synthesize screenCategory;
@synthesize current_score;
@synthesize start_paddle_x;
@synthesize leftWall;
@synthesize rightWall;
@synthesize bottomWall;

- (void)didMoveToView: (SKView *) view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    current_score = 0;
    
    self.backgroundColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0];
    self.scaleMode = SKSceneScaleModeAspectFill;
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0.0, -12);
    
    ballCategory =  0x1 << 0;
    paddleCategory =  0x1 << 1;
    boxCategory = 0x1 << 2;
    screenCategory = 0x1 << 3;
    
    [self createWalls];
    [self createBox];
    [self createBall];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [lineNode removeFromParent];
    CGPathRelease(pathToDraw);
    
    UITouch* touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    
    pathToDraw = CGPathCreateMutable();
    CGPathMoveToPoint(pathToDraw, NULL, positionInScene.x, positionInScene.y);
    
    start_paddle_x = positionInScene.x;
    
    [self createPaddle];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch* touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    if(abs(start_paddle_x - positionInScene.x) <= 300) {
        CGPathAddLineToPoint(pathToDraw, NULL, positionInScene.x, positionInScene.y);
    
        lineNode.path = pathToDraw;
    
        [self updatePaddlePhysics];
    }
}

- (void)createBall {
    ball = [SKShapeNode shapeNodeWithCircleOfRadius:40.0];
    ball.position = CGPointMake(CGRectGetMidX(self.frame)-80,CGRectGetMidY(self.frame)+400);
    ball.fillColor = [UIColor colorWithRed:211.0f/255.0f green:204.0f/255.0f blue:80.0f/255.0f alpha:1.0];
    ball.strokeColor = [UIColor colorWithRed:211.0f/255.0f green:204.0f/255.0f blue:80.0f/255.0f alpha:1.0];
    ball.name = @"ball";
    
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:40];
    ball.physicsBody.categoryBitMask = ballCategory;
    ball.physicsBody.collisionBitMask = paddleCategory | screenCategory;
    ball.physicsBody.contactTestBitMask = paddleCategory | boxCategory | screenCategory;
    ball.physicsBody.restitution = 1;
    ball.physicsBody.linearDamping = 0;
    
    
    [self addChild:ball];
}

- (void)createWalls {
    CGPoint topLeftPoint = CGPointMake(80, self.frame.size.height + 1000);
    CGPoint topRightPoint = CGPointMake(self.frame.size.width - 80, self.frame.size.height + 1000);
    CGPoint bottomLeftPoint = CGPointMake(80, -100);
    CGPoint bottomRightPoint = CGPointMake(self.frame.size.width - 80, -100);
    
    /* Create Left Wall */
    leftWall = [SKShapeNode node];
    leftWall.name = @"leftWall";
    
    leftWall.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:topLeftPoint toPoint:bottomLeftPoint];
    leftWall.physicsBody.categoryBitMask = screenCategory;
    leftWall.physicsBody.friction = 0.0f;
    [self addChild: leftWall];
    
    /* Create Right Wall */
    rightWall = [SKShapeNode node];
    rightWall.name = @"rightWall";
    
    rightWall.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:topRightPoint toPoint:bottomRightPoint];
    rightWall.physicsBody.categoryBitMask = screenCategory;
    rightWall.physicsBody.friction = 0.0f;
    [self addChild: rightWall];
    
    /* Create Bottom Wall */
    bottomWall = [SKShapeNode node];
    bottomWall.name = @"bottomWall";
    
    bottomWall.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:bottomLeftPoint toPoint:bottomRightPoint];
    bottomWall.physicsBody.categoryBitMask = screenCategory;
    bottomWall.physicsBody.friction = 0.0f;
    [self addChild: bottomWall];
}

- (void)createBox {
    int randX = (rand() % ((int)self.frame.size.width - 400) ) + 200;
    int randY = (rand() % ((int)self.frame.size.height - 300) ) + 200;
    
    CGRect boxOutline = CGRectMake(0, 0, 80.0, 80.0);
    
    box = [[SKShapeNode alloc] init];
    box.path = [UIBezierPath bezierPathWithRect:boxOutline].CGPath;
    box.fillColor = [UIColor colorWithRed:155.0f/255.0f green:77.0f/255.0f blue:206.0f/255.0f alpha:1.0];
    box.strokeColor = [UIColor colorWithRed:155.0f/255.0f green:77.0f/255.0f blue:206.0f/255.0f alpha:1.0];
    box.position = CGPointMake(randX, randY);
    box.name = @"box";
    
    box.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:boxOutline];
    box.physicsBody.categoryBitMask = boxCategory;
    
    [self addChild:box];
}

- (void)createPaddle {
    lineNode = [SKShapeNode node];
    lineNode.path = pathToDraw;
    lineNode.strokeColor = [UIColor colorWithRed:211.0f/255.0f green:204.0f/255.0f blue:80.0f/255.0f alpha:1.0];
    lineNode.fillColor = [UIColor colorWithRed:211.0f/255.0f green:204.0f/255.0f blue:80.0f/255.0f alpha:1.0];
    [self addChild:lineNode];
}

- (void)updatePaddlePhysics {
    lineNode.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:lineNode.path];
    lineNode.physicsBody.affectedByGravity = NO;
    lineNode.physicsBody.restitution = 0;
    lineNode.physicsBody.density = 1000000;
    lineNode.physicsBody.mass = 1000000;
    lineNode.physicsBody.friction = 0;
    lineNode.physicsBody.categoryBitMask = paddleCategory;
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    if([ contact.bodyA.node.name isEqualToString: @"box" ] || [ contact.bodyB.node.name isEqualToString: @"box" ]) {
        [box removeFromParent];
        [self createBox];
        current_score++;
        gameViewController.score.text = [NSString stringWithFormat:@"%d", current_score];
    }
    
    if([ contact.bodyA.node.name isEqualToString: @"bottomWall" ] || [ contact.bodyB.node.name isEqualToString: @"bottomWall" ]) {
        [gameViewController endGame];
    }
}

@end
