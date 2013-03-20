//
//  HelloWorldLayer.m
//  Lesson1
//
//  Created by Renata Rodrigues on 3/12/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "CCTouchDispatcher.h"
#import "CupcakeSprite.h"
#import "RunnerSprite.h"
#import "AppDelegate.h"
#import "GameOverLayer.h"

#define screenWidth [[CCDirector sharedDirector] winSize].width
#define screenHeight [[CCDirector sharedDirector] winSize].height


@interface HelloWorldLayer (){
    
    CCSprite *floor;
    CCSprite *plants;
    CCSprite *clouds;
    CCSprite *trees;
    RunnerSprite *runner;
    
    NSMutableArray *foodsArray;
    int nLanes;
    float floorWidth;
    float plantsWidth;
    float treesWidth;
    float cloudsWidth;
    float runnerWidth;
    float runnerHeight;
    float baseSpeed;
    float laneHeight;
    float pos1;
    float pos2;
    float pos3;
    BOOL didColide;
    CCLabelTTF * calLabel;
}
@end


@implementation HelloWorldLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	HelloWorldLayer *layer = [HelloWorldLayer node];
    	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	
	if( (self=[super init]) ) {
        
        calLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"calories: %i",self.calories] fontName:@"Marker Felt" fontSize:24];
        calLabel.position =  ccp(screenWidth /2 , screenHeight/2 + 80 );
        [self addChild:calLabel z:80];
        
        floor     = [CCSprite spriteWithFile:@"floor.png"];
        plants    = [CCSprite spriteWithFile:@"plants.png"];
        trees     = [CCSprite spriteWithFile:@"trees.png"];
        clouds    = [CCSprite spriteWithFile:@"clouds.png"];
        
        [self addChild:clouds];
        [self addChild:plants];
        [self addChild:trees];
        [self addChild:floor];
        
        baseSpeed = 300;
        nLanes = 3;
        laneHeight = (screenHeight/2) / nLanes;
        pos1 = laneHeight;
        pos2 = 2 * laneHeight;
        pos3 = 3 * laneHeight;
        self.nCupcakes = 0;
        
        floorWidth   = floor.contentSize.width;
        plantsWidth  = plants.contentSize.width;
        treesWidth   = trees.contentSize.width;
        cloudsWidth  = clouds.contentSize.width;
        runnerWidth  = runner.contentSize.width;
        runnerHeight = runner.contentSize.height;
        
        floor.position   = ccp(floorWidth/2, screenHeight/2);
        plants.position  = ccp(plantsWidth/2, screenHeight/2);
        trees.position   = ccp(treesWidth/2, screenHeight/2);
        clouds.position  = ccp(cloudsWidth/2, screenHeight/2);
        
        runner = [RunnerSprite runnerWithPosition:ccp(runnerWidth/2, pos1) andLaneHeight:laneHeight];
        [self addChild:runner z:100];

        foodsArray = [NSMutableArray arrayWithCapacity:0];
       
        [self foodRandomSprites];
        
        [self schedule:@selector(nextFrame:)];
        
        self.isTouchEnabled = YES;

        
    }

	return self;
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
   	CGPoint location = [self convertTouchToNodeSpace: touch];
    if (location.y >= screenHeight/2) {
        [runner moveUp];
    } else {
        [runner moveDown];
    }
}

-(void)foodRandomSprites{
    
    laneHeight = (screenHeight/2) / nLanes;
    float posLane = (1+(arc4random()%nLanes));
    float posY = laneHeight * posLane;
    
    CupcakeSprite *cupcake = [CupcakeSprite cupCakeWithPosition:CGPointMake(screenWidth,posY)];
    cupcake.wasHit = NO;
    [foodsArray addObject:cupcake];
    [self addChild:cupcake z:10-posLane];
   
}

-(void) nextFrame:(ccTime)dt{
        
    floor.position = ccp(floor.position.x - dt * baseSpeed, floor.position.y);
    plants.position = ccp(plants.position.x - dt * baseSpeed/2, plants.position.y);
    trees.position = ccp(trees.position.x - dt * baseSpeed/3, trees.position.y);
    clouds.position = ccp(clouds.position.x - dt * baseSpeed/4, clouds.position.y);
    
    if(foodsArray.count > 0) {
        
        NSMutableArray *foodsToRemove = [NSMutableArray arrayWithCapacity:0];
        BOOL needNewRandomFood = NO;
        
        for(CupcakeSprite *food in foodsArray) {

            food.position = ccp(food.position.x - dt * baseSpeed, food.position.y);
            
            if ([runner didColideWithSprite:food]) {
                NSLog(@"COLLISION*****");
                [self eatEffect:food];
                [foodsToRemove addObject:food];
                needNewRandomFood = YES;
            }
            
            if((food.position.x + food.contentSize.width/2) < 0) {

                [foodsToRemove addObject:food];
            }
        }
              
        for(CCSprite *food in foodsToRemove) {

            [foodsArray removeObject:food];
            [self removeChild:food cleanup:YES];
            needNewRandomFood = YES;
        }
        
        if(needNewRandomFood) {
            [self foodRandomSprites];
            // self foodRandomSprites];
        }
        
    }
    
    if (floor.position.x < 0) {
        floor.position = ccp(floorWidth/2, floor.position.y);
    }
    
    if (plants.position.x < 0) {
        plants.position = ccp(plantsWidth/2, plants.position.y);
    }
    
    if (trees.position.x < 0) {
        trees.position = ccp(treesWidth/2, trees.position.y);
    }
    
    if (clouds.position.x < 0) {
        clouds.position = ccp(cloudsWidth/2, clouds.position.y);
    }

}

-(void)eatEffect:(CCSprite*)food{
    id scaleBy = [CCScaleBy actionWithDuration:1.0 scale:3];
    [food stopAllActions];
    [food runAction:scaleBy];
    self.calories+=300;
    calLabel.string = [NSString stringWithFormat:@"calories: %i",self.calories];

    CCParticleExplosion* emitter = [[CCParticleExplosion alloc] initWithTotalParticles:1];
    emitter = [CCParticleExplosion node];
    emitter.position = food.position;
    emitter.speed = 100;
    emitter.texture = food.texture;
    //[[CCTextureCache sharedTextureCache] addImage: @"cupcake.png"];
    [self addChild:emitter z:10];
     
	self.nCupcakes++;
	if (self.nCupcakes > 3 ) {
        [self scheduleOnce:@selector(makeTransition:) delay:1];
    }
}

-(void) makeTransition:(ccTime)dt
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameOverLayer scene] withColor:ccWHITE]];
}

@end
