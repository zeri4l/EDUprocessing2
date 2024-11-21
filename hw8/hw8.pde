/* 
class penguin을 class redpenguin, bluepenguin이 상속
class penguin 내에서 class fish 실행
흰 펭귄, 붉은 펭귄, 푸른 펭귄이 입에 생선을 물고 있는 것을 구현
*/



penguin[] pg;

void setup() {
  size(700, 700);
  // 초기 변수
  pg = new penguin[3];
  pg[0] = new redpenguin(2, 3);
  pg[1] = new bluepenguin(3, 2);
  pg[2] = new penguin(4, 5); // 일반 펭귄
}

void draw() {
  background(255);
  for (int i = 0; i < 3; i++) {
    for (int j = i + 1; j < 3; j++) {
        pg[i].collide(pg[j]);
    }
    pg[i].move();
    pg[i].show();
    pg[i].showFish(); // 생선 그리기
  }
}

class penguin {
  float x, y, d, vx, vy;
  fish myFish; // 생선 객체

  penguin(float ax, float ay) {
    x = random(700);
    y = random(700);
    d = 50;
    vx = ax;
    vy = ay;
    myFish = new fish(x, y - d * 0.75); // 펭귄 머리 위에 생선 위치 설정
  }
  
  void collide(penguin b) {
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
    // 기본 펭귄 몸통
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
    
    // 팔
    fill(0); // 검은색
    beginShape();
    vertex(x - d * 0.4, y - d * 0.2);
    vertex(x - d * 0.8, y + d * 0.3);
    vertex(x - d * 0.55, y - d * 0.2);
    endShape(CLOSE);
    
    beginShape();
    vertex(x + d * 0.4, y - d * 0.2);
    vertex(x + d * 0.8, y + d * 0.3);
    vertex(x + d * 0.55, y - d * 0.2);
    endShape(CLOSE);
    
    // 발
    fill(0); // 검은색
    ellipse(x - d * 0.2, y + d * 0.8, d * 0.4, d * 0.2);
    ellipse(x + d * 0.2, y + d * 0.8, d * 0.4, d * 0.2);
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
    
    // 생선 위치 업데이트
    myFish.updatePosition(x, y - d * 0.2); // 펭귄 머리 위로 위치 조정
  }

  void showFish() {
    myFish.show(); // 생선 그리기
  }

  class fish {
    float x, y, size;

    fish(float x, float y) {
      this.x = x;
      this.y = y;
      this.size = 30; // 생선 크기
    }

    void show() {
      fill(255, 200, 0); // 생선 색상
      ellipse(x, y, size, size * 0.5); // 생선 몸통
      fill(0, 150, 255); // 생선 꼬리 색상
      triangle(x - size / 2, y, 
               x - size, y - size * 0.2, 
               x - size, y + size * 0.2); // 생선 꼬리
    }
    
    void updatePosition(float newX, float newY) {
      this.x = newX;
      this.y = newY; // 생선 위치 업데이트
    }
  }
}

class redpenguin extends penguin {
  redpenguin(float ax, float ay) {
    super(ax, ay);
  }
  
  void show() {
    // 붉은색 배를 가진 펭귄
    super.show(); // 기본 펭귄 모양 그리기
    fill(255, 0, 0); // 붉은색
    ellipse(x, y + 9, d * 0.7, d * 0.8); // 붉은색 배
  }
}

class bluepenguin extends penguin {
  bluepenguin(float ax, float ay) {
    super(ax, ay);
  }
  
  void show() {
    // 푸른색 배를 가진 펭귄
    super.show(); // 기본 펭귄 모양 그리기
    fill(0, 0, 255); // 푸른색
    ellipse(x, y + 9, d * 0.7, d * 0.8); // 푸른색 배
  }
}
