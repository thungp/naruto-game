class Rasengan{
  
  PImage rasengan;
  
  PVector position;
  PVector velocity;
  
  int xRasengan = 0;
  int yRasengan = 0;
  int rWidth;
  int rHeight;
  
  Rasengan(SpriteFrame sprite){
    rasengan = sprite.get(0, 4150, 500, 70);// OOdama Rasengan
    rWidth  = (int)rasengans[0].width / 7;
    rHeight = (int)rasengans[0].height;    
  }
  
  void shootRasengan(PVector position, int counter){
    this.position = position;
    this.velocity = new PVector(random(10, 30), random(-30, 2));
    
    xRasengan = (counter % 7) * rWidth;
    yRasengan = 0;
    
    copy(rasengan, xRasengan, yRasengan, rWidth, rHeight, (int)position.x, (int)position.y, rWidth, rHeight);
  }
}