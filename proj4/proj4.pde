
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

branch issue#10
1. (PT) Added reference to our our github repo that PT Created.
// Reference
// 1. https://www.youtube.com/watch?v=y6Lwzhc2-q0
// 2. https://processing.org/discourse/beta/num_1270824860.html

Git Hub Location:
https://github.com/thungp/naruto-game

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
}