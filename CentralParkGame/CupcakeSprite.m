//
//  CupcakeSprite.m
//  Lesson1
//
//  Created by Renata Rodrigues on 3/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CupcakeSprite.h"

@implementation CupcakeSprite

+(CupcakeSprite *)cupCakeWithPosition:(CGPoint)position
{
    CupcakeSprite *cupcake = [CupcakeSprite spriteWithFile:@"cupcake.png"];
    cupcake.position = CGPointMake(position.x + cupcake.contentSize.width/2, position.y);
    cupcake.tag = 10; // processed food
    cupcake.wasHit = YES;
    return cupcake;
}

@end
