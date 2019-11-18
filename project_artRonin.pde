import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.marker.*;

import java.util.List;
import java.time.*;
import java.time.format.DateTimeFormatter;

Location beginLocation = new Location(51.00755f, -113.9989f);

DateTimeFormatter date_format = DateTimeFormatter.ofPattern("dd-MM-yy");

UnfoldingMap map;

Display mainDisplay ;

Table truck_rawdata;
PFont font;

int sizeOfRow ;
int c = 0; // Variable for line index
int currentLocation = 0;
int count_minus = 0;

int gbl_day;
int gbl_mon;

int gbl_hour;
int gbl_minus;
boolean debugMode = false;
int timer ;
Truck [] trucks;
// Truck [] trucks = new Truck[160986];

void setup(){
    size(800, 600, P2D);
    mainDisplay = new Display(width,height);
    //size(800, 600, OPENGL);
    smooth();
    noStroke();
    gbl_hour = 0;
    gbl_minus = 0;

    font = createFont("Impact", 30, true);
    //? data init

    if(debugMode == true){
        truck_rawdata = loadTable("data/truck1week_for_test.csv", "header");
        sizeOfRow = 5;
        trucks = new Truck[sizeOfRow];
    }else {
        truck_rawdata = loadTable("data/truck1week.csv", "header");    
        sizeOfRow = 160986;
        trucks = new Truck[sizeOfRow];
    }
    println(truck_rawdata.getRowCount() + " total rows in table");
    int count_row = 0;
    for (TableRow row : truck_rawdata.rows()) 
    {
        //? get origin lat-long
        float lat_orig = row.getFloat("Latitude_orig");
        float long_orig = row.getFloat("Longitude_orig");

        //? get destination lat-long
        float lat_dest = row.getFloat("Latitude_dest");
        float long_dest = row.getFloat("Longitude_dest");

        //? get transportation duration
        LocalDateTime ldt_orig = LocalDateTime.of(LocalDate.parse(row.getString("date_orig"), date_format), LocalTime.parse(row.getString("time_orig")));
        LocalDateTime ldt_dest = LocalDateTime.of(LocalDate.parse(row.getString("date_dest"), date_format), LocalTime.parse(row.getString("time_dest")));
        
        //? find duration between origin & destination
        float trans_duration_minutes = Duration.between(ldt_orig, ldt_dest).toMinutes();
        // float trans_duration_minutes = Duration.between(ldt_orig, ldt_dest).toMinutes();
        // float trans_duration_minutes = Duration.between(ldt_orig, ldt_dest).toMinutes();
        String temp_time_orig = row.getString("time_orig");
        trucks[count_row++] = new Truck(lat_orig,long_orig,lat_dest,long_dest,trans_duration_minutes,temp_time_orig);
    }
    // init Map
    map = new UnfoldingMap(this);
    //map = new UnfoldingMap(this, new StamenMapProvider.TonerBackground());
    map.zoomToLevel(5);
    map.panTo(beginLocation);
    map.setZoomRange(4, 14); // prevent zooming too far out
    map.setPanningRestriction(beginLocation, 50);
    MapUtils.createDefaultEventDispatcher(this, map);
    frameRate(60); // frameRate(5) -> frameCount % 10 เปลี่ยนทีละ 2 วินาที
    timer = 15;
    println("framecOUNT:",frameCount);
}

void draw(){
    // background(0);
    map.draw();
    if(debugMode == true){
        mainDisplay.debugPoint();
    }
    
    mainDisplay.timeDisplay(gbl_day,gbl_hour,gbl_minus);
    
    for(int i=0;i< 100 ;i++){
        trucks[i].update(timer);
        trucks[i].display(gbl_day,gbl_hour,gbl_minus);
    }
    
    if (frameCount % timer == 0) {
        println("gbl_minus: "+gbl_minus);
        gbl_minus ++;
        if((gbl_minus % 60 == 0 )){
            gbl_hour ++;
        }
    }
   
    // if (frameCount % 24 == 0) {
    //     println("gbl_minus: "+gbl_hour);
    //     gbl_minus ++;
    //     if((gbl_minus % 60 == 0 )){
    //         gbl_hour ++;
    //     }
    // }
    
    //println("count_minus: "+count_minus);
    // ScreenPosition posNow = map.getScreenPosition(locations[currentLocation]);
    // fill(255, 200, 0, 100);
    // ellipse(posNow.x,posNow.y, 20, 20);

    // Fixed-size marker
    // ScreenPosition posBerlin = map.getScreenPosition(locationBerlin);
    // fill(0, 200, 0, 100);
    // ellipse(posBerlin.x, posBerlin.y, 20, 20);
    
    
    mainDisplay.showDisplay();
}


void mousePressed() {
    mainDisplay.interactDisplay();
   
}
