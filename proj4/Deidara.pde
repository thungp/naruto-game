class Deidara implements GameObjectIF, RectangleIF {
  PVector position;
  PVector velocity;
  PImage spriteLR;
  PImage spriteLL;
  Dimension objDim;
  
  float scaleFactor = 2.1;
  
  int state = CharacterState.STANCE_STATE;
  
  int damageCountDownCounter = 0;
  
  Rectangle bounds;
  
  
  int sX = 0;
  int sY = 0;
  int varWidth = 0;
  int spriteWidth = 50; // set this in dimensino
  int deidaraWidth = 50;
  int deidaraHeight = 67; // set this in dimension
  int startingHeight = background.height - (deidaraHeight * 3);
  
  int segmentStanceXLL = 460;
  int segmentStanceYLL = 800;
  int segmentStanceXLR = 0;
  int segmentStanceYLR = 800;
  int segmentStanceWidth =192;
  int segmentStanceNumFrames = 4;
  
  int segmentHeavyDamage2XLL = 370;
  int segmentHeavyDamage2YLL = 1340;
  int segmentHeavyDamage2Width = 100;
  int segmentHeavyDamage2Height = 90;
  int segmentHeavyDamage2NumFrames = 2;
  
  boolean shoot = false;
  
  /*
  Deidara(){
    this.position = new PVector(230, startingHeight );
    this.velocity = new PVector(0, 0);
    this.sprite = loadImage("Deidara_Sprites_Look_Left");
    this.drawDeidaraStance();    
  } */ // refactor later if useful
  
  Deidara(PImage spriteLR, PImage spriteLL){
    this.position = new PVector(930, startingHeight);
    this.velocity = new PVector(0, 0);
    this.spriteLR = spriteLR;
    this.spriteLL = spriteLL;
    this.drawDeidaraStance(); 
    objDim = new Dimension(spriteWidth, deidaraHeight);
  }

  void drawDeidara(){
   
    switch(state)
    {
      case CharacterState.STANCE_STATE:
        drawDeidaraStance();
        break;
      case CharacterState.HEAVY_DAMAGE_2:
      if( damageCountDownCounter == 0) {
         state = CharacterState.STANCE_STATE;
      } else {
         if( damageCountDownCounter > 60) {
           // draw first frame
           drawDeidaraHeavyDamage(1);
         } else {
           // draw second frame
           drawDeidaraHeavyDamage(0);
         }
         damageCountDownCounter--;
      }
        
    }
    if (state == CharacterState.STANCE_STATE) {
      drawDeidaraStance();
    } 
  }
  
  
  void drawDeidaraStance(){
    // eventually need to have if figure out dynamically if it wants to look lef or right.
    // for now hard code to one look
 
    sX = 0;
    sY = 0;
    //varWidth = -12;
    deidaraWidth = (int) segmentStanceWidth/segmentStanceNumFrames;
    PImage spriteSegment = spriteLL.get(segmentStanceXLL, segmentStanceYLL, segmentStanceWidth, deidaraHeight);
    // for now assme static, but eventually stand still stance could show
    // some animation like heavy breathing.
    // get first frame for now
    //image(spriteSegment, 0, 0);
    //noFill();
    //rect(0,0, segmentStanceWidth, deidaraHeight);
    //rect(0,0, (int) segmentStanceWidth/segmentStanceNumFrames, deidaraHeight);
    
    PImage firstFrame = spriteSegment.get(0, 0, (int) segmentStanceWidth / segmentStanceNumFrames, deidaraHeight);
    copy(firstFrame, sX, sY, deidaraWidth , deidaraHeight, (int)this.position.x, (int)this.position.y, (int) (spriteWidth * scaleFactor), (int) (deidaraHeight * scaleFactor));
  }

  // 1st frame is frame 1, second frame is frame 0 when looking left.
  // will need to enhance this method if and when looking  right.
  void drawDeidaraHeavyDamage(int frame){
    int deidaraWidth = (int) segmentHeavyDamage2Width/segmentHeavyDamage2NumFrames;
    PImage spriteSegment = spriteLL.get(segmentHeavyDamage2XLL, segmentHeavyDamage2YLL, segmentHeavyDamage2Width, segmentHeavyDamage2Height);
   
    PImage firstFrame = spriteSegment.get(0 + deidaraWidth * frame, 0, (int) deidaraWidth, segmentHeavyDamage2Height);
    copy(firstFrame, sX, sY, segmentHeavyDamage2Width , segmentHeavyDamage2Height, (int)this.position.x, (int)this.position.y, (int) (segmentHeavyDamage2Width * scaleFactor), (int) (segmentHeavyDamage2Height * scaleFactor));
  
  }
  
  // This probably doesn't belong in this class but in a separate utility class that takes in both objects
  public void checkCollision(GameObjectIF gameObject){
    // check to see if there is a collision with this object and list of other objects.
    
    //http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
    if( gameObject instanceof CircleIF) {
       // test intersect Rectangle, Circle
       if(intersects(this, gameObject)) {
         handleCollision(gameObject); 
       } else {
         println("no collision"); 
       }
    } 
    
  }
  
  public void handleCollision(GameObjectIF gameObject){
    println("collision handled");
    if(gameObject instanceof CircleIF) {
      // for now just assume it is the rasengan.
      // make the rasengan disappear.
      rasengans.clear();
      state = CharacterState.HEAVY_DAMAGE_2;
      damageCountDownCounter = 120;
      
    }
  }
  
  public PVector getPosition(){
    return  position;
  }
  
  public Dimension getDimension(){
    return objDim;
  }
  
  
  void moveHorizontal(PVector move){
   this.position.add(move);
  }
  
  void moveVertical(PVector jump){
   this.position.add(jump);
  }
}