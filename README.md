# LPXCoordinateTransfromUtil
iOS开发中常用地理坐标系转换（BD-09/WGS-84/GCJ-02）
参考https://github.com/wandergis/coordtransform。

一个提供了百度坐标（BD09）、国测局坐标（火星坐标，GCJ02）、和WGS84坐标系之间的转换的工具模块。

地球坐标 (WGS84)：

国际标准，从 GPS 设备中取出的数据的坐标系
国际地图提供商使用的坐标系


火星坐标 (GCJ-02)也叫国测局坐标系：

中国标准，从国行移动设备中定位获取的坐标数据使用这个坐标系
国家规定： 国内出版的各种地图系统（包括电子形式），必须至少采用GCJ-02对地理位置进行首次加密。

百度坐标 (BD-09)：

百度标准，百度 SDK，百度地图，Geocoding 使用
(本来就乱了，百度又在火星坐标上来个二次加密)

提供接口：
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
