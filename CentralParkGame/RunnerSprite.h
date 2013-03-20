//
//  RunnerSprite.h
//  Lesson1
//
//  Created by Renata Rodrigues on 3/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface RunnerSprite : CCSprite {
    
}

@property(nonatomic) NSInteger lane;
@property(nonatomic) NSInteger lives;
@property(nonatomic) CGPoint startPosition;
@property(nonatomic) float laneHeight;

-(void)moveUp;
-(void)moveDown;
-(void)colide;
-(float)width;
-(float)height;
-(BOOL)didColideWithSprite:(CCSprite *)spriteFoodTest;

+(RunnerSprite *)runnerWithPosition:(CGPoint)position andLaneHeight:(float)height;

@end
