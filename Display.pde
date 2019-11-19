class Display{

    PFont impact_15,impact_20,georgia,wdb,tw,impact_10;
    float w;
    float h;
    color c_menu_start = color(15, 180, 60,100);
    color c_menu_reset = color(15, 180, 255,100);
    float size_menu_h = 50;
    int chane_x = -20;
    int minus_show;
    public String savedDay = "14";
    public String selectDay= "";

    PImage img;

    Display(float _width, float _height){
        w = _width;
        h = _height;
        impact_10 = createFont("Impact", 10, true);
        impact_15 = createFont("Impact", 15, true);
        impact_20 = createFont("Impact", 20, true);
        georgia = createFont("Georgia",30,true);
        wdb = createFont("WDB Bangna",30,true);
        tw = createFont("Tw Cen MT Bold",30,true);
        selectDay = "";
        img = loadImage("/data/img/compass.png");
    }
    
    void showDisplay(){
        displaySearch();
        fill(c_menu_start);
        textFont(impact_15);

        rect(540, 500, 100, 50);
        textFont(tw);
        fill(0);
        text("Start!!", 555, 540);
        
        fill(255,255,0,100);
        rect(480, 500, 50, 50);
        textFont(impact_15);
        fill(0);
        text("Pan", 485, 540);

        fill(0);
        text("Map : Thapakorn", 535, 490);
        fill(c_menu_reset);
        rect(650, 500, 100, 50);
        textFont(tw);
        fill(0);
        text("Reset!!", 660, 540);

        textFont(impact_20);
        fill(0);
        text("Select Day to show:",25,365);
        text("=> ",25,390);
        text(selectDay,59,390);
        fill(0);
        text("Date : ",25,430);
        fill(255,0,0);
        text(savedDay,80,430);
    }

    void displaySearch(){
        noStroke();
        fill(255,255,50,150);
        rect(15, 368, 180 , 28);
        fill(50,255,50,150);
        rect(15, 400, 180 , 180);
        fill(0,0,0);
        rect(20, 440, 170 , 20);
        rect(20, 465, 170 , 20);
        rect(20, 490, 170 , 20);
        rect(20, 515, 170 , 20);
        rect(20, 540, 170 , 20);
        image(img, 630, 10, 150, 150);
    }
    public int getDay(){
        return int(savedDay);
    }

    void timeDisplay(int day,int hour,int minus){
        minus = minus % 60;
        fill(0);
        textFont(tw);
        text("Date[ ", 30, 50);
        text(""+str(day), 100, 50);
        text("/03 ", 140, 50);
        text("/16", 190, 50);
        text("]", 240, 50);
        text("Time[", 30, 80);
        if(str(hour).length()<2){
            text("0", 100, 80);
            text(" "+str(hour), 110, 80);    
        }else {
            text(" "+str(hour), 95, 80);    
        }
        text(":", 140, 80);
        if(str(minus).length()<2){
            text("0", 150, 80);
            text(""+str(minus), 170, 80);
        }else {
            text(""+str(minus), 150, 80);
        }
        text(":", 190, 80);
        if(str((frameCount%60)).length()<2){
            text("0", 200, 80);
            text(""+(frameCount%60), 220, 80);
        }else {
            text(""+(frameCount%60), 200, 80);
        }
        text("]", 235, 80);
        textFont(impact_15);
        text("hour", 107, 95);
        text("minus", 150, 95);
        text("sec", 200, 95);

    }

    void debugPoint(){
        textFont(impact_20);
        fill(255,0,0);
        text(str(mouseX)+",", mouseX+20, mouseY+20);
        text(str(mouseY), mouseX+60, mouseY+20);

    }

  

}
