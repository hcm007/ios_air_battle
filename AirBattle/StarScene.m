//
//  StarScene.m
//  textshooter3
//
//  Created by Hongchao Ma on 2015-09-13.
//  Copyright (c) 2015 Hongchao Ma. All rights reserved.
//

#import "StarScene.h"
#import "LevelScene.h"
#import "EnemyNode.h"

#define ARC4RANDOM_MAX 0x100000000


@interface StarScene()


@property(strong,nonatomic) SKNode *enemies;


@end





@implementation StarScene

-(instancetype) initWithSize:(CGSize)size
{

    
    
    if (self=[super initWithSize:size]) {
      //  self.backgroundColor=[SKColor yellowColor];
       
        SKSpriteNode *luqing=[SKSpriteNode spriteNodeWithImageNamed:@"china.png"];
        luqing.size=CGSizeMake(100, 100);
        // luqing.alpha=;
        
        luqing.position=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:luqing];
        
        
        
        
        
        
        
        
        SKLabelNode *gameName=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        gameName.text=@"Air Battle";
        gameName.fontColor=[SKColor blueColor];
        gameName.fontSize=50;
        gameName.position=CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.8);
        [self addChild:gameName];
        
        
        
        SKLabelNode *touch=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        touch.text=@"you can touch everywhere";
        touch.fontSize=20;
        touch.fontColor=[SKColor blueColor];
        touch.position=CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.3);
        
        [self addChild:touch];
        [self runAction:[SKAction playSoundFileNamed:@"air.wav" waitForCompletion:NO]];
        [self runAction:[SKAction playSoundFileNamed:@"gun.wav" waitForCompletion:NO]];
        
        
        
        
        _enemies=[[SKNode alloc]init];
        [self addChild:_enemies];
        [self locateEnemies];
        
    }
    return self;

}


-(void)locateEnemies{

    
    
    for (NSInteger i=0; i<100; i++) {
        EnemyNode *enemy=[[EnemyNode alloc] init];
        enemy.physicsBody.affectedByGravity=YES;
        self.physicsWorld.gravity=CGVectorMake(0, -0.01);
        CGSize size=self.frame.size;
        CGFloat x=(size.width*arc4random()/ARC4RANDOM_MAX);
        CGFloat y=(size.height*3*arc4random()/ARC4RANDOM_MAX)+size.height;
        
        
        
        
        enemy.position=CGPointMake(x, y);
        
        
        
        
        [self.enemies addChild:enemy];//let enemy into enemies
        
        
        
        
        CGVector direction=CGVectorMake(0, -4);
        
        
        
        
         //
        enemy.physicsBody.velocity=CGVectorMake(0, -1);
        [enemy.physicsBody applyImpulse:direction atPoint:enemy.position];

        
    }
        
        
       }



















-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{

    SKTransition *transition=[SKTransition doorsOpenVerticalWithDuration:2.0];
    SKScene *game=[[LevelScene alloc] initWithSize:self.frame.size];
    [self.view presentScene:game transition:transition];
    [self runAction:[SKAction playSoundFileNamed:@"click.wav" waitForCompletion:NO]];




}
































@end
