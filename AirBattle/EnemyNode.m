//
//  EnemyNode.m
//  textshooter3
//
//  Created by Hongchao Ma on 2015-09-12.
//  Copyright (c) 2015 Hongchao Ma. All rights reserved.
//

#import "EnemyNode.h"
#import "Method.h"
#import "PhysicsEngine.h"
#import "SKNode+Extra.h"

@implementation EnemyNode

-(instancetype)init{

    if ([super init]) {
        self.name=[NSString stringWithFormat:@"Enemy %p",self];
        [self initNodeGraph];
        [self initPhysicsBody];
        
    }
    return self;
  }


-(void) initPhysicsBody
{
    SKPhysicsBody *body=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40, 40)];
    body.affectedByGravity=YES;
    body.categoryBitMask=EnemyEngine;
    body.contactTestBitMask=PlayerEngine|EnemyEngine;
    body.mass=0.2;
    body.angularDamping=0.0f;
    body.linearDamping=0.0f;
    self.physicsBody=body;
    
}

















-(void)initNodeGraph


{
    SKSpriteNode *enemy=[SKSpriteNode spriteNodeWithImageNamed:@"enemy.png"];
    
    enemy.size=CGSizeMake(40, 40);
    enemy.zRotation=M_PI;
    [self addChild:enemy];
    
    
    
  /*  SKLabelNode *topRow=[SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
    topRow.fontColor=[SKColor redColor];
    topRow.fontSize=20;
    topRow.text=@"x x";
    topRow.position=CGPointMake(0, 15);
    [self addChild:topRow];
    
    
    
    SKLabelNode *middleRow=[SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
    middleRow.fontColor=[SKColor redColor];
    middleRow.fontSize=20;
    middleRow.text=@"x";
    middleRow.position=CGPointMake(0,0);
    [self addChild:middleRow];

    
    
    SKLabelNode *bottomRow=[SKLabelNode labelNodeWithFontNamed:@"Courier-Bold"];
    bottomRow.fontColor=[SKColor redColor];
    bottomRow.fontSize=20;
    bottomRow.text=@"x x";
    bottomRow.position=CGPointMake(0, -15);
    [self addChild:bottomRow];*/

    
    
    



}


-(void) friendlyBumpFrom:(SKNode *)node
{
    self.physicsBody.affectedByGravity=YES;

}


-(void) receiveAttacker:(SKNode *)attacker contact:(SKPhysicsContact *)contact
{

    NSString *path=[[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
    SKEmitterNode *explosion=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    explosion.numParticlesToEmit=20;
    explosion.position=contact.contactPoint;
    [self.scene addChild:explosion];
    


}

















@end
