package com.ankamagames.berilia.types.uiDefinition
{
   import com.ankamagames.berilia.types.graphic.GraphicLocation;
   
   public class LocationELement
   {
       
      
      public var point:uint;
      
      public var relativePoint:uint;
      
      public var relativeTo:String;
      
      public var type:uint;
      
      public var offsetX:Number;
      
      public var offsetY:Number;
      
      public var offsetXType:uint;
      
      public var offsetYType:uint;
      
      public function LocationELement()
      {
         super();
      }
      
      public function toGraphicLocation() : GraphicLocation
      {
         var gl:GraphicLocation = new GraphicLocation(this.point,this.relativePoint,this.relativeTo);
         gl.offsetXType = this.offsetXType;
         gl.offsetYType = this.offsetYType;
         if(!isNaN(this.offsetX))
         {
            gl.setOffsetX(this.offsetX);
         }
         if(!isNaN(this.offsetY))
         {
            gl.setOffsetY(this.offsetY);
         }
         return gl;
      }
   }
}
