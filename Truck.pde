import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.marker.*;

class Truck{

    // Location loc_orig;
    Location [] loc_orig = new Location[1];
    Location loc_dest;
    float sizeTruck = 5;
    Location tempLoc;
    float[] posx = new float[1];
    float[] posy = new float[1];
    // ScreenPosition screenPos_origin;
    ScreenPosition[] screenPos_origin = new ScreenPosition[1];
    ScreenPosition tempPos;
    // ScreenPosition[] screenPos_dest = new ScreenPosition[1];

    float lat_origin;
    float long_origin;
    float lat_dest;
    float long_dest;

    float duration_lati;
    float duration_long;

    float duration_time;
    int time_day;
    int time_hour;
    int time_minus;
    int time_second;

    int time_orig;

    boolean begin_start = false;

    float duration_dist;
    float speed_lati;
    float speed_long;
    color c_orign;
    color c_dest;
    int gbl_length;
    int check_lat,check_long;


    Truck(float _lati_o,float _long_o,float _lati_d,float _long_d,float _duration,String _time_orig ){
        loc_orig[0] = new Location(_lati_o,_long_o);
        loc_dest = new Location(_lati_d,_long_d);

        lat_origin = _lati_o;
        long_origin = _long_o;
        lat_dest = _lati_d;
        long_dest = _long_d;

        int []temp_time = int(split(_time_orig,':'));
        time_hour = temp_time[0];
        time_minus = temp_time[1];
        time_second = temp_time[2];

        duration_lati = _lati_d - _lati_o;
        duration_long = _long_d - _long_o;
        duration_time = _duration;
        c_orign = color(random(0, 255),random(0, 255), random(0, 255), 150);
        // c_orign = color(255, 0, 0);
        // c_dest = color(255, 255, 0);
        duration_dist = dist(lat_origin, long_origin, lat_dest, long_dest);
        // speed = duration_dist / duration_time;
        speed_lati = duration_lati /duration_time;
        speed_long = duration_long /duration_time;
        posx[0] = _lati_o;
        posy[0] = _long_o;
        print("temo_time minus :",time_hour,":",time_minus,":",time_second);
        println();

    }
    public void update(int timer) {        
        if(begin_start == true){
            if( frameCount % timer == 0){
                lat_origin = lat_origin + speed_lati;
                long_origin = long_origin + speed_long;


                posx = (float[])append(posx,lat_origin);
                posy = (float[])append(posy,long_origin);

                for (int i = 1; i < posx.length; ++i) {
                    tempLoc = new Location(posx[i],posy[i]);
                }
                loc_orig = (Location[]) append(loc_orig,tempLoc);
                // println("loc_orig : ",loc_orig);
                // loc_orig = new Location(lat_origin,long_origin);
                // tempPos = map.getScreenPosition(loc_orig); 
                // posx = (float[]) append(posx,lat_origin);
                
                for (int i = 0; i < loc_orig.length; i++) {
                    tempPos = map.getScreenPosition(loc_orig[i]);
                    
                }
                screenPos_origin = (ScreenPosition[]) append(screenPos_origin,tempPos);
                // screenPos_origin = (ScreenPosition[]) append(screenPos_origin,tempPos); 
            }
            gbl_length = posx.length;
        }
        // gbl_length = posx.length;
        //duration_dist = dist(screenPos_origin.x, screenPos_origin.y, screenPos_dest.x, screenPos_dest.y);
        
        // https://andrew.hedges.name/experiments/haversine/
    }

    public void display(int day,int _hour,int _minus){
        if( _hour == time_hour && _minus == time_minus){
            begin_start = true;
        }
        if(begin_start == true){
            if(_minus<duration_time ){
                noStroke();
                ellipseMode(CENTER);
                // println("loc_orig: "+loc_orig);
                // println("loc_dest: "+loc_dest);
                // println("duration_time: "+duration_time);
                // println("speed_lati: "+speed_lati);
                // println("speed_long: "+speed_long);

                fill(c_orign);
                // println("posx.length: "+posx.length);
                // println("loc_orig.length: "+loc_orig.length);
            

                // loc_orig = new Location(lat_origin,long_origin);
                // 
                // ellipse(screenPos_origin[0].x, screenPos_origin[0].y, 20, 20);
                for(int i=0;i<screenPos_origin.length-1;i++){
                    try {
                        ellipse(screenPos_origin[i].x, screenPos_origin[i].y, sizeTruck, sizeTruck);    
                    } catch (Exception e) {
                        // println("error: ",e);   
                    }
                }
                    // ellipse(screenPos_origin[0].x, screenPos_origin[0].y, 20, 20);
                    // ellipse(posx[i],posy[i], 20, 20);
                    // ellipse(screenPos_origin[i].x, screenPos_origin[i].y, 20, 20);
                // }
                // ellipse(screenPos_origin[0].x, screenPos_origin.y, 20, 20);
                // fill(c_dest);
                // ellipse(screenPos_dest.x, screenPos_dest.y, 20, 20);
            }
        }
    }

    
    public void update_line(int minus) {        
        if(begin_start == true){
            if( minus % 24 == 0){
                lat_origin = lat_origin + speed_lati;
                long_origin = long_origin + speed_long;
            }
            gbl_length = posx.length;
        }
    }

    public void display_line(int _hour,int _minus){
        if( _hour == time_hour && _minus == time_minus){
            begin_start = true;
        }
        if(begin_start == true){
            if(_minus<duration_time ){
                noStroke();
                
                fill(c_orign);
                for(int i=0;i<screenPos_origin.length-1;i++){
                    try {
                        ellipse(screenPos_origin[i].x, screenPos_origin[i].y, sizeTruck, sizeTruck);    
                    } catch (Exception e) {
                        // println("error: ",e);   
                    }
                }
            }
        }
    }

}
