//
//  BulletNode.m
//  textshooter3
//
//  Created by Hongchao Ma on 2015-09-12.
//  Copyright (c) 2015 Hongchao Ma. All rights reserved.
//

#import "BulletNode.h"
#import "Method.h"
#import "PhysicsEngine.h"

@interface BulletNode()
@property(assign,nonatomic) CGVector thrust;


@end







@implementation BulletNode

-(instancetype) init{
    if (self=[super init]) {
        SKLabelNode *dot=[SKLabelNode labelNodeWithFontNamed:@"Courier"];
        dot.fontColor=[SKColor blueColor];
        dot.fontSize=25;
        dot.text=@".";
        [self addChild:dot];
        SKPhysicsBody *body=[SKPhysicsBody bodyWithCircleOfRadius:1];
        body.dynamic=YES;
        body.categoryBitMask=PlaYerMissileEngine;
        body.collisionBitMask=EnemyEngine;
        body.contactTestBitMask=EnemyEngine;
        body.mass=0.01;
        self.physicsBody=body;
        self.name=[NSString stringWithFormat:@"Bullet %p",self];
        
        
        
    }


    return self;
    


}
+(instancetype) bulletFrom:(CGPoint)star toward:(CGPoint)stop
{

    BulletNode *bullet=[[BulletNode alloc] init];
    bullet.position=star;
    
    CGVector movement=VectorBetweenPoints(star, stop);
    CGFloat magnititude=VectorLength(movement);
    if (magnititude==0.0f) {
        return nil;
        
    }
    
    
    CGVector unitVector=VectorMultiply(movement, 1/magnititude);
    CGFloat thrustMagnititude=100.0;
    bullet.thrust=VectorMultiply(unitVector, thrustMagnititude);
    
    [bullet runAction:[SKAction playSoundFileNamed:@"enemy.wav" waitForCompletion:NO]];
    
    
    
    
    
    
    return bullet;
    }


-(void) applyRecurringForce
{

    [self.physicsBody applyForce:self.thrust];
}






























@end
