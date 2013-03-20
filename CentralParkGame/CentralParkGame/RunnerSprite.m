//
//  RunnerSprite.m
//  Lesson1
//
//  Created by Renata Rodrigues on 3/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "RunnerSprite.h"

@interface RunnerSprite(){
}

@end

@implementation RunnerSprite

+(RunnerSprite *)runnerWithPosition:(CGPoint)position andLaneHeight:(float)height
{
    RunnerSprite *runner = [RunnerSprite spriteWithFile:@"runner.png"];
    runner.startPosition = ccp(position.x + runner.contentSize.width/2, position.y);
    runner.laneHeight = height;
    runner.position = runner.startPosition;
    runner.lives = 3;
    runner.lane = 0;
    return runner;
}

-(BOOL)didColideWithSprite:(CCSprite *)spriteFoodTest
{
    BOOL colide = NO;
    
    float foodCenter = spriteFoodTest.position.x;
    float foodHalfWidth = spriteFoodTest.contentSize.width/2;
    float runnerCenter = self.width/2;
    
    // checking x & y
    float minimumDX = 0.7*foodHalfWidth + runnerCenter;
    
    int runnerY = (int)self.position.y;
    int foodY = (int)spriteFoodTest.position.y;
    
    if ( ((foodCenter-runnerCenter) <= minimumDX) && (runnerY == foodY) ){
        colide = YES;
    }
    
    return colide;

}

-(id) init
{
	if( (self = [super init]) ) {
    }
	return self;
}

-(float)width
{
    return self.contentSize.width;
}

-(float)height
{
    return self.contentSize.height;
}

-(void)updateLane
{
    CGPoint updatedPosition = ccp(self.startPosition.x,self.startPosition.y+self.laneHeight*self.lane);
    [self stopAllActions];
    [self runAction: [CCMoveTo actionWithDuration:0.2 position:updatedPosition]];
}

-(void)moveDown
{
    if(self.lane > 0) {
        self.lane-=1;
    }
    [self updateLane];
}

-(void)moveUp
{
    if(self.lane < 2) {
        self.lane+=1;
    }
    [self updateLane];
}

-(void)colide
{
    
}

@end
