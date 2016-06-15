//
//  LevelScene.h
//  textshooter3
//
//  Created by Hongchao Ma on 2015-09-12.
//  Copyright (c) 2015 Hongchao Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <SpriteKit/SpriteKit.h>//the system cannot provide the header

@interface LevelScene : SKScene
@property(assign,nonatomic)NSUInteger levelNumber;
@property(assign,nonatomic)NSUInteger playerLives;
@property(assign,nonatomic)BOOL finished;

+(instancetype)sceneWithSize:(CGSize)size levelNumber:(NSInteger)levelNumber;
-(instancetype)initWithSize:(CGSize)size levelNumber:(NSInteger) levelNumber;




@end
