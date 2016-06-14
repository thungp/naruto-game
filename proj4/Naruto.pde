<<<<<<< .mine
class Naruto{
  PVector position;
  PVector velocity;
  PImage sprite;
  int sX = 0;
  int sY = 0;
  int varWidth = 0;
  int spriteWidth = 50;
  int narutoWidth = 50;
  int narutoHeight = 60;
  int startingHeight = background.height - (narutoHeight * 3);
  boolean shoot = false;
  
  Naruto(){
    this.position = new PVector(230, startingHeight );
    this.velocity = new PVector(0, 0);
    this.sprite = loadImage("Naruto_04.png");
    this.drawNarutoStance();    
  }
  
  Naruto(float x, float y, float vX, float vY, PImage sprite){
    this.position = new PVector(x, y);
    this.velocity = new PVector(vX, vY);
    this.sprite = sprite;
    this.drawNarutoStance();
    
  }
  
  Naruto(PImage sprite){
    this();
    this.sprite = sprite;
  }
  
  void update(int counter){
    if (this.shoot){ 
      drawNarutoRasengan(counter);
    }
    else{
      this.position.add(this.velocity);
      if(this.position.y < startingHeight){
        this.position.add(new PVector(0, 3));
      }
      drawNarutoStance();
    }
  }
  
  void drawNarutoStance(){
    sX = 0;
    sY = 0;
    varWidth = -12;
    narutoWidth = spriteWidth + varWidth;
    copy(sprite, sX, sY, narutoWidth , narutoHeight, (int)this.position.x, (int)this.position.y, spriteWidth, narutoHeight);
  }
  
  void drawNarutoRasengan(int counter){
    shoot = true;
    int multiplier = 12;
    if(counter % multiplier * 1 == 0){ 
      varWidth = -12;
      narutoWidth = counter * spriteWidth + varWidth;
      this.position.x -= 10;
    }    
    if(counter % multiplier * 2 == 0){ 
      varWidth = -10;
      narutoWidth = counter * spriteWidth + varWidth;
      this.position.x += 10;
    } 
    if(counter % multiplier * 3 == 0){
      varWidth = 0;
      narutoWidth = counter * spriteWidth + varWidth;
    }
    if(counter % multiplier * 4 == 0){ 
      varWidth = -10;
      narutoWidth = counter * spriteWidth + varWidth;
    } 
    if(counter % multiplier * 5 == 0){ 
      varWidth = -10;
      narutoWidth = counter * spriteWidth + varWidth;
      shoot = false;
    } 
    sX = narutoWidth - spriteWidth;
    copy(sprite, sX, sY, narutoWidth , narutoHeight, (int)this.position.x, (int)this.position.y, spriteWidth, narutoHeight);
    sX = 0;
    
  }
  
  void moveHorizontal(PVector move){
   this.position.add(move);
  }
  
  void moveVertical(PVector jump){
   this.position.add(jump);
  }
}||||||| .r0
=======
class Naruto{
  PVector position;
  PVector velocity;
  PImage spriteSection;
  int sX = 0;
  int sY = 0;
  int frame = 0;
  int spriteWidth = 50;
  int narutoWidth = 50;
  int narutoHeight = 60;
  
  Naruto(){
    this.position = new PVector(230, (background.height - (segmentHeight * 3 - 7)) );
    this.velocity = new PVector(0, 0);
    this.spriteSection = loadImage("Naruto_04.png");
    this.drawNarutoStance();    
  }
  
  Naruto(float x, float y, float vX, float vY, PImage sprite){
    this.position = new PVector(x, y);
    this.velocity = new PVector(vX, vY);
    this.spriteSection = sprite;
    this.drawNarutoStance();
    
  }
  
  Naruto(PImage sprite){
    this();
    this.spriteSection = sprite;
  }
  
  void update(){
    this.position.add(velocity);
    drawNarutoStance();
  }
  
  void drawNarutoStance(){
    sX = 0;
    sY = 0;
    varWidth = -12;
    narutoWidth = spriteWidth + varWidth;
    copy(spriteSection, sX, sY, narutoWidth , narutoHeight, (int)position.x, (int)position.y, spriteWidth, narutoHeight);
  }
  
  void drawNarutoRasengan(int counter){
    
    int multiplier = 12;
    if(counter % multiplier * 1 == 0){ 
      varWidth = -12;
      narutoWidth = counter * spriteWidth + varWidth;
      position.x += -10;
    }    
    if(counter % multiplier * 2 == 0){ 
      varWidth = -10;
      narutoWidth = counter * spriteWidth + varWidth;
    } 
    if(counter % multiplier * 3 == 0){
      varWidth = 0;
      narutoWidth = counter * spriteWidth + varWidth;
    }
    if(counter % multiplier * 4 == 0){ 
      varWidth = -10;
      narutoWidth = counter * spriteWidth + varWidth;
    } 
    if(counter % multiplier * 5 == 0){ 
      varWidth = -10;
      narutoWidth = counter * spriteWidth + varWidth;
      
      //rasengan_current++;
    } 
    sX = narutoWidth - spriteWidth;
    copy(spriteSection, sX, sY, narutoWidth , narutoHeight, (int)position.x, (int)position.y, spriteWidth, narutoHeight);
    sX = 0;
    
  }
  
  void moveHorizontal(PVector move){
   this.position.add(move);
   update();
  }
}>>>>>>> .r13
