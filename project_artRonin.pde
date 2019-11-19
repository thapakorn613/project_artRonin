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
PImage img;
Display mainDisplay ;
Table truck_rawdata;
PFont font,impact_10;

int sizeOfRow;
int count_minus = 0;

int gbl_day;
int gbl_mon;
int gbl_hour;
int gbl_minus;

int indexEnd;
int indexEnd_end;
int strDay ;
int timer ;
int temp_gbl_day;

int beginIndexDay14,beginIndexDay15,beginIndexDay16,beginIndexDay17,beginIndexDay18,beginIndexDay19,beginIndexDay20;
int temp_ran1,temp_ran2,temp_ran3,temp_ran4,temp_ran5;

boolean indexBeginOfSearch14 = false;
boolean indexBeginOfSearch15 = false;
boolean indexBeginOfSearch16 = false;
boolean indexBeginOfSearch17 = false;
boolean indexBeginOfSearch18 = false;
boolean indexBeginOfSearch19 = false;
boolean indexBeginOfSearch20 = false;

int check_row = 1;
int indexBegin = 0;
int indexListTime = 0;
int beginIndexDayBegin = 0;
int beginIndexDayEnd = 160986;
boolean debugMode = false;
boolean boolStart = false;
boolean boolStop = false;
boolean isMapBasic = true;
boolean isMapToner = false;

Truck [] trucks;
String selectDay = "14";
String savedDay = "14";
int lenEnd ;

void setup(){
    size(800, 600, P2D);
    mainDisplay = new Display(width,height);
    smooth();
    impact_10 = createFont("Impact", 10, true);
    gbl_hour = 0;
    gbl_minus = 0;
    lenEnd = 900;
    count_minus = 0;
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
        String tempCheck = row.getString("date_orig");

        int []temp_date = int(split(tempCheck,'-'));
        temp_gbl_day = temp_date[0];

        if( temp_gbl_day == 14 && indexBeginOfSearch14 == false){
            beginIndexDay14 = count_row;
            indexBeginOfSearch14 = true;
        }
        if( temp_gbl_day == 15 && indexBeginOfSearch15 == false){
            beginIndexDay15 = count_row;
            indexBeginOfSearch15 = true;
        }
        if( temp_gbl_day == 16 && indexBeginOfSearch16 == false){
            beginIndexDay16 = count_row;
            indexBeginOfSearch16 = true;
        }
        if( temp_gbl_day == 17 && indexBeginOfSearch17 == false){
            beginIndexDay17 = count_row;
            indexBeginOfSearch17 = true;
        }
        if( temp_gbl_day == 18 && indexBeginOfSearch18 == false){
            beginIndexDay18 = count_row;
            indexBeginOfSearch18 = true;
        }
        if( temp_gbl_day == 19 && indexBeginOfSearch19 == false){
            beginIndexDay19 = count_row;
            indexBeginOfSearch19 = true;
        }
        if( temp_gbl_day == 20 && indexBeginOfSearch20 == false){
            beginIndexDay20 = count_row;
            indexBeginOfSearch20 = true;
        }
        float trans_duration_minutes = Duration.between(ldt_orig, ldt_dest).toMinutes();
        String temp_time_orig = row.getString("time_orig");
        trucks[count_row++] = new Truck(lat_orig,long_orig,lat_dest,long_dest,trans_duration_minutes,temp_time_orig,count_row);
    }
    // init Map
    map = new UnfoldingMap(this);
    // map.panTo(beginLocation);
    map.zoomAndPanTo(beginLocation, 10);
    MapUtils.createDefaultEventDispatcher(this, map);
    frameRate(60); 
    timer = 10;
    indexBegin = 0;
    indexEnd_end =lenEnd;
    gbl_day = 14;
    getIndex();
}

void draw(){
    gbl_day = mainDisplay.getDay();
    map.draw();
    mainDisplay.timeDisplay(gbl_day,gbl_hour,gbl_minus);
    if(boolStart){
        for(int i = indexBegin ;i< indexEnd_end ;i++){
            trucks[i].update(gbl_minus,timer);
            trucks[i].display(gbl_day,gbl_hour,gbl_minus);
        }
        if (frameCount % timer == 0) {
            gbl_minus ++;
            if((gbl_minus % 60 == 0 )){
                gbl_hour ++;
                if(gbl_hour % 24 == 0 ){
                    gbl_day++;
                }
            }
        }
        
    }else{
        frameCount = 0;
    }
    mainDisplay.showDisplay();
    if(isMapToner == true){
        panMap();
    }
    showSelect(temp_ran1,temp_ran2,temp_ran3,temp_ran4,temp_ran5);
}

void panMap(){
    map.zoomToLevel(13);
    map.panTo(trucks[indexBegin].re_location());

}

void keyPressed(){
  if(key== '\n'){
    mainDisplay.savedDay = mainDisplay.selectDay;
    gbl_day = int(mainDisplay.savedDay);
    mainDisplay.selectDay = "";
    frameCount = 0;
    getIndex();
    createIndexRan(indexBegin,indexEnd);
    showSelect(temp_ran1,temp_ran2,temp_ran3,temp_ran4,temp_ran5);
  }else{
    mainDisplay.selectDay = mainDisplay.selectDay +key;
  }
}

