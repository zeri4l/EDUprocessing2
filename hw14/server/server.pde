import processing.net.*;

MMOServer s1, s2; 
int N = 2; 
int score1 = 0;
int score2 = 0;

void setup() { 
  size(1000, 800);
  s1 = new MMOServer(true); // 첫 번째 서버
  s2 = new MMOServer(false); // 두 번째 서버
  s1.ss = new Server(this, 12345);  
  s2.ss = new Server(this, 12346);  
  textSize(50);
} 

void draw() {   
  background(0, 255, 255);
  s1.update();
  s2.update();
  
  // 점수 표시
  fill(0);
  text("점수 1: " + score1, 50, 50);
  text("점수 2: " + score2, 50, 100);
  
  // 끝난 상태 체크
  if (s1.count == N) {
    fill(255, 0, 0);
    text("Red finished!!", width / 4, height / 2);
  }
  if (s2.count == N) {
    fill(0, 0, 255);
    text("Blue finished!!", width / 4, height / 2 + 100);
  }
}

void updateScores(int clientId) {
  if (clientId == 1) {
    score1++;
  } else if (clientId == 2) {
    score2++;
  }
}

// 클라이언트의 클릭 정보를 처리하는 메서드
void handleClientInput(Client client) {
  String message = client.readStringUntil('\n');
  if (message != null) {
    String[] parts = message.split(",");
    if (parts.length > 1 && parts[0].equals("HIT")) {
      try {
        int clientId = Integer.parseInt(parts[1]); // clientId를 파싱
        updateScores(clientId); // 점수 업데이트
      } catch (NumberFormatException e) {
        println("Invalid client ID: " + parts[1]); // 오류 메시지 출력
      }
    }
  }
}
