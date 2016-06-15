//
//  GameViewController.m
//  textshooter3
//
//  Created by Hongchao Ma on 2015-09-12.
//  Copyright (c) 2015 Hongchao Ma. All rights reserved.
//

#import "GameViewController.h"
#import "LevelScene.h"
#import "StarScene.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SKView *skview=(SKView *)self.view;
   // skview.showsFPS = YES;
   // skview.showsNodeCount = YES;
    
    // Create and configure the scene.
   // SKScene * scene = [BIDStartScene sceneWithSize:skView.bounds.size];
    LevelScene *scene=[[StarScene alloc] initWithSize:skview.bounds.size];// levelNumber:5];
    
   scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skview presentScene:scene];



}




- (BOOL)prefersStatusBarHidden {
    return YES;
}


/*- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}*/

@end
