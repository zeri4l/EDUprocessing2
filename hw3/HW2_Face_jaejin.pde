float x1,y1,d1,vx1,vy1;
void setup(){
  size(600,400);
  x1 = 100; y1 = 50; d1 = 10; vx1 = 2; vy1 = 2;
}
void draw(){
  background(0,255,255);
  x1 += vx1;   y1 +=vy1;
  face(x1,y1,d1);
  if(x1<0 || x1>width) vx1 = -vx1;
  if(y1<0 || y1>height) vy1 = -vy1;
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





float x1, y1, d1, vx1, vy1;

void setup() {
  size(600, 400);
  x1 = 100; 
  y1 = 100; // y 위치를 조정하여 얼굴이 화면 중앙에 위치하게 함
  d1 = 10; 
  vx1 = 2; 
  vy1 = 2;
}

void draw() {
  background(0, 255, 255);
  
  // 위치 업데이트
  x1 += vx1;   
  y1 += vy1;

  // 벽에 튕기는 부분
  if (x1 < d1 * 2 || x1 > width / 2 - d1 * 2) vx1 = -vx1;
  if (y1 < d1 * 2 || y1 > height / 2 - d1 * 2) vy1 = -vy1;

  face(x1, y1, d1);
}

void face(float x, float y, float d) {
  fill(255);
  circle(x * 2, y * 4, d * 20); // 얼굴
  circle(x * 2 - d * 4, y * 4 - d * 4, d * 4); // 왼쪽 눈
  circle(x * 2 + d * 4, y * 4 - d * 4, d * 4); // 오른쪽 눈
  arc(x * 2 - d * 4, y * 4 - d * 8, d * 4, d * 2, PI, 2 * PI); // 오른쪽 눈썹
  arc(x * 2 + d * 4, y * 4 - d * 8, d * 4, d * 2, PI, 2 * PI); // 왼쪽 눈썹
  arc(x * 2, y * 4 + d * 4, d * 3, d, 0.5 * PI, 1.5 * PI); // 코
  fill(255, 0, 0);
  arc(x * 2, y * 4 + d * 8, d * 6, d * 2, 0, PI); // 입
}
