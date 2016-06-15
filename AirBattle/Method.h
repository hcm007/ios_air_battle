//
//  Method.h
//  textshooter3
//
//  Created by Hongchao Ma on 2015-09-12.
//  Copyright (c) 2015 Hongchao Ma. All rights reserved.
//

#ifndef textshooter3_Method_h
#define textshooter3_Method_h


static inline CGVector VectorMultiply(CGVector v,CGFloat m)
{
    return CGVectorMake(v.dx*m, v.dy*m);
    



}

static inline CGVector VectorBetweenPoints(CGPoint p1,CGPoint p2)
{
    return CGVectorMake(p2.x-p1.x, p2.y-p1.y);



}


static inline CGFloat VectorLength(CGVector v)
{

    return sqrtf( powf(v.dx, 2)+powf(v.dy, 2)     );
    

}








static inline CGFloat Distance(CGPoint p1,CGPoint p2)
{
    return sqrtf(   powf(p1.x-p2.x, 2)+powf(p1.y-p2.y, 2)       )  ;
    


}













#endif
