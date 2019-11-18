class Display{

    PFont impact_15,impact_20,georgia,wdb,tw;
    float w;
    float h;
    color c_menu_1 = color(15, 180, 60,100);
    float size_menu_h = 50;
    int chane_x = -20;
    int minus_show;
    
    Display(float _width, float _height){
        w = _width;
        h = _height;
        impact_15 = createFont("Impact", 15, true);
        impact_20 = createFont("Impact", 20, true);
        georgia = createFont("Georgia",30,true);
        wdb = createFont("WDB Bangna",30,true);
        tw = createFont("Tw Cen MT Bold",30,true);
    }
    
    void showDisplay(){
        fill(c_menu_1);
        textFont(impact_15);
        rect(w-150, h-100, size_menu_h * 2 , size_menu_h);
        fill(0);
        text("NORTH", w-150, h-100);
    }
    void timeDisplay(int day,int hour,int minus){
        minus = minus % 60;
        fill(0);
        textFont(tw);
        text("Date[", 30, 50);
        text(" 3/", 100, 50);
        text(str(day), 150, 50);
        text("/16", 150, 50);
        text("]", 250, 50);
        text("Time[", 30, 80);
        if(str(hour).length()<2){
            text("0", 100, 80);
        }
        text(" "+str(hour), 110, 80);
        text(":", 140, 80);
        if(str(minus).length()<2){
            text("0", 150, 80);
            text(""+str(minus), 170, 80);
        }else {
            text(""+str(minus), 150, 80);
        }
        text(":"+(frameCount%60), 190, 80);
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

    void interactDisplay(){
        if (mouseX >= 50 && mouseX <= 150 && mouseY >= 640 && mouseY <= 690) {
  
        }
    }
  

}
