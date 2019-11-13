import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.marker.*;
import java.util.List;

Location bostonLocation = new Location(51.00755f, -113.9989f);
Location locationBerlin = new Location(51.00755f, -113.9989f);

UnfoldingMap map;

Location[] locations = new Location[] {
    new Location(51.00755f, -113.9979f),
    new Location(51.00765f, -113.9989f),
    new Location(51.00800f, -114.0009f)
};

int c = 0; // Variable for line index
int currentLocation = 0;

void setup(){
    size(800, 600, P2D);
    //size(800, 600, OPENGL);
    smooth();
    noStroke();

     map = new UnfoldingMap(this);
    //map = new UnfoldingMap(this, new StamenMapProvider.TonerBackground());
    map.zoomToLevel(12);
    map.panTo(bostonLocation);
    map.setZoomRange(10, 14); // prevent zooming too far out
    map.setPanningRestriction(bostonLocation, 50);
    MapUtils.createDefaultEventDispatcher(this, map);
    frameRate(5); // frameRate(5) -> frameCount % 10 เปลี่ยนทีละ 2 วินาที
}

void draw(){
    background(0);
    map.draw();

    if (frameCount % 10 == 0) {
        map.panTo(locations[currentLocation]);
        // Next Locations 
        currentLocation++;
        if (currentLocation >= locations.length) {
            currentLocation = 0;
        }
    }
    println("frameCount: "+frameCount);
    ScreenPosition posNow = map.getScreenPosition(locations[currentLocation]);
    fill(255, 200, 0, 100);
    ellipse(posNow.x,posNow.y, 20, 20);

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
