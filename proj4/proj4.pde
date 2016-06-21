
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

branch issue#7
1. (PT) Implemented enemey Diedara. Started with Naruto class, but modifying design for the class
to be aware of the whole sprite sheet so it can eventually encapsulate and hide
various moves vice just be passed in the segment for one move. 
Also class takes in both a look left and look right sprite sheet so that we
don't have to wast processing time for tranforms and potential inherent delays when
object is looking left or right. (only implemented looking left right now).
Will also need and to pass into each class a reference to the other object
so that each class can detect when they pass each other so they can automatically turn around.
2. (PT) Implemented a circle/rectangle detection algorithm to detect when rasengan hits Dediara
3. (PT) Implemented Heavy Damage 2 when gets hit with Rasengan. Lots of assumptions right now.
4. (PT) Scaled up the characters so they are a little more proportional to the screen size. 
5. (PT) Made it so that Deidara faces Naruto when their x positions cross.
6. (PT) also modified the original Deidara sprite sheet to have background already have an alpha channel with full transparency.
I used gimp using this link as a reference: https://www.youtube.com/watch?v=AC5vdKuwTp0,
however, when I tried it with the Naruto_04.png, it didn't work out so well. You get better quality with 
the way we do it in code. the flipping didn't work out so well in code when I tried it. 

Git Hub Location:
https://github.com/thungp/naruto-game

***********/

import java.lang.Math;

// global variables
final int FRAME_RATE = 60;

Naruto naruto;
Deidara deidara;
SpriteFrame sprite01;
SpriteFrame spriteDeidara;

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
  deidara = new Deidara(loadImage("Deidara_Sprites_Look_Right.png"), loadImage("Deidara_Sprites_Look_Left.png"));
  
  naruto.setOpponent(deidara);
  println("I expect to see this");
  deidara.setOpponent(naruto);
  println("I expect I shoulnd't see this");
  
  
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
  
  // draw characters
  deidara.drawDeidara();
  
  // collision detection
  collisionDetection();
  
  }

  void collisionDetection(){
  // detect if Naruto Rasengan hits enemy
  if(!rasengans.isEmpty()){
    deidara.checkCollision(rasengans.get(0));
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