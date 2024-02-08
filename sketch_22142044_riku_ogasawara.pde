float baseH = 100;
float armL1 = 60;
float armL2 = 60;
float armW1 = 10;
float armW2 = 10;
float angle0 = 0;
float angle1 = 0;
float angle2 = 0;
float dif = 1;
float ballA = 0;
float ballB = 40;
float ballC = 0;
float ballX, ballY, ballZ;      // ボールの座標
float ballSpeedX = 5;           // ボールの速度X
float ballR = 15;          // ボールの半径
int Move = 1;          //赤ボールを動かし続ける
int Moveb = 0;         //青ボールを動かし続ける
void setup() {
  size(1200, 800, P3D);
  noStroke();
  
  // ボールの初期位置
  ballX = 300; 
  ballY = 200;
  ballZ = 100;
}

void draw() {
  background(255);

  // アームの関数（下で定義）
  drawArm();

  // ボールの関数（下で定義）
  drawBall();

  // ボールの移動と反射
  if (Move == 1) {
    moveBall();
  }
  
  if (Moveb == 1) {
    movebule();
  }
}

//アームの関数
void drawArm() {
  if (keyPressed) {
    if (key == 'b') {                 //baseが反時計回りに回転（アーム）
        angle0 -= dif;
    }
    if (key == 's') {                 //1stlinkが時計回りに回転（アーム）
      angle1 += dif;
    }
    if (key == 'p') {                 //2ndlinkが発射準備（pi/2)起き上がる（アーム）
    angle2 = PI/2;
    }
    if (key == 't') {                 //アームとボールをリセット
      reset();
    }
     if (key == 'g') {                //アームについたボールが発射（青ボール）
      movebule();
    }
    if (key == 'p') {
      Move = 0;  // 'p'キーで動きを停止（赤ボール）
    } else if (key == 't') {
      Move = 1;  // 't'キーで動きを再開（赤ボール）
    }
    if (key == 't') {
      Moveb = 0;  // 't'キーで動きを停止（青ボール）
    } else if (key == 'g') {
      Moveb = 1;  // 'g'キーで動きを再開（青ボール）
    }
  }

  // アームの描画
  //base
  pushMatrix();
  translate(600, 600, baseH / 10); 
  rotateX(PI/2);  // X軸を中心に90度回転(ボールとアームをウィンドウに映すため）
  rotateZ(radians(angle0));
  fill(0);
  box(10, 10, baseH);

//1st link
  rotateZ(radians(angle1));
  translate(0, armL1 / 2 - armW1 / 2, baseH / 2 + armW1 / 2);
  fill(0);
  box(armW1, armL1, armW1);

//2nd link
  translate(0, armL1 - 3 * armW2, -armW2 / 2 + 15);
  rotateX(angle2);
  translate(0, armW2, 0);
  fill(0);
  box(armW2, armL2, armW2);

  // アームの先端のボール
  translate(ballA, ballB, ballC);  // ボールの座標を変更
  fill(0, 0, 255);  // 青
  sphere(ballR);

  popMatrix();
}

void drawBall() {
  fill(255, 0, 0);
  pushMatrix();
  translate(ballX, ballY, ballZ);
  sphere(ballR);
  popMatrix();
}

void moveBall() {
  ballX += ballSpeedX;

  // 画面端で反射
  if (ballX < ballR|| ballX > 1200 - ballR) {
    ballSpeedX *= -1;
  }
}

void movebule() {
  ballA += 0 ;
  ballB += ballX*(armL1 - 2 * armW2)/1000;
  ballC += ballX*(baseH / 2 - armW2 / 2)/1000;
}


void reset() {
  angle0 = 0;
  angle1 = 0;
  angle2 = 0;
  ballA = 0;
  ballB = 40;
  ballC = 0;
}
