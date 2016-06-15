//
//  LevelScene.m
//  textshooter3
//
//  Created by Hongchao Ma on 2015-09-12.
//  Copyright (c) 2015 Hongchao Ma. All rights reserved.
//

#import "LevelScene.h"
#import "PlayerNode.h"
#import "EnemyNode.h"
#import "BulletNode.h"
#import "SKNode+Extra.h"
#import "GameOverScene.h"

#define ARC4RANDOM_MAX 0x100000000


@interface LevelScene()<SKPhysicsContactDelegate>
@property(strong,nonatomic)PlayerNode *playNode;
@property(strong,nonatomic) SKNode *enemies;
@property(strong,nonatomic)SKNode *playerBullets;

@end





@implementation LevelScene
+(instancetype)sceneWithSize:(CGSize)size levelNumber:(NSInteger)levelNumber{

    return [[self alloc]initWithSize:size levelNumber:levelNumber ];
    
}

-(instancetype) initWithSize:(CGSize)size{
    return [self initWithSize:size levelNumber:1];
}

-(instancetype) initWithSize:(CGSize)size levelNumber:(NSInteger)levelNumber
{
    if (self=[super initWithSize:size]) {
        _levelNumber=levelNumber;
        _playerLives=5;//when you initialize a new scene the playerlives is 5
        //self.backgroundColor=[SKColor whiteColor];
        
        
        SKSpriteNode *luqing=[SKSpriteNode spriteNodeWithImageNamed:@"background.png"];
        luqing.size=self.frame.size;
        // luqing.alpha=;
        
        luqing.position=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:luqing];

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        SKLabelNode *lives=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        lives.fontSize=16;
        lives.fontColor=[SKColor redColor];
        lives.name=@"LivesLabel";
        lives.text=[NSString stringWithFormat:@"Lives:%lu",(unsigned long) _playerLives];
        lives.verticalAlignmentMode=SKLabelVerticalAlignmentModeTop;
        lives.horizontalAlignmentMode=SKLabelHorizontalAlignmentModeRight;
        lives.position=CGPointMake(self.frame.size.width, self.frame.size.height);
        [self addChild:lives];
        
        
        
        SKLabelNode *level=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        level.fontSize=16;
        level.fontColor=[SKColor redColor];//be careful of this one
        level.name=@"LevelLabel";
        level.text=[NSString stringWithFormat:@"Levels:%lu",(unsigned long) _levelNumber];
        level.verticalAlignmentMode=SKLabelVerticalAlignmentModeTop;
        level.horizontalAlignmentMode=SKLabelHorizontalAlignmentModeLeft;
        level.position=CGPointMake(0, self.frame.size.height);
        [self addChild:level];
        

        
        _playNode=[[PlayerNode alloc] init];
        _playNode.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame)*0.1);
        [self addChild:_playNode];
        
        
        _enemies=[[SKNode alloc]init];
        [self addChild:_enemies];
        [self spawnEnemies];
        
        
        
        _playerBullets=[[SKNode alloc]init];
        [self addChild:_playerBullets];
        
        
        self.physicsWorld.gravity=CGVectorMake(0, -0.5);
        self.physicsWorld.contactDelegate=self;
        
        
        
        
        
        
        
        
       /* SKLabelNode *winner = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        winner.text = @"You Win!";
        winner.fontSize = 65;
        winner.fontColor = [SKColor greenColor];
        winner.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
        [self addChild:winner];
*/
    }
    
    
    return self;
    
}
-(void)spawnEnemies{

    NSUInteger count=log(self.levelNumber)+self.levelNumber;
    for (NSInteger i=0; i<count; i++) {
        EnemyNode *enemy=[[EnemyNode alloc] init];
        enemy.physicsBody.affectedByGravity=YES;
        CGSize size=self.frame.size;
        CGFloat x=(size.width*0.8*arc4random()/ARC4RANDOM_MAX)+(size.width*0.1);
        CGFloat y=(size.height*0.5*arc4random()/ARC4RANDOM_MAX)+(size.height*0.5);

        enemy.position=CGPointMake(x, y);
        [self.enemies addChild:enemy];//let enemy into enemies
        
    }





}













-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint location=[touch locationInNode:self];
        if (location.y<CGRectGetHeight(self.frame)*0.2)
        
        {
            CGPoint target=CGPointMake(location.x, self.playNode.position.y);
            CGFloat duration=[self.playNode moveToward:target];
            
        }
        
        else{
        
            BulletNode *bullet=[BulletNode bulletFrom:self.playNode.position toward:location];
            if (bullet) {
                [self.playerBullets addChild:bullet];
            }
        
                }
        
        
    }


}

-(void)update:(NSTimeInterval)currentTime{
    if (self.finished) {
        return;
    }

    [self updateBullets];
    [self updateEnemies];
    
    if (![self checkGameOver]) {
        
    
        [self checkNextLevel];
    
    }
    
    
}

