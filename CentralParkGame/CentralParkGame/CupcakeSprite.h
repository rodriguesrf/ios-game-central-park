//
//  CupcakeSprite.h
//  Lesson1
//
//  Created by Renata Rodrigues on 3/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CupcakeSprite : CCSprite {
    
}

@property(nonatomic) BOOL wasHit;

+(CupcakeSprite *)cupCakeWithPosition:(CGPoint)position;

@end
