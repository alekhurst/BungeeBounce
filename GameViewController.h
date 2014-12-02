//
//  GameViewController.h
//  Bungee Bounce
//
//  Created by Alek Lord Hurst on 11/11/14.
//  Copyright (c) 2014 Alek Lord Hurst. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol senddataProtocol <NSObject>
-(void)sendDataToViewController:(NSString *)score;
@end

@interface GameViewController : UIViewController

@property(nonatomic,assign)id delegate;
@property(nonatomic,retain) IBOutlet UILabel *score;

-(void)endGame;
@end
