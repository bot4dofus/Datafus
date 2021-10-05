package
{
   import flash.Boot;
   import flash.Lib;
   import flash.display.MovieClip;
   
   public class haxe extends Boot
   {
       
      
      public function haxe()
      {
         super();
      }
      
      public static function initSwc(param1:MovieClip) : void
      {
         Lib.current = param1;
         new haxe().init();
      }
      
      override public function init() : void
      {
      }
   }
}
