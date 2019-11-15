import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.marker.*;

class Truck{

    Location loc_orig;
    Location loc_dest;

    float[] posx = new float[1];
    float[] posy = new float[1];
    ScreenPosition screenPos_origin;
    ScreenPosition screenPos_dest;

    float lat_origin;
    float long_origin;
    float lat_dest;
    float long_dest;

    float duration_lati;
    float duration_long;

    float duration_time;
    float duration_dist;
    float speed_lati;
    float speed_long;
    color c_orign;
    color c_dest;
    int gbl_length;
    int check_lat,check_long;


    Truck(float _lati_o,float _long_o,float _lati_d,float _long_d,float _duration ){
        loc_orig = new Location(_lati_o,_long_o);
        loc_dest = new Location(_lati_d,_long_d);

        lat_origin = _lati_o;
        long_origin = _long_o;
        lat_dest = _lati_d;
        long_dest = _long_d;

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

    }
    public void update(int minus) {
        if( minus % 24 == 0){
            lat_origin = lat_origin + speed_lati;
            long_origin = long_origin + speed_long;
            // long_origin = long_origin + speed;
            // println("long_origin: "+long_origin);
        }
        // if(lat_origin >= lat_dest){
        //     speed_lati = 0;
        // }
        // if(long_origin >= long_dest){
        //     speed_long= 0;
        // }
        loc_orig = new Location(lat_origin,long_origin);
        loc_dest = new Location(lat_dest,long_dest);
        screenPos_origin = map.getScreenPosition(loc_orig); 
        screenPos_dest = map.getScreenPosition(loc_dest);

        posx = (float[])append(posx,screenPos_origin.x);
        posy = (float[])append(posy,screenPos_origin.y);
        gbl_length = posx.length;
        //duration_dist = dist(screenPos_origin.x, screenPos_origin.y, screenPos_dest.x, screenPos_dest.y);
        
        // https://andrew.hedges.name/experiments/haversine/
    }
    public void display(int minus){
        if(minus<duration_time ){
            noStroke();
            ellipseMode(CENTER);
            println("loc_orig: "+loc_orig);
            println("loc_dest: "+loc_dest);
            println("duration_time: "+duration_time);
            println("speed_lati: "+speed_lati);
            println("speed_long: "+speed_long);
            fill(c_orign);
            for(int i=0;i<gbl_length;i++){
                ellipse(posx[i],posy[i], 20, 20);
            }
            // ellipse(screenPos_origin.x, screenPos_origin.y, 20, 20);
        
            // fill(c_dest);
            // ellipse(screenPos_dest.x, screenPos_dest.y, 20, 20);
        }
    }

}
