import processing.net.*;

Client client;
int score = 0;
int moleX, moleY;
boolean moleVisible = false;
int clientId = 1; // 클라이언트 1
int respawnTimer = 0; // 타이머 초기화

void setup() {
  size(400, 400);
  client = new Client(this, "192.168.0.7", 12345); // 서버 IP 주소
  spawnMole(); // 두더지 초기화
}

void draw() {
  background(200);
  
  // 점수 표시
  fill(0);
  textSize(20);
  text("내 점수: " + score, 10, 30);
  
  // 서버로부터 두더지 정보 받기
  if (client.available() > 0) {
    String message = client.readStringUntil('\n');
    if (message != null) {
      String[] data = message.split(",");
      moleX = Integer.parseInt(data[0]); // 두더지 X 좌표
      moleY = Integer.parseInt(data[1]); // 두더지 Y 좌표
      moleVisible = data[2].equals("1"); // 두더지 가시성
    }
  }
  
  // 두더지 표시
  if (moleVisible) {
    fill(255, 0, 0); // 두더지 색상
    ellipse(moleX, moleY, 50, 50); // 두더지를 원으로 표시
  }
  
  // 두더지 자동 리스폰
  respawnTimer++;
  if (respawnTimer > 60) { // 1초마다 리스폰 (60프레임 기준)
    spawnMole();
    respawnTimer = 0; // 타이머 초기화
  }
}

void mousePressed() {
  // 두더지를 클릭했을 때 점수를 올림
  if (moleVisible && dist(mouseX, mouseY, moleX, moleY) < 25) {
    client.write("HIT," + clientId + "\n"); // 서버에 클릭 정보 전송
    spawnMole(); // 두더지 다시 생성
  }
}

void spawnMole() {
  moleX = int(random(50, width - 50));
  moleY = int(random(100, height - 50));
  moleVisible = true;
}
