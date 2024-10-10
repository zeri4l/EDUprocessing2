void setup() {
  int [] x;
  int [] dx;      
  x = new float[50];                                           
  for (int i=1; i<51; i++) {
     if(i%2 != 0) {
        x[i-1] = i;}
     else x[i-1] = 0;
     println(x[i-1]);
}
}