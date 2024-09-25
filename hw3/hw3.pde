float x3, y3, d3, vx3, vy3;
void setup() {
  size(700, 700);
  
  x3=100;
  y3=150;
  d3=100;
  vx3=2;
  vy3=3;
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
}

void penguin(float x, float y, float d){
  background(255); // 흰색 배경
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