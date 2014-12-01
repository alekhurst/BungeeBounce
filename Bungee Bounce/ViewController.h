//
//  ViewController.h
//  Bungee Bounce
//
//  Created by Alek Lord Hurst on 11/11/14.
//  Copyright (c) 2014 Alek Lord Hurst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface ViewController : UIViewController

@property(nonatomic,retain) IBOutlet UILabel *high_score;

- (IBAction)startGame;

@end

