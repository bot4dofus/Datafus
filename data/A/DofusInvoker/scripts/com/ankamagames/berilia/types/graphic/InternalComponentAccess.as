package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.UIComponent;
   
   public class InternalComponentAccess
   {
       
      
      public function InternalComponentAccess()
      {
         super();
      }
      
      public static function getProperty(target:UIComponent, property:String) : *
      {
         return target[property];
      }
      
      public static function setProperty(target:UIComponent, property:String, value:*) : void
      {
         target[property] = value;
      }
   }
}
