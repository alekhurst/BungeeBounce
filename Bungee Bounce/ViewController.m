//
//  ViewController.m
//  Bungee Bounce
//
//  Created by Alek Lord Hurst on 11/11/14.
//  Copyright (c) 2014 Alek Lord Hurst. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)startGame{
    UIStoryboard *storyboard = self.storyboard;
    GameViewController *gvc = [storyboard instantiateViewControllerWithIdentifier:@"GameVC"];
    gvc.delegate = self;
    [self presentViewController:gvc animated:YES completion:nil];
}

-(void)sendDataToViewController:(NSString *)score
{
    self.high_score.text = score;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"view-controller-background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
