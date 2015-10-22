/* please implement your assign1 code in this file. */
  final int GAME_START = 0;
  final int GAME_RUN = 1;
  final int GAME_LOSE = 2;
  
  float x, y;
  float treasureX, treasureY;
  float percentage, hpWeightX, hpWeightY; 
  float enemyX, enemyY;
  float indexOne, indexTwo;
  float enemyDist, treasureDist;
  int gameState;
  
  // key press moving for jet flying
  float speed = 5;
  float jetX = 580; 
  float jetY = 240;
  float jetH = 51;
  float jetW = 51;
  boolean upPressed = false;
  boolean downPressed = false;
  boolean leftPressed = false;
  boolean rightPressed = false;

  PImage jet, hpBar, treasure, bgOne, bgTwo, enemy, end, endHover, start, startHover; 
  
  
void setup () {
  size(640,480) ;  
  background(255);
  
  //loading images
  bgOne = loadImage("img/bg1.png");
  bgTwo = loadImage("img/bg2.png");
  jet = loadImage("img/fighter.png");
  hpBar = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  enemy = loadImage("img/enemy.png");
  end = loadImage("img/end2.png");
  endHover = loadImage("img/end1.png");
  start = loadImage("img/start2.png");
  startHover = loadImage("img/start1.png");
  
  //set x and y position first time
  x = 0;
  y = 0;
  
  //X, Y setting for background
  indexOne = width;
  indexTwo = 0;
  
  //give enemy a random y position from 40 to 450 pixel;
  enemyX = 0;
  enemyY = floor(random(40, 450));

  //set HP Bar percentage
  percentage = 200/100;
  hpWeightX = percentage * 20;
  hpWeightY = 30;

  //set treasure position in random X asix and Y asix
  treasureX = floor(random(200,550));
  treasureY = floor(random(40,439));
  
  //set initial gameState in start;
  gameState = GAME_START;
}


void draw() {
  background(255);
  
  switch (gameState){
    
    case GAME_START:
      //reset HP bar
      hpWeightX = percentage * 20;
      image(start, x, y);
      
      //reset jet x y position
      jetX = 580; 
      jetY = 240;
      
      //mouse action and hover on start background
      
      if (mouseY > 370 && mouseY < 420){
        //start button hovered
          image(startHover, x, y);
            if (mousePressed){
            //click to start
            gameState = GAME_RUN;        
            }
        }
      
      
      break;
      
    case GAME_RUN:
     
      
      
      //infinite looping background
      image(bgOne, indexOne - width, 0);
      image(bgTwo, indexTwo - width, 0);
      indexOne++;
      indexTwo++;
      indexOne %= width*2;
      indexTwo %= width*2;

      //jet moving
       if (upPressed) {
         jetY -= speed;
       }
       if (downPressed) {
         jetY += speed;
       }
       if (leftPressed) {
         jetX -= speed;
       }
       if (rightPressed) {
         jetX += speed;
       }
       
      //boundary detection
      if( jetX > width - jetW){
       jetX  = width - jetW;
      }
  
      if( jetX < 0 ){
       jetX = 0 ;
      }

      if( jetY > height - jetH){
       jetY = height - jetH;
      }
 
      if( jetY < 0){
       jetY = 0;
      }
      
      //enemy
      //enemy tracking 
      
        if(enemyY > jetY){
          enemyY -= 2;
        }else if(enemyY < jetY){
          enemyY += 2;
        }
            
      //distance between jet and enemy
      enemyDist = dist(jetX, jetY, enemyX, enemyY);
      
      //enemy detection
      if (enemyDist <= 61){  
        //hp bar down 20 point
        hpWeightX -= (percentage*20);
        enemyX = -61;
        enemyY = floor(random(40,450));
     
      }else{
        image(enemy, enemyX, enemyY);
        enemyX += 5;
        enemyX %= 645;  
      }
      
      //enemy restart with random Y-asix each time
      if(enemyX >= width){
        enemyY = floor(random(40, 430));
      }
      
      
      //treasure
      //when jet attach treasure
      treasureDist = dist(jetX, jetY, treasureX, treasureY);
      if (treasureDist <= 41){
        
        //hp bar up 10 point
        hpWeightX += (percentage*10); 
        
        //set HP bar maximus 
        if(hpWeightX >= 200){
          hpWeightX = 200;
        }
        
        //reset treasure random X, Y-axis
        treasureX = floor(random(200,550));
        treasureY = floor(random(40,450));
      }
      
      //show treasure
      image(treasure, treasureX, treasureY);
      
      //show jet
      image(jet, jetX, jetY);
      
      
      //show HP bar
      scale(1,1);
      fill(#FF0000);
      noStroke();
      rect(x+5, y, hpWeightX, hpWeightY);
      image(hpBar, x, y);
     
      //game lose
      if (hpWeightX <= 0){
        gameState = GAME_LOSE;
      }
     
      break;
      
    case GAME_LOSE:
      
      hpWeightX = percentage * 20;
      image(end, x, y);

      //mouse action and hover on start bg
      
      if (mouseY > 300 && mouseY < 350){
        image(endHover, x, y);
        if (mousePressed){
        //click to start
          gameState = GAME_START; 
        }
      }
     break;

  }//switch()
}//draw()

//setting keypress boolean action

void keyPressed(){
  if (key == CODED) { 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
    if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
