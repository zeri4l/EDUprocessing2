
int n = 35;
PacMan[] pacMen;
penguin [] pg;
mine[] mines = new mine[n];
character minsu;

void setup() {
  size(1500, 1500);
  pacMen = new PacMan[5];
  for (int i = 0; i < 5; i++) {
    pacMen[i] = new PacMan();
  }
  pg = new penguin[3];
  for(int i=0; i<3; i++){
    pg[i] = new penguin(i+2, i+3);
  }
  for (int i = 0; i < n; i++) {
    mines[i] = new mine();
  }
  minsu = new character(xx, yy, s);
}

void draw() {
  background(0, 255, 255);
  for (int i = 0; i < 5; i++) {
    if (i != 4) {
      for (int j = i + 1; j < 5; j++) {
        pacMen[i].collide(pacMen[j]);
      }
    }
    pacMen[i].act();
    pacMen[i].Life();
  }
  for (int i = 0; i < 3; i++) {
    for (int j = i + 1; j < 3; j++) {
        pg[i].collide(pg[j]);
    }
    pg[i].move();
    pg[i].show();
}
if (game) {
    
  } else {
    background(255, 0, 0);
    textSize(30);
    fill(0);
    text("Game Over", width / 3, height / 2);
    return;
  }
  for (int i = 0; i < n; i++) {
    mines[i].move();
    mines[i].display();
  }

  // 민수 표시
  minsu.display();

  // 지뢰와 민수 충돌 확인
  for (int i = 0; i < n; i++) {
    if (mines[i].checkCollision(minsu.x, minsu.y, 50 * minsu.size)) {
      game = false;
    }
  }

  // 지뢰 간 충돌 확인
  for (int i = 0; i < n; i++) {
    for (int j = i + 1; j < n; j++) {
      if (mines[i].checkMineCollision(mines[j])) {
        // 서로 충돌했을 때 각 지뢰의 속도를 반대로 변경
        mines[i].reverseDirection();
        mines[j].reverseDirection();
      }
    }
  }
}






class PacMan {
  PacMan() {
    x = random(0, width);
    y = random(0, height);
    d = random(100, 200);
    vx = random(-3, 3);
    vy = random(-2, 2);
  }

  PacMan(float p, float q, float r) {
    x = p;
    y = q;
    d = r;
    vx = random(-3, 3);
    vy = random(-2, 2);
  }

  float x, y, d, vx, vy;

  void collide(PacMan b) {
    float dd = sqrt((x - b.x) * (x - b.x) + (y - b.y) * (y - b.y));
    if (dd < (d + b.d) / 4) {
      vx = vy = 0;
      b.vx = b.vy = 0;
    }
  }

  void act() {
    x += vx;
    y += vy;
    if (x > width) x = 0;
    if (x < 0) x = width;
    if (y > height) y = 0;
    if (y < 0) y = height;
  }

  void Life() {
    // Pac-Man의 몸체를 그리는 arc() 함수
    fill(255, 255, 0); // 노란색으로 설정
    arc(x, y, d, d, radians(45), radians(315)); // 입 벌린 Pac-Man 형태
    // Pac-Man의 눈을 그리는 ellipse() 함수
    fill(0); // 검은색으로 설정
    ellipse(x + d / 5, y - d / 5, d / 10, d / 10); // 눈의 위치 조정
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

float xx = 200, yy = 250, s = 1.0;
boolean game = true;


class mine {
  float x, y;
  float vx, vy;

  mine() {
    x = random(width);
    y = random(height);
    vx = random(3);
    vy = random(3);
  }

  void move() {
    x += vx;
    y += vy;

    if (x > width || x < 0) vx *= -1;
    if (y > height || y < 0) vy *= -1;
  }

  void display() {
    fill(255);
    stroke(0);
    circle(x, y, 50);
  }

  boolean checkCollision(float xx, float yy, float radius) {
    return dist(x, y, xx, yy) < radius + 25;
  }

  //지뢰 간의 충돌 여부 확인
  boolean checkMineCollision(mine other) {
    return dist(this.x, this.y, other.x, other.y) < 50; // 지뢰 크기 50 기준
  }

  // 충돌 시 속도 반대로 전환
  void reverseDirection() {
    vx *= -1;
    vy *= -1;
  }
}

class character {
  float x, y, size;

  character(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }

  void display() {
    float m = size;
    stroke(0);
    fill(250, 224, 212);
    ellipse(x, y, 100 * m, 200 * m); // 얼굴
    fill(255);
    circle(x - 50 * m, y - 10 * m, 40 * m); // 왼쪽 눈
    circle(x + 50 * m, y - 10 * m, 40 * m); // 오른쪽 눈
    fill(250, 224, 212);
    rect(x - 10 * m, y - 30 * m, 20 * m, 80 * m); // 코
    fill(0);
    circle(x - 55 * m, y - 10 * m, 25 * m); // 왼쪽 눈동자
    circle(x + 55 * m, y - 10 * m, 25 * m); // 오른쪽 눈동자
    fill(255, 0, 0);
    arc(x - 10 * m, y + 80 * m, 40 * m, 20 * m, 0, PI); // 입
    noStroke();
    fill(153, 103, 0);
    ellipse(x, y - 70 * m, 220 * m, 50 * m); // 모자
    circle(x, y - 100 * m, 100 * m); // 모자
  }

  void move(char direction) {
    if (direction == 'a') x -= 5;
    else if (direction == 'd') x += 5;
    else if (direction == 'w') y -= 5;
    else if (direction == 's') y += 5;
  }
}

void keyPressed() {
  if (game) {
    minsu.move(key);
  }
}