-(void) updateEnemies{

    NSMutableArray *enemyBydeleted=[NSMutableArray array];
    for (SKNode *enemy in self.enemies.children) {
        if (!CGRectContainsPoint(self.frame, enemy.position)) {
            [enemyBydeleted addObject:enemy];
            continue;
        }
        
        
        
        
        
        
    }
    if ([enemyBydeleted count]>0) {
        [self.enemies removeChildrenInArray:enemyBydeleted];
    }


}


-(void) checkNextLevel{

    if ([self.enemies.children count ]==0 ) {
        [self goToNextLevel];
    }


}
-(void) goToNextLevel

{ self.finished=YES;
    
    SKLabelNode *winner = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    winner.text = @"Level Complete";
    winner.fontSize = 45;
    winner.fontColor = [SKColor greenColor];
    winner.position = CGPointMake(CGRectGetMidX(self.frame),
                                  CGRectGetMidY(self.frame));
    [self addChild:winner];


    LevelScene *nextLevel=[[LevelScene alloc] initWithSize:self.frame.size levelNumber:self.levelNumber+1];
    nextLevel.playerLives=self.playerLives;
    [self.view presentScene:nextLevel transition:[SKTransition doorsCloseHorizontalWithDuration:2.0 ]];



}












-(void) updateBullets{

    NSMutableArray *bulletbydeleted=[NSMutableArray array];
    for (BulletNode *bullet in self.playerBullets.children) {
        if (!CGRectContainsPoint(self.frame, bullet.position)) {
            [bulletbydeleted addObject:bullet];
            continue;
        }
        [bullet applyRecurringForce];
        
        
    }

    [self.playerBullets removeChildrenInArray:bulletbydeleted];

}











-(void) didBeginContact:(SKPhysicsContact *)contact
{
    if (contact.bodyA.categoryBitMask==contact.bodyB.categoryBitMask) {
        SKNode *nodeA=contact.bodyA.node;
        SKNode *nodeB=contact.bodyB.node;
        
        [nodeA friendlyBumpFrom:nodeB];
        [nodeB friendlyBumpFrom:nodeA];
        
        
        
    }
    
    else {
    
        SKNode *attacker=nil;
        SKNode *attackee=nil;
        
        if (contact.bodyA.categoryBitMask>contact.bodyB.categoryBitMask) {
            attacker=contact.bodyA.node;
            attackee=contact.bodyB.node;
        }
        else {
        
            attacker=contact.bodyB.node;
            attackee=contact.bodyA.node;
        
        }
    
    
        if ([attackee isKindOfClass:[PlayerNode class]]) {
            self.playerLives--;
        }
    
        if (attacker) {
            [attackee receiveAttacker:attacker contact:contact];
            [self.playerBullets removeChildrenInArray:@[attacker]];
            [self.enemies removeChildrenInArray:@[attacker]];
            if ([attackee isKindOfClass:[EnemyNode class]]) {
                [self.enemies removeChildrenInArray:@[attackee]];
            }
            
            
            
            
        }
    
    
    
    }

}



















-(void) setPlayerLives:(NSUInteger)playerLives
{

    _playerLives=playerLives;
    SKLabelNode *lives=(id)[self childNodeWithName:@"LivesLabel"];
    lives.text=[NSString stringWithFormat:@"Lives:%lu",(unsigned long)_playerLives];



}


-(void) triggerGameOver{
    self.finished=YES;
    [_playNode removeFromParent ];
    SKTransition *transition=[SKTransition doorwayWithDuration:2.0];
    SKScene *gameOver=[[GameOverScene alloc] initWithSize:self.frame.size];
    [self.view presentScene:gameOver transition:transition];
    
    [self runAction:[SKAction playSoundFileNamed:@"gameover.wav" waitForCompletion:YES]];
    
    
    
    
    
    
    
    
    
    
    
}


-(BOOL)checkGameOver{

    if (self.playerLives==0) {
        [self triggerGameOver];
        return YES;
        
    }
    return NO;

}


/*-(void)didMoveToView:(SKView *)view
{
    while ((self.levelNumber--)!=0) {
        
    
       [self performSelector:@selector(produce) withObject:nil afterDelay:0.01];
    }

}

-(void) produce
{
    EnemyNode *enemy=[[EnemyNode alloc] init];
    enemy.physicsBody.affectedByGravity=YES;
    CGSize size=self.frame.size;
    CGFloat x=(size.width*0.8*arc4random()/ARC4RANDOM_MAX)+(size.width*0.1);
    CGFloat y=(size.height*0.2*arc4random()/ARC4RANDOM_MAX)+(size.height*0.8);
    
    enemy.position=CGPointMake(x, y);
    [self.enemies addChild:enemy];//let enemy into enemies



}
*/







@end
