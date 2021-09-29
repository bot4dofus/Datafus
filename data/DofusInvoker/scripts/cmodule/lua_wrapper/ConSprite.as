package cmodule.lua_wrapper
{
   import flash.display.Sprite;
   
   public class ConSprite extends Sprite
   {
       
      
      private var runner:CRunner;
      
      public function ConSprite()
      {
         this.runner = new CRunner();
         super();
         if(gsprite)
         {
            log(1,"More than one sprite!");
         }
         gsprite = this;
         this.runner.startSystem();
      }
   }
}
