// vx, vy의 교환을 통해서 2차원 충돌 구현하기
penguin [] pg;

void setup() {
  size(700, 700);
  // 초기 변수
  pg = new penguin[3];
  for(int i=0; i<3; i++){
    pg[i] = new penguin(i+2, i+3);
  }
  
}

void draw() {
  background(255);
  for (int i = 0; i < 3; i++) {
    for (int j = i + 1; j < 3; j++) {
        pg[i].collide(pg[j]);
    }
    pg[i].move();
    pg[i].show();
}

 
}

class penguin {
  // 생성자
  penguin(float ax, float ay) {
    x = random(700);
    y = random(700);
    d = 50;
    vx = ax;
    vy = ay;
    
  }
  
  
  // 멤버 데이터
  float x, y, d, vx,vy;


  // 멤버 함수
  void collide(penguin b){
    float dd, nn;
    dd = sqrt((x-b.x)*(x-b.x) + (y-b.y)*(y-b.y));
    if(dd < (d+b.d)/1.5){
      nn=vx;
      vx=b.vx;
      b.vx=nn;
      nn=vy;
      vy=b.vy;
      b.vy=nn;
    }
  } 
  void show() {
    // 펭귄 몸통
    stroke(0);
    strokeWeight(d * 0.06);
    fill(255); // 흰색
    ellipse(x, y, d, d * 1.5); // 몸통
    strokeWeight(1);
    
    // 펭귄 머리
    fill(0); // 검은색
    ellipse(x, y - d * 0.5, d * 0.75, d * 0.75); // 머리
    
    // 눈
    stroke(255);
    strokeWeight(d * 0.0275);
    fill(0); // 검은색
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
  
  void move() {
    x += vx;
    y += vy;

    // 경계 처리
    if (x > width || x < 0) {
      vx = -vx;
    } 
    if (y > height || y < 0) {
      vy = -vy;
    }
  }
}
