//
//  GameOverScene.m
//  textshooter3
//
//  Created by Hongchao Ma on 2015-09-13.
//  Copyright (c) 2015 Hongchao Ma. All rights reserved.
//

#import "GameOverScene.h"
#import "StarScene.h"

@implementation GameOverScene

-(instancetype) initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        self.backgroundColor=[SKColor greenColor];
        SKLabelNode *text=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        text.text=@"DEFEAT";
        text.fontColor=[SKColor redColor];
        text.fontSize=50;
        text.position=CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
        [self addChild:text];
    }

    return self;
    
}


-(void)didMoveToView:(SKView *)view
{
    [self performSelector:@selector(goStar) withObject:nil afterDelay:4.0];

}

-(void) goStar{


    SKTransition *transition=[SKTransition flipHorizontalWithDuration:2.0];
    SKScene *star=[[StarScene alloc] initWithSize:self.frame.size];
    [self.view presentScene:star transition:transition];
    



}





@end
