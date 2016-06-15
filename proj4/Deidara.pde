class Deidara{
  PVector position;
  PVector velocity;
  PImage spriteLR;
  PImage spriteLL;
  
  int sX = 0;
  int sY = 0;
  int varWidth = 0;
  int spriteWidth = 50;
  int deidaraWidth = 50;
  int deidaraHeight = 67;
  int startingHeight = background.height - (deidaraHeight * 3);
  
  int segmentStanceXLL = 460;
  int segmentStanceYLL = 800;
  int segmentStanceXLR = 0;
  int segmentStanceYLR = 800;
  int segmentStanceWidth =192;
  int segmentStanceNumFrames = 4;
  
  boolean shoot = false;
  
  /*
  Deidara(){
    this.position = new PVector(230, startingHeight );
    this.velocity = new PVector(0, 0);
    this.sprite = loadImage("Deidara_Sprites_Look_Left");
    this.drawDeidaraStance();    
  } */ // refactor later if useful
  
  Deidara(PImage spriteLR, PImage spriteLL){
    this.position = new PVector(930, startingHeight );
    this.velocity = new PVector(0, 0);
    this.spriteLR = spriteLR;
    this.spriteLL = spriteLL;
    this.drawDeidaraStance();    
  }
  /*
  Deidara(float x, float y, float vX, float vY, PImage sprite){
    this.position = new PVector(x, y);
    this.velocity = new PVector(vX, vY);
    this.sprite = sprite;
    this.drawDeidaraStance();
    
  } */  // refactor later if useful
  
  /*
  Deidara(PImage sprite){
    this();
    this.sprite = sprite;
  }
  
  void update(int counter){
    if (this.shoot){ 
      drawDeidaraRasengan(counter);
    }
    else{
      this.position.add(this.velocity);
      if(this.position.y < startingHeight){
        this.position.add(new PVector(0, 3));
      }
      drawDeidaraStance();
    }
  } */ // refactor later if useful
  
  void drawDeidaraStance(){
    // eventually need to have if figure out dynamically if it wants to look lef or right.
    // for now hard code to one look
    println("Inside Deidara drawDeidaraStance");
    sX = 0;
    sY = 0;
    varWidth = -12;
    deidaraWidth = (int) segmentStanceWidth/segmentStanceNumFrames;
    PImage spriteSegment = spriteLL.get(segmentStanceXLL, segmentStanceYLL, segmentStanceWidth, deidaraHeight);
    // for now assme static, but eventually stand still stance could show
    // some animation like heavy breathing.
    // get first frame for now
    image(spriteSegment, 0, 0);
    noFill();
    rect(0,0, segmentStanceWidth, deidaraHeight);
    rect(0,0, (int) segmentStanceWidth/segmentStanceNumFrames, deidaraHeight);
    
    PImage firstFrame = spriteSegment.get(0, 0, (int) segmentStanceWidth / segmentStanceNumFrames, deidaraHeight);
    copy(firstFrame, sX, sY, deidaraWidth , deidaraHeight, (int)this.position.x, (int)this.position.y, spriteWidth, deidaraHeight);
  }
  /*
  void drawDeidaraRasengan(int counter){
    shoot = true;
    int multiplier = 12;
    if(counter % multiplier * 1 == 0){ 
      varWidth = -12;
      deidaraWidth = counter * spriteWidth + varWidth;
      this.position.x -= 10;
    }    
    if(counter % multiplier * 2 == 0){ 
      varWidth = -10;
      deidaraWidth = counter * spriteWidth + varWidth;
      this.position.x += 10;
    } 
    if(counter % multiplier * 3 == 0){
      varWidth = 0;
      deidaraWidth = counter * spriteWidth + varWidth;
    }
    if(counter % multiplier * 4 == 0){ 
      varWidth = -10;
      deidaraWidth = counter * spriteWidth + varWidth;
    } 
    if(counter % multiplier * 5 == 0){ 
      varWidth = -10;
      deidaraWidth = counter * spriteWidth + varWidth;
      shoot = false;
    } 
    sX = deidaraWidth - spriteWidth;
    copy(sprite, sX, sY, deidaraWidth , deidaraHeight, (int)this.position.x, (int)this.position.y, spriteWidth, deidaraHeight);
    sX = 0;
    
  } */  // refactor only when needed
  
  void moveHorizontal(PVector move){
   this.position.add(move);
  }
  
  void moveVertical(PVector jump){
   this.position.add(jump);
  }
}