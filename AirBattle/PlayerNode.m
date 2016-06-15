//
//  PlayerNode.m
//  textshooter3
//
//  Created by Hongchao Ma on 2015-09-12.
//  Copyright (c) 2015 Hongchao Ma. All rights reserved.
//

#import "PlayerNode.h"
#import "Method.h"
#import "PhysicsEngine.h"

@implementation PlayerNode


-(instancetype) init
{
    if (self=[super init]) {
        self.name=[NSString stringWithFormat:@"Player %p",self];
        [self initNodeGraph];
        
        [self initPhysicsBody];
        
    }

    return self;
    
}
-(void) initPhysicsBody{
    SKPhysicsBody *body=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20)];
    body.affectedByGravity=NO;
    body.categoryBitMask=PlayerEngine;
    body.contactTestBitMask=EnemyEngine;
    body.collisionBitMask=0;
    
    self.physicsBody=body;
    
    
    





}


-(void) initNodeGraph{

    
    SKSpriteNode *heroImage=[SKSpriteNode spriteNodeWithImageNamed:@"hero.png"];
    
   /* SKLabelNode *label=[SKLabelNode labelNodeWithFontNamed:@"Courier"];
    label.fontColor=[SKColor blackColor];
    label.fontSize=40;
    label.text=@"A";
   // label.zRotation=@"M_PI"
    label.name=@"PlayerLabel";*/
    heroImage.size=CGSizeMake(40, 40);
    [self addChild:heroImage];;

}



-(CGFloat)moveToward:(CGPoint) location{

    [self removeActionForKey:@"move"];
    [self removeActionForKey:@"rotate"];
    [self removeActionForKey:@"scale"];
    
    
    CGFloat distance=Distance(self.position, location);
    CGFloat pixels=[UIScreen mainScreen].bounds.size.width;
    CGFloat duration=2.0*distance/pixels;
    
    [self runAction:[SKAction moveTo:location duration:duration] withKey:@"move"];
    
    
   //I just want to add some movement to action
    
    if (self.position.x<location.x) {
        
    
    
    [self runAction:[SKAction rotateByAngle:M_PI/4 duration:duration] withKey:@"rotate"];
        
        [self runAction:[ SKAction
                          sequence:@[
                         
                         
                         
                         [SKAction scaleXTo:0.5 duration:0.9*duration],
                         [SKAction scaleXTo:1.0 duration:0.1*duration]]
                         
                         
                         
                        ] withKey:@"scale"];
        
        
        
        self.zRotation=-M_PI/4;
        self.xScale=1;
        
    
    }
    
    else{
        [self runAction:[SKAction rotateByAngle:(0-M_PI/4) duration:duration] withKey:@"rotate"];
        
        
        [self runAction:[ SKAction
                         sequence:@[
                                    
                                    
                                    
                                    [SKAction scaleXTo:0.5 duration:0.9*duration],
                                    [SKAction scaleXTo:1.0 duration:0.1*duration]]
                         
                         
                         
                         ] withKey:@"scale"];

        self.zRotation=M_PI/4;
        self.xScale=1;

    
    }
    
    
    
    
    
    
    
    
    return duration;

    
    
}







-(void) receiveAttacker:(SKNode *)attacker contact:(SKPhysicsContact *)contact
{
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"MyParticle1" ofType:@"sks"];
    SKEmitterNode *explosion=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    explosion.numParticlesToEmit=20;
    explosion.position=contact.contactPoint;
    [self.scene addChild:explosion];
   
    [self runAction:[SKAction playSoundFileNamed:@"truck.wav" waitForCompletion:NO]];

    
    
}

























@end
