import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.marker.*;

import java.util.List;
import java.time.*;
import java.time.format.DateTimeFormatter;

Location bostonLocation = new Location(51.00755f, -113.9989f);
Location locationBerlin = new Location(51.00755f, -113.9989f);

DateTimeFormatter date_format = DateTimeFormatter.ofPattern("dd-MM-yy");

UnfoldingMap map;

Table truck_rawdata;

Location[] locations = new Location[] {
    new Location(51.00755,-113.9989),
    new Location(51.31435,-116.9732),
    new Location(53.09111,-110.6073),
    new Location(52.89921,-110.8361)
};

int c = 0; // Variable for line index
int currentLocation = 0;
int count_minus = 0;

Truck [] trucks = new Truck[5];

void setup(){
    size(800, 600, P2D);
    //size(800, 600, OPENGL);
    smooth();
    noStroke();

    //? data init
    truck_rawdata = loadTable("data/truck1week_for_test.csv", "header");
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

        trucks[count_row++] = new Truck(lat_orig,long_orig,lat_dest,long_dest,trans_duration_minutes);
    }
    for(int i=0;i<trucks.length;i++){
        trucks[i].update();
        trucks[i].calSpped();
    }
    // init Map
    map = new UnfoldingMap(this);
    //map = new UnfoldingMap(this, new StamenMapProvider.TonerBackground());
    map.zoomToLevel(15);
    map.panTo(bostonLocation);
    // map.setZoomRange(10, 15); // prevent zooming too far out
    map.setPanningRestriction(bostonLocation, 50);
    MapUtils.createDefaultEventDispatcher(this, map);
    frameRate(5); // frameRate(5) -> frameCount % 10 เปลี่ยนทีละ 2 วินาที
}

void draw(){
    //background(0);
    map.draw();
    Location bottomRight = map.getBottomRightBorder();
    // println("bottomRight: "+bottomRight);
    // println("locations[0]: "+locations[0]);
    
    // ScreenPosition pos1 = map.getScreenPosition(locations[0]);
    // fill(0, 200, 0, 100);
    // // float s1 = map.getZoom();
    // ellipse(pos1.x, pos1.y, 50, 50);
    // trucks[0].update();
    // trucks[0].display();
    for(int i=0;i<1;i++){
            trucks[i].update(count_minus);
            trucks[i].display();
    }
    if (frameCount % 10 == 0) {
        
        // trucks[0].display();
        // map.panTo(locations[currentLocation]);
        // Next Locations 
        currentLocation++;
        if (currentLocation >= locations.length) {
            currentLocation = 0;
        }
        println("count_minus: "+count_minus);
        count_minus++;
    }
    // //println("frameCount: "+frameCount);
    // ScreenPosition posNow = map.getScreenPosition(locations[currentLocation]);
    // fill(255, 200, 0, 100);
    // ellipse(posNow.x,posNow.y, 20, 20);

    // Fixed-size marker
    // ScreenPosition posBerlin = map.getScreenPosition(locationBerlin);
    // fill(0, 200, 0, 100);
    // ellipse(posBerlin.x, posBerlin.y, 20, 20);
}

void keyPressed() {
  if (key == ' ') {
    map.switchTweening();
  }
}
