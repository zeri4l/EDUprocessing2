
float x2, y2, d2, vx2, vy2;
void setup() {

  size(800, 600);
  x2 = 300;
  y2 = 200;
  d2 = 15;
  vx2 = 2;
  vy2 = 2;
}
void draw(){
  background(0,255,255);
  x2 += vx2; 
  y2 +=vy2; 
  kjm(x2,y2,d2); 

if(x2<0 || x2>width) vx2 = -vx2;   
if(y2<0 || y2>height) vy2 = -vy2; 

}
 void kjm(float kim, float jae, float min){
 fill(80,80,80);
 quad(kim,jae,kim,jae+15*min,kim+20*min,jae+15*min,kim+20*min,jae);
 fill(255,255,255);
 square(kim+6*min,jae+5*min,2*min);
 square(kim+12*min,jae+5*min,2*min);
 stroke(255,255,255);
line(kim+9*min,jae+7*min,kim+11*min,jae+7*min);
noStroke();
fill(255,164,179);
triangle(kim+10*min,jae-6*min,kim+8*min,jae,kim+12*min,jae);
fill(255,255,0);
circle(kim+10*min,jae-6*min,2*min);
}
