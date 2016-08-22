package com.marklogic.support.geoip;

/**
 * Created by ableasdale on 25/05/2016.
 */
public class Config {

//    public static String BASE_DATA_DIR = "/Users/ableasdale/Downloads/GeoLite2-Country-CSV_20160802";

    public static String BASE_DATA_DIR = "/Users/ableasdale/Downloads/IP2LOCATION-LITE-DB11.CSV";
    public static String MARKLOGIC_XCC_URI = "xcc://q:q@localhost:8000/GeoIP";
    public static Integer THREADPOOL_SIZE = 32;

    public static String HOST = "localhost";
    public static int PORT = 8000;
    public static String USER = "q";
    public static String PASSWD = "q";
    public static String DATABASE = "GeoIP";

}
