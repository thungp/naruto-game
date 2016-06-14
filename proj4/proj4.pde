<<<<<<< .mine
//Author: Peter Thung and Daniel Vance
//Project 4

/************


Change Log
1. (PT) Added Miscellenous functions from Chapter 5 that may come in
handy.   blurImg(PImage p, int level), sharpenImg(PImage p, int level)
2. (PT) Imported Sprite sheets
        naruto_sheet_3.gif (Naruto from Naruto - Ninyutsu Zenkai Ripped by Naruto[NU]
3. (PT) Not sure exactly how to make spritesheet  background transparent.
       After sampling sprite sheet color, created a transparentizeBackground
       hack as it looks like it was all green. per ref (2) I see there is this ARGB mode
4. (DV) Changed images to be an array of images
5. (DV) Slowed Naruto down(drawNaruto function), but kept the Rasengan at 60 fps
6. (DV) Collision detection and GRAVITY added

branch issue#3
1. (DV) Implemented the Rasengan class and removed the array based rasengans 
2. (DV) Cleaned up the code.
3. (DV)(Issue#4)(Issue#5) Implemented Rasengan life cycle code, handled by the naruto-game draw funciton 
4. (DV) Fixed the Naruto disappearing and back-peddling bugs.
5. (DV)(Issue#3) Corrected bug where Rasengan was being created at Naruto's original position.
6. (DV) Added a jump keyPress to one of Naruto's movements


// Reference
// 1. https://www.youtube.com/watch?v=y6Lwzhc2-q0
// 2. https://processing.org/discourse/beta/num_1270824860.html


***********/
// global variables
final int FRAME_RATE = 60;

Naruto naruto;
SpriteFrame sprite01;

ArrayList<Rasengan> rasengans = new ArrayList<Rasengan>();
PImage background;
PImage spriteRasengan;
PImage spriteNarutoShoot;

int counter = 0;
// end globals

void setup() {
  frameRate(FRAME_RATE);
  background = loadImage("sand_background.png");
  sprite01   = new SpriteFrame("Naruto_04.png");
  spriteNarutoShoot = sprite01.get(0, 4540, 260, 60);  // Naruto Shooting
  spriteRasengan    = sprite01.get(0, 4150, 500, 70);  // OOdama Rasengan
  
  naruto = new Naruto(spriteNarutoShoot);  
  
  surface.setResizable(true);
  surface.setSize(background.width, background.height);
}

void draw() {
  image(background, 0, 0);
  background.resize(width, height);
  
  // The space key is ascii while the arrows are not, so
  // two different keywords are used by the language, key
  // and keyCode.
  if(keyPressed == true){
    switch(key){
      case(' '):
        naruto.drawNarutoRasengan(counter);
        // Limit Naruto to one Rasengan at a time
        if(rasengans.isEmpty()){
          PVector positionCopy = naruto.position.copy();
          rasengans.add(new Rasengan(spriteRasengan));
          rasengans.get(0).shootRasengan(positionCopy, counter);
        }
        break;
      default:
        naruto.drawNarutoStance();
    } // End Switch
    switch(keyCode){
      case(RIGHT):
        PVector moveRight = new PVector(5, 0);
        naruto.moveHorizontal(moveRight);
        break;
      
      case(LEFT):
        PVector moveLeft = new PVector(-5, 0);
        naruto.moveHorizontal(moveLeft);
        break;
        
      case(UP):
        PVector jump = new PVector(0, -20);
        naruto.moveVertical(jump);
        break;
      
    } // End Switch
  } // End If
  else{
    // Reset Naruto's x speed to zero
    naruto.velocity.x = 0;
  }
  
  naruto.update(counter);
  
  counter++;
  
  if(!rasengans.isEmpty()){ 
    if(rasengans.get(0).timer % 60 == 0){
      rasengans.clear();
    }
    else if(rasengans.get(0).position.x > width){ 
      rasengans.clear(); 
    } 
    else if(rasengans.get(0).position.x < 0 - rasengans.get(0).rWidth){ 
      rasengans.clear(); 
    }
    else{ 
      rasengans.get(0).update(counter); 
    }
  }
}

void drawGrid(int cols, int rows, int strokeColor){
 int colSpan = width/cols;
 int rowSpan = height/rows;
 stroke(strokeColor);
 noFill();
 int [][] vals2D = new int[cols][rows];
 for (int i = 0; i < vals2D.length; i++) {
   for (int j = 0; j < vals2D[i].length; j++) {
     rect(colSpan*i, rowSpan * j, colSpan, rowSpan); 
   }
 }
}||||||| .r0
=======
//Author: Peter Thung and Daniel Vance
//Project 4

/************


Change Log
1. (PT) Added Miscellenous functions from Chapter 5 that may come in
handy.   blurImg(PImage p, int level), sharpenImg(PImage p, int level)
2. (PT) Imported Sprite sheets
        naruto_sheet_3.gif (Naruto from Naruto - Ninyutsu Zenkai Ripped by Naruto[NU]
3. (PT) Not sure exactly how to make spritesheet  background transparent.
       After sampling sprite sheet color, created a transparentizeBackground
       hack as it looks like it was all green. per ref (2) I see there is this ARGB mode
4. (DV) Changed images to be an array of images
5. (DV) Slowed Naruto down(drawNaruto function), but kept the Rasengan at 60 fps
6. (DV) Collision detection and GRAVITY added


// Reference
// 1. https://www.youtube.com/watch?v=y6Lwzhc2-q0
// 2. https://processing.org/discourse/beta/num_1270824860.html


***********/
// global variables
final int MAX_RASENGAN = 120;
final int FRAME_RATE = 60;

