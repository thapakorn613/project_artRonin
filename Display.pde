class Display{

    PFont font;
    float w;
    float h;
    color c_menu_1 = color(15, 180, 60,100);
    float size_menu_h = 50;
    
    
    Display(float _width, float _height){
      w = _width;
      h = _height;
    }
    
    void showDisplay(){
        fill(c_menu_1);
        rect(w-150, h-100, size_menu_h * 2 , size_menu_h);
        fill(0);
        text("NORTH", w-150, h-100);
    }
    void interactDisplay(){
        if (mouseX >= 50 && mouseX <= 150 && mouseY >= 640 && mouseY <= 690) {
  
        }



    }
  

}
