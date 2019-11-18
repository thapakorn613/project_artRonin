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
    // Location temp3;
    ScreenPosition screenPos_origin;
    ScreenPosition screenPos_on_time;
    ScreenPosition screenPos_destinetion;
    ScreenPosition tempPos;
    // ScreenPosition[] screenPos_dest = new ScreenPosition[1];

    float lat_origin;
    float long_origin;

    float old_lat;
    float old_long;

    float lat_dest;
    float long_dest;

    float duration_lati;
    float duration_long;

    float duration_time;
    int time_day;
    public int time_hour;
    public int time_minus;
    public int time_second;

    int time_orig;
    public int indexOfTruck;
    boolean begin_start = false;

    float duration_dist;
    float speed_lati;
    float speed_long;
    color c_orign;
    color c_dest;
    int gbl_length;
    int check_lat,check_long;
    public boolean plot_end;

    Truck(float _lati_o,float _long_o,float _lati_d,float _long_d,float _duration,String _time_orig ,int _indexOfTruck){
        loc_orig[0] = new Location(_lati_o,_long_o);
        loc_dest = new Location(_lati_d,_long_d);
        lat_origin = _lati_o;
        long_origin = _long_o;
        indexOfTruck = _indexOfTruck;
        old_lat = _lati_o;
        old_long = _long_o;
        plot_end = false;
        lat_dest = _lati_d;
        long_dest = _long_d;

        int []temp_time = int(split(_time_orig,':'));
        time_hour = temp_time[0];
        time_minus = temp_time[1];
        time_second = temp_time[2];


        duration_lati = _lati_d - _lati_o;
        duration_long = _long_d - _long_o;
        duration_time = _duration;
        c_orign = color(random(100, 255),random(100, 255), random(100, 255), 200);
        duration_dist = dist(lat_origin, long_origin, lat_dest, long_dest);
        speed_lati = duration_lati /duration_time;
        speed_long = duration_long /duration_time;
        println();

    }

    
    public void update(int _timer) {        
        if(begin_start == true){
            if( frameCount % _timer == 0){
                lat_origin = lat_origin + speed_lati;
                long_origin = long_origin + speed_long;
                if( lat_origin >= lat_dest){
                    plot_end = true;
                }
            }
        }
    }

    public void display(int day,int _hour,int _minus){
        if( _hour == time_hour && _minus == time_minus){
            begin_start = true;
        }
        if(begin_start == true && plot_end == false){
            if(_minus<duration_time ){
                Location temp1 = new Location(lat_origin,long_origin);
                screenPos_on_time = map.getScreenPosition(temp1); 

                Location temp2 = new Location(old_lat,old_long);
                screenPos_origin = map.getScreenPosition(temp2); 
                
                Location temp3 = new Location(lat_dest,long_dest);
                screenPos_destinetion = map.getScreenPosition(temp3); 


                strokeWeight(5);
                stroke(c_orign);
                line(screenPos_on_time.x, screenPos_on_time.y, screenPos_origin.x, screenPos_origin.y);

                ellipseMode(CENTER);
                fill(c_orign);
                ellipse(screenPos_origin.x, screenPos_origin.y, 10, 10);

                strokeWeight(2);
                stroke(c_orign);
                fill(0,0,0);
                ellipse(screenPos_destinetion.x, screenPos_destinetion.y, 10, 10);

            }
            // Location temp2 = new Location(old_lat,old_long);
            // screenPos_destinetion = map.getScreenPosition(temp2); 
            // ellipse(screenPos_destinetion.x, screenPos_destinetion.y, 10, 10);
        }
    }

}
