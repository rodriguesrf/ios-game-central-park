//
//  GameOverLayer.m
//  Lesson1
//
//  Created by Renata Rodrigues on 3/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameOverLayer.h"
#import "HelloWorldLayer.h"
#define screenWidth [[CCDirector sharedDirector] winSize].width
#define screenHeight [[CCDirector sharedDirector] winSize].height

@implementation GameOverLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	GameOverLayer *layer = [GameOverLayer node];
    
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
   
    if( (self=[super init]) ) {
        // CCMenuItemLabel* gameOver = [CCMenuItemLabel itemWithLabel:@"Game Over"];
        NSLog(@"game over scene ============= ");
        [CCMenuItemFont setFontSize:28];
        CCMenuItem *restartMenuItem = [CCMenuItemFont itemWithString:@"Play again" block:^(id sender) {
        
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[HelloWorldLayer scene] withColor:ccBLACK]];
        
        }];
    
        CCMenu * restartMenu = [CCMenu menuWithItems: restartMenuItem , nil];
        [restartMenu setPosition:ccp(screenWidth/2, screenHeight/2)];
        [self addChild:restartMenu];
    
    }
    return self;
}

@end
