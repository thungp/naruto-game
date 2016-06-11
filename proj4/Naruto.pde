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
}