//
//  LPXCoordinateTransfromUtil.m
//  HMJK
//
//  Created by LiPengXuan on 2017/5/26.
//  Copyright © 2017年 hmyd. All rights reserved.
//

#import "LPXCoordinateTransfromUtil.h"


static double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
// π
static double pi = 3.1415926535897932384626;
// 长半轴
static double a = 6378245.0;
// 扁率
static double ee = 0.00669342162296594323;



@implementation LPXCoordinateTransfromUtil

/*
 * 百度坐标系(BD-09)  转  WGS坐标
 */
+(CLLocationCoordinate2D)wgs84frombd09:(CLLocationCoordinate2D)bd09Coord{
    

    return [self wgs84fromgcj02:[self gcj02frombd09:bd09Coord]];
}
/*
 * WGS坐标  转   百度坐标系(BD-09)
 */
+(CLLocationCoordinate2D)bd09fromwgs84:(CLLocationCoordinate2D)wgs84Coord{
    
    return [self bd09fromgcj02:[self gcj02fromwgs84:wgs84Coord]];
}

/*
 * 百度坐标系(BD-09)  转  火星坐标系(GCJ-02)  已验证
 */
+(CLLocationCoordinate2D)gcj02frombd09:(CLLocationCoordinate2D)bd09Coord{
    
    double bd_lon = bd09Coord.longitude;
    double bd_lat = bd09Coord.latitude;
    
    double x = bd_lon - 0.0065;
    double y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    double gg_lng = z * cos(theta);
    double gg_lat = z * sin(theta);
    
    return CLLocationCoordinate2DMake(gg_lat, gg_lng);
}
/*
 * 火星坐标系(GCJ-02)  转   百度坐标系(BD-09)
 */
+(CLLocationCoordinate2D)bd09fromgcj02:(CLLocationCoordinate2D)gcj02Coord{
    double lng = gcj02Coord.longitude;
    double lat = gcj02Coord.latitude;
    
    double z = sqrt(lng * lng + lat * lat) + 0.00002 * sin(lat * x_pi);
    double theta = atan2(lat, lng) + 0.000003 * cos(lng * x_pi);
    double bd_lng = z * cos(theta) + 0.0065;
    double bd_lat = z * sin(theta) + 0.006;
    
    return CLLocationCoordinate2DMake(bd_lat, bd_lng);;
}

/*
 * GCJ02(火星坐标系)  转  WGS84坐标
 */
+(CLLocationCoordinate2D)wgs84fromgcj02:(CLLocationCoordinate2D)gcj02Coord{
    if ([self out_of_china:(gcj02Coord)]) {
        return gcj02Coord;
    }
    double lng = gcj02Coord.longitude;
    double lat = gcj02Coord.latitude;
    
    double dlat = [self latTransFormfromCoord:CLLocationCoordinate2DMake(lat - 35.0, lng - 105.0)];
    double dlng = [self lngTransFormfromCoord:CLLocationCoordinate2DMake(lat - 35.0, lng - 105.0)];
    
    double radlat = lat / 180.0 * pi;
    double magic = sin(radlat);
    magic = 1 - ee * magic * magic;
    double sqrtmagic = sqrt(magic);
    dlat = (dlat * 180.0) / ((a * (1 - ee)) / (magic * sqrtmagic) * pi);
    dlng = (dlng * 180.0) / (a / sqrtmagic * cos(radlat) * pi);
    double mglat = lat + dlat;
    double mglng = lng + dlng;
    
    return CLLocationCoordinate2DMake(lat * 2 - mglat, lng * 2 - mglng);
}

/*
 * WGS84坐标  转  GCJ02(火星坐标系)
 */
+(CLLocationCoordinate2D)gcj02fromwgs84:(CLLocationCoordinate2D)wgs84Coord{
    if ([self out_of_china:(wgs84Coord)]) {
        return wgs84Coord;
    }
    double lng = wgs84Coord.longitude;
    double lat = wgs84Coord.latitude;
    
    double dlat = [self latTransFormfromCoord:CLLocationCoordinate2DMake(lat - 35.0, lng - 105.0)];
    double dlng =[self lngTransFormfromCoord:CLLocationCoordinate2DMake(lat - 35.0, lng - 105.0)];
    
    double radlat = lat / 180.0 * pi;
    double magic = sin(radlat);
    magic = 1 - ee * magic * magic;
    double sqrtmagic = sqrt(magic);
    dlat = (dlat * 180.0) / ((a * (1 - ee)) / (magic * sqrtmagic) * pi);
    dlng = (dlng * 180.0) / (a / sqrtmagic * cos(radlat) * pi);
    double mglat = lat + dlat;
    double mglng = lng + dlng;
    
    return CLLocationCoordinate2DMake(mglat, mglng);
    
   
}
/**
 * 纬度转换
 */
+(double)latTransFormfromCoord:(CLLocationCoordinate2D)coord{
    
    double lng = coord.longitude;
    double lat = coord.latitude;
    
    double ret = -100.0 + 2.0 * lng + 3.0 * lat + 0.2 * lat * lat + 0.1 * lng * lat + 0.2 *sqrt(fabs(lng));
    ret += (20.0 * sin(6.0 * lng * pi) + 20.0 * sin(2.0 * lng * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(lat * pi) + 40.0 * sin(lat / 3.0 * pi)) * 2.0 / 3.0;
    ret += (160.0 * sin(lat / 12.0 * pi) + 320 * sin(lat * pi / 30.0)) * 2.0 / 3.0;
    
    return ret;
}
/**
 * 经度转换
 */
+(double)lngTransFormfromCoord:(CLLocationCoordinate2D)coord{
    double lng = coord.longitude;
    double lat = coord.latitude;
    
    double ret = 300.0 + lng + 2.0 * lat + 0.1 * lng * lng + 0.1 * lng * lat + 0.1 * sqrt(fabs(lng));
    ret += (20.0 * sin(6.0 * lng * pi) + 20.0 * sin(2.0 * lng * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(lng * pi) + 40.0 * sin(lng / 3.0 * pi)) * 2.0 / 3.0;
    ret += (150.0 * sin(lng / 12.0 * pi) + 300.0 * sin(lng / 30.0 * pi)) * 2.0 / 3.0;
    return ret;
    
}
/**
 * 判断是否在国内，不在国内不做偏移
 */
+(BOOL)out_of_china:(CLLocationCoordinate2D)coord{
    if (coord.latitude < 72.004 || coord.longitude > 137.8347) {
        return YES;
    } else if (coord.latitude  < 0.8293 || coord.latitude  > 55.8271) {
        return YES;
    }
    return NO;
}

@end
