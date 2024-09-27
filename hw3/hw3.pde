float x3, y3, d3, vx3, vy3; 
float x1,y1,d1,vx1,vy1;
float x2, y2, d2, vx2, vy2;
  
void setup() {
  size(700, 700);
  
  x3=100;
  y3=150;
  d3=100;
  vx3=2;
  vy3=3;
  x2 = 300;
  y2 = 200;
  d2 = 15;
  vx2 = 2;
  vy2 = 2;
  x1 = 100; y1 = 50; d1 = 10; vx1 = 2; vy1 = 2;
  }
 


void draw(){
    background(255);
    x3 += vx3;
    y3 += vy3;
    penguin(x3, y3, d3);
    if (x3>width || x3==0){
      vx3 = -vx3 ;
    } 
    if (y3>height || y3==0) {
      vy3 = -vy3 ;
    }
    x2 += vx2; 
  y2 +=vy2; 
  kjm(x2,y2,d2); 

if(x2<0 || x2>width) vx2 = -vx2;   
if(y2<0 || y2>height) vy2 = -vy2; 

x1 += vx1;   y1 +=vy1;
  face(x1,y1,d1);
  if(x1<0 || x1>width) vx1 = -vx1;
  if(y1<0 || y1>height) vy1 = -vy1;
}

void penguin(float x, float y, float d){
  background(220); // 흰색 배경
   // 펭귄 몸통
  stroke(0);
  strokeWeight(d*0.06);
  fill(255); // white
  ellipse(x, y, d, d * 1.5); // 몸통
  strokeWeight(1);
   
  // 펭귄 머리
  fill(0); // 검은색
  ellipse(x, y - d * 0.5, d * 0.75, d * 0.75); // 머리
  
  // 눈
  stroke(255);
  strokeWeight(d*0.0275);
  fill(0); // blk
  ellipse(x - d * 0.15, y - d * 0.6, d * 0.1, d * 0.1); // 왼쪽 눈
  ellipse(x + d * 0.15, y - d * 0.6, d * 0.1, d * 0.1); // 오른쪽 눈
  strokeWeight(1);
  
  // 부리
  fill(255, 165, 0); // 주황색
  stroke(0);
  beginShape();
  vertex(x - d * 0.1, y - d * 0.4);
  vertex(x, y - d * 0.35);
  vertex(x + d * 0.1, y - d * 0.4); 
  vertex(x, y - d * 0.45); 
  vertex(x - d * 0.1, y - d * 0.4);
  vertex(x + d * 0.1, y - d * 0.4); 
  endShape(CLOSE);
  
  // 왼쪽 팔 (사선)
  fill(0); // 검은색
  beginShape();
  vertex(x - d * 0.4, y - d * 0.2); // 팔 시작점
  vertex(x - d * 0.8, y + d * 0.3); // 팔 끝점
  vertex(x - d * 0.55, y - d * 0.2); // 팔 끝점
  endShape(CLOSE);
  
  // 오른쪽 팔 (사선)
  fill(0); // 검은색
  beginShape();
  vertex(x + d * 0.4, y - d * 0.2); // 팔 시작점
  vertex(x + d * 0.8, y + d * 0.3); // 팔 끝점
  vertex(x + d * 0.55, y - d * 0.2); // 팔 끝점
  endShape(CLOSE);
  
  // 발
  fill(0); // 검은색
  ellipse(x - d * 0.2, y + d * 0.8, d * 0.4, d * 0.2); // 왼쪽 발
  ellipse(x + d * 0.2, y + d * 0.8, d * 0.4, d * 0.2); // 오른쪽 발
  
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
void face(float x, float y, float d){
  fill(255);
  circle(x*2,y*4,d*20);//face
  circle(x*2-d*4,y*3+d,d*4);//left eye
  circle(x*2+d*4,y*3+d,d*4);//right eye
  arc(x*2-d*4,y*3-d,d*4,d*2,PI,2*PI);//right eyebrow
  arc(x*2+d*4,y*3-d,d*4,d*2,PI,2*PI);//left eyebrow
  arc(x*2,y*4+d,d*3,d,0.5*PI,1.5*PI);//nose
  fill(255,0,0);
  arc(x*2,y*4+d*4,d*6,d*2,0,PI);//mouth
}