Naruto naruto;
SpriteFrame sprite01;

PImage[] rasengans = new PImage[MAX_RASENGAN];
int rasengan_current = 0;

int xRasengan = 0;
int yRasengan = 0;
int xNaruto = 0, yNaruto = 0;


PImage background;

PImage spriteRasengan;
PImage spriteNarutoClone;

int rWidth = 0;
int rHeight = 0;

int counter = 0;
int[] dx = new int[MAX_RASENGAN];
int[] dy = new int[MAX_RASENGAN];

int varWidth = 0, dNarutoX = 240, dNarutoY;
int segmentWidth = 260, segmentHeight = 60;
//int spriteWidth = 50;

//Physics
final float GRAVITY = 0.8;
float[] speedX = new float[MAX_RASENGAN];
float[] speedY = new float[MAX_RASENGAN];

// end globals

void setup() {
  //size(800, 600);
  frameRate(FRAME_RATE);
  background = loadImage("sand_background.png");
  sprite01 = new SpriteFrame("Naruto_04.png");
  spriteNarutoClone = sprite01.get(0, 4540, 260, 60);// Naruto Clone

  naruto = new Naruto(spriteNarutoClone);
  
  surface.setResizable(true);
  surface.setSize(background.width, background.height);
  
  for(int i = 0; i < MAX_RASENGAN; i++){
    rasengans[i] = sprite01.get(0, 4150, 500, 70);// OOdama Rasengan
    dx[i] = (int)naruto.position.x + 15;
    dy[i] = (int)naruto.position.y;
    
    speedX[i] = random(10, 30);
    speedY[i] = random(-30, 2);
  }
  rWidth  = (int)rasengans[0].width / 7;
  rHeight = (int)rasengans[0].height;
}

void draw() {
  image(background, 0, 0);
  background.resize(width, height);
  
  //drawNaruto(counter);
  
  xRasengan = (counter % 7) * rWidth;
  yRasengan = 0;
    
  for(int i = 0; i < rasengan_current; i++){
    copy(rasengans[i], xRasengan, yRasengan, rWidth, rHeight, dx[i], dy[i], rWidth, rHeight);
  
    dx[i] += speedX[i];
    speedY[i] += GRAVITY;
    dy[i] += speedY[i];
    
    if(dy[i] > height - rHeight) {
    speedY[i] = -speedY[i]; 
    }
    /**** Collision detection of the sides of the screen ****/
    //if(dx[i] > width - rWidth) {
    // speedX[i] = -speedX[i]; 
    //}
    //if(dx[i] < 0) {
    //  speedX[i] = -speedX[i];
    //}
  }
  if(keyPressed == true){
    switch(key){
      case(' '):
        naruto.drawNarutoRasengan(counter);
        break;
      default:
        naruto.drawNarutoStance();
    } // End Switch
    switch(keyCode){
      case(RIGHT):
        PVector moveRight = new PVector(5, 0);
        naruto.moveHorizontal(moveRight);
        break;
      
      case(LEFT):
        PVector moveLeft = new PVector(-5, 0);
        naruto.moveHorizontal(moveLeft);
        break;
      
    } // End Switch
  } // End If
  else{
    naruto.velocity = new PVector(0, 0);
    naruto.drawNarutoStance(); 
  }
  counter++;
}


//void drawNaruto(int counter){
//  // Reduce Naruto's speed down to 5 frames / sec
//  int fasterRate = 60;
//  if(counter % fasterRate ==  0){ 
//    varWidth = -12;
//    xNaruto = (counter % 5) * spriteWidth + varWidth;
//    dNarutoX = 230;
//  }
//  else{ dNarutoX = 240;}
//  if(counter % fasterRate == int(fasterRate / 5)){ 
//    varWidth = -10;
//    xNaruto = (counter % 5) * spriteWidth + varWidth;
//  } 
//  if(counter % fasterRate == int(fasterRate / 5) * 2){ 
//    varWidth = 0;
//    xNaruto = (counter % 5) * spriteWidth + varWidth;
//  }
//  if(counter % fasterRate == int(fasterRate / 5) * 3){ 
//    varWidth = -10;
//    xNaruto = (counter % 5) * spriteWidth + varWidth;
//  } 
//  if(counter % fasterRate == int(fasterRate / 5) * 4){ 
//    varWidth = -10;
//    xNaruto = (counter % 5) * spriteWidth + varWidth;
//    rasengan_current++;
//  } 
  
//  copy(spriteNarutoClone, xNaruto, yNaruto, spriteWidth , segmentHeight, dNarutoX, dNarutoY, spriteWidth, segmentHeight);
//}

void drawGrid(int cols, int rows, int strokeColor){
 int colSpan = width/cols;
 int rowSpan = height/rows;
 stroke(strokeColor);
 noFill();
 int [][] vals2D = new int[cols][rows];
 for (int i = 0; i < vals2D.length; i++) {
   for (int j = 0; j < vals2D[i].length; j++) {
     rect(colSpan*i, rowSpan * j, colSpan, rowSpan); 
   }
 }
}>>>>>>> .r13