void showSelect(int ind_1,int ind_2,int ind_3,int ind_4,int ind_5){
    textFont(impact_10);
    fill(255,255,255);
    text(str(gbl_day)+"/03/16 , "+trucks[ind_1].time_hour+" : "+trucks[ind_1].time_minus+" : "+trucks[ind_1].time_second,30,455);
    text(str(gbl_day)+"/03/16 , "+trucks[ind_2].time_hour+" : "+trucks[ind_2].time_minus+" : "+trucks[ind_2].time_second,30,480);
    text(str(gbl_day)+"/03/16 , "+trucks[ind_3].time_hour+" : "+trucks[ind_3].time_minus+" : "+trucks[ind_3].time_second,30,505);
    text(str(gbl_day)+"/03/16 , "+trucks[ind_4].time_hour+" : "+trucks[ind_4].time_minus+" : "+trucks[ind_4].time_second,30,530);
    text(str(gbl_day)+"/03/16 , "+trucks[ind_5].time_hour+" : "+trucks[ind_5].time_minus+" : "+trucks[ind_5].time_second,30,555);
}

void mousePressed(){
    if (mouseX >= 20 && mouseX <= 190 && mouseY >= 440 && mouseY <= 460) {
        gbl_hour = trucks[temp_ran1].time_hour;
        gbl_minus = trucks[temp_ran1].time_minus;
        indexBegin = trucks[temp_ran1].indexOfTruck;
        indexEnd_end = indexBegin + lenEnd;
    }
    if (mouseX >= 20 && mouseX <= 190 && mouseY >= 465 && mouseY <= 480) {
         gbl_hour = trucks[temp_ran2].time_hour;
         gbl_minus = trucks[temp_ran2].time_minus ;
         indexBegin = trucks[temp_ran2].indexOfTruck;
         indexEnd_end = indexBegin + lenEnd;
        
    }
    if (mouseX >= 20 && mouseX <= 190 && mouseY >= 490 && mouseY <= 510) {
         gbl_hour = trucks[temp_ran3].time_hour;
         gbl_minus = trucks[temp_ran3].time_minus ;
         indexBegin = trucks[temp_ran3].indexOfTruck;
         indexEnd_end = indexBegin + lenEnd;
    }
    if (mouseX >= 20 && mouseX <= 190 && mouseY >= 515 && mouseY <= 535) {
         gbl_hour = trucks[temp_ran4].time_hour;
         gbl_minus = trucks[temp_ran4].time_minus ;
         indexBegin = trucks[temp_ran4].indexOfTruck;
         indexEnd_end = indexBegin + lenEnd;
    }
    if (mouseX >= 20 && mouseX <= 190 && mouseY >= 540 && mouseY <= 560) {
         gbl_hour = trucks[temp_ran5].time_hour;
         gbl_minus = trucks[temp_ran5].time_minus ;
         indexBegin = trucks[temp_ran5].indexOfTruck;
         indexEnd_end = indexBegin + lenEnd;
    }
    if (mouseX >= 600 && mouseX <= 700 && mouseY >= 500 && mouseY <= 550) {
        println("reset!!");
        for (int i = indexBegin ; i < indexEnd_end; i++) {
            trucks[i].reset();    
        }
        resetToZero();
        boolStart = false;
        isMapToner = false;   
    }
    if (mouseX >= 540 && mouseX <= 640 && mouseY >= 500 && mouseY <= 550) {
        println("Start!!");
        boolStart = true;
    }
    if (mouseX >= 480 && mouseX <= 530 && mouseY >= 500 && mouseY <= 550) {
        println("Map");
        if(isMapToner == true){
            isMapToner = false;    
        }
        else if(isMapToner == false){
            isMapToner = true;
        }
        
    }
}

void getIndex(){
    if(gbl_day == 14){
        indexBegin = beginIndexDay14;
        indexEnd = beginIndexDay15;
    }else if (gbl_day == 15) {
        indexBegin = beginIndexDay15;
        indexEnd = beginIndexDay16;
    }
    else if (gbl_day == 16) {
        indexBegin = beginIndexDay16;
        indexEnd = beginIndexDay17;
    }
    else if (gbl_day == 17) {
        indexBegin = beginIndexDay17;
        indexEnd = beginIndexDay18;
    }
    else if (gbl_day == 18) {
        indexBegin = beginIndexDay18;
        indexEnd = beginIndexDay19;
    }
    else if (gbl_day == 19) {
        indexBegin = beginIndexDay19;
        indexEnd = beginIndexDay20;
    }
    
    else if (gbl_day == 20) {
        indexBegin = beginIndexDay20;
        indexEnd = beginIndexDayEnd;
    }
    else {
        indexBegin = 0;
        indexEnd = lenEnd;
    }
    indexEnd_end = indexBegin + lenEnd;
}

void createIndexRan(int _indexBegin, int _indexEnd){
    temp_ran1 = constrain(temp_ran1, _indexBegin, _indexEnd);
    temp_ran2 = constrain(temp_ran2, _indexBegin, _indexEnd);
    temp_ran3 = constrain(temp_ran3, _indexBegin, _indexEnd);
    temp_ran4 = constrain(temp_ran4, _indexBegin, _indexEnd);
    temp_ran5 = constrain(temp_ran5, _indexBegin, _indexEnd);
    temp_ran1 = (int)random(_indexBegin, _indexEnd);
    temp_ran2 = (int)random(_indexBegin, _indexEnd);
    temp_ran3 = (int)random(_indexBegin, _indexEnd);
    temp_ran4 = (int)random(_indexBegin, _indexEnd);
    temp_ran5 = (int)random(_indexBegin, _indexEnd);
    
}

void resetToZero(){
    map = new UnfoldingMap(this);
    map.zoomAndPanTo(beginLocation, 10);
    MapUtils.createDefaultEventDispatcher(this, map);
    gbl_day = 0;
    gbl_hour = 0;
    gbl_minus = 0;
    indexBegin = 0;
    indexEnd = lenEnd;
    indexEnd_end = lenEnd;
    savedDay = "14";
    frameCount = 0;
}
