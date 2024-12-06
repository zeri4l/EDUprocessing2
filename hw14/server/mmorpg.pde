class MMOServer {
  boolean isRed; // true for red, false for blue
  Server ss;
  int count = 0;

  MMOServer(boolean isRed) {
    this.isRed = isRed;
  }

  void update() {
    Client client = ss.available();
    if (client != null) {
      count++;
      println("Client connected: " + client.ip());
      
      // 클라이언트로부터 입력 처리
      handleClientInput(client);
    }
  }
}
