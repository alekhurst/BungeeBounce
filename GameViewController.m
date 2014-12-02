//
//  GameViewController.m
//  Bungee Bounce
//
//  Created by Alek Lord Hurst on 11/11/14.
//  Copyright (c) 2014 Alek Lord Hurst. All rights reserved.
//

#import "GameViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

@implementation GameViewController
@synthesize delegate;

- (void)endGame
{
    [delegate sendDataToViewController: self.score.text];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.score.text = @"0";
}

- (void)viewWillAppear:(BOOL)animated
{
    GameScene* hello = [[GameScene alloc] initWithSize:CGSizeMake(768,1024)];
    hello.gameViewController = self;
    SKView *spriteView = (SKView *) self.view;
    [spriteView presentScene: hello];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
