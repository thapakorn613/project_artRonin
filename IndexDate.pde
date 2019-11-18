class IndexDate{

    public int timeBegin ;
    public int timeEnd ;
    int day;
    int[] hours;
    public int [] listTime ;

    int index;
    
    IndexDate(){
        listTime = new int[24];
        index=0;
    }
    

    void addDay(int _day){
        day = _day;

    }
    void addHour(int _hour){
        hours[index++] = _hour;

    }
    void get(int i){
        println("day: "+day);
    }

  
}
