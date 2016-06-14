class Rasengan{
  
  PImage sprite;
  
  PVector position;
  PVector velocity;
  
  int xRasengan = 0;
  int yRasengan = 0;
  int rWidth;
  int rHeight;
  int timer = 1;
  
  Rasengan(PImage sprite){
    this.sprite  = sprite;
    this.rWidth  = sprite.width / 7;
    this.rHeight = sprite.height;    
    this.position = new PVector(0, 0);
    this.velocity = new PVector(0, 0);
  }
  
  void shootRasengan(PVector position, int counter){
    this.position = position;
    this.velocity = new PVector(random(10, 30), random(-10, 1));
    this.position.add(velocity);
    
    xRasengan = (counter % 7) * rWidth;
    yRasengan = 0;
    
    copy(sprite, xRasengan, yRasengan, rWidth, rHeight, (int)this.position.x, (int)this.position.y, this.rWidth, this.rHeight);
  }
  
  void update(int counter){
    this.timer++; 
    
    xRasengan = (counter % 7) * rWidth;
    yRasengan = 0;
    
    this.position.add(this.velocity);
    this.position.y += random(-5, 5);
    copy(sprite, xRasengan, yRasengan, rWidth, rHeight, (int)this.position.x, (int)this.position.y, this.rWidth, this.rHeight);
  }
}