//
//  EntryCircle.m
//  LuckyTest
//
//  Created by Sufiyan Yasa on 11/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EntryCircle.h"

@interface Bck()
-(void)makePoints:(float)radius;
-(void)convertPoints:(NSMutableArray*)points;
-(void)drawScreen;
@end

@implementation Bck
@synthesize glPoints = _glPoints;

- (id)init
{
    self = [super init];
    if (self) {
        [self schedule:@selector(recalculate)];
    }
    return self;
}

//Increase the radius and regenerate points
-(void)recalculate{
    static float radius = 50;
    radius +=0.1;
    [self makePoints:radius];
}

//Calculate points
-(void)makePoints:(float) radius{
    NSMutableArray *points = [[NSMutableArray alloc]initWithCapacity:5];
    
    CGPoint centerPt = ccp(240, 160);
    
    for (int i = 0; i <= 360; i += 1) // 360 degrees
    {
        //inner circle vertex v0
        CGPoint pt = ccpAdd(centerPt, ccpMult(ccpForAngle(CC_DEGREES_TO_RADIANS(i)), radius)); //1
        [points addObject:[NSValue valueWithCGPoint:pt]];

        //outer circle vertex v1
        pt = ccpAdd(centerPt, ccpMult(ccpForAngle(CC_DEGREES_TO_RADIANS(i)), 500)); //2
        [points addObject:[NSValue valueWithCGPoint:pt]];
        
    }
    
    
    [self convertPoints:points];

}

//Convert points the ccvertex array
-(void)convertPoints:(NSMutableArray*)points{
    number_of_points = [points count];
    ccVertex2F *newPoint = malloc(number_of_points * sizeof(ccVertex2F));
    int i=0;
    for (NSValue *p in points) {
        CGPoint cp = [p CGPointValue];
        newPoint[i] = (ccVertex2F){cp.x * CC_CONTENT_SCALE_FACTOR(),cp.y *CC_CONTENT_SCALE_FACTOR()};
        i++;
    }
    
    self.glPoints = newPoint;
}


-(void)draw{
    [super draw];
    [self drawScreen];
}

-(void)drawScreen{
    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState((GL_TEXTURE_COORD_ARRAY));
    glDisable(GL_TEXTURE_2D);
    glVertexPointer(2, GL_FLOAT, 0, self.glPoints);
    
    glColor4f(0, 0, 0, 1.0);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, number_of_points);
    
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
}

@end

@implementation EntryCircle

+(id)scene{
    CCScene *scene =[CCScene node];
    EntryCircle *ec = [EntryCircle node];
    [scene addChild:ec];
    return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        CCSprite *ori  = [CCSprite spriteWithFile:@"Default.png"];
        ori.rotation = 90;
        ori.position = ccp(240, 160);
        [self addChild:ori];
        startPoint = ccp(240, 160);
        
        bck = [[[Bck alloc]init]autorelease];
        [self addChild:bck];
        bck.position = CGPointZero;
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}
//OnEnter with cctargeted touch
-(void) onEnter{
    [super onEnter];
}

//OnExit with remove cctargeted touch
-(void)onExit{
    [super onExit];
    
}





@end
