//
//  BulletNode.h
//  textshooter3
//
//  Created by Hongchao Ma on 2015-09-12.
//  Copyright (c) 2015 Hongchao Ma. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BulletNode : SKNode

+(instancetype) bulletFrom:(CGPoint)star toward:(CGPoint) stop;
-(void) applyRecurringForce;



@end
