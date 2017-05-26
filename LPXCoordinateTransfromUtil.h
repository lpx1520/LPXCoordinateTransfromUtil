//
//  LPXCoordinateTransfromUtil.h
//  HMJK
//
//  Created by LiPengXuan on 2017/5/26.
//  Copyright © 2017年 hmyd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>


@interface LPXCoordinateTransfromUtil : NSObject
/*
 * 百度坐标系(BD-09)  转  WGS坐标
 */
+(CLLocationCoordinate2D)wgs84frombd09:(CLLocationCoordinate2D)bd09Coord;
/*
 * WGS坐标  转   百度坐标系(BD-09)
 */
+(CLLocationCoordinate2D)bd09fromwgs84:(CLLocationCoordinate2D)wgs84Coord;
/*
 * 百度坐标系(BD-09)  转  火星坐标系(GCJ-02)
 */
+(CLLocationCoordinate2D)gcj02frombd09:(CLLocationCoordinate2D)bd09Coord;
/*
 * 火星坐标系(GCJ-02)  转   百度坐标系(BD-09)
 */
+(CLLocationCoordinate2D)bd09fromgcj02:(CLLocationCoordinate2D)gcj02Coord;
/*
 * GCJ02(火星坐标系)  转  WGS84坐标
 */
+(CLLocationCoordinate2D)wgs84fromgcj02:(CLLocationCoordinate2D)gcj02Coord;
/*
 * WGS84坐标  转  GCJ02(火星坐标系)
 */
+(CLLocationCoordinate2D)gcj02fromwgs84:(CLLocationCoordinate2D)wgs84Coord;
@end
