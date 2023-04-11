package com.ankamagames.jerakine.types
{
   public class UserFont
   {
      
      public static const FONT_SIZE_NO_MAX:uint = 0;
      
      public static const FONT_SHARPNESS_MIN:int = -400;
      
      public static const FONT_SHARPNESS_NORMAL:int = 0;
      
      public static const FONT_SHARPNESS_MAX:int = 400;
       
      
      public var realName:String;
      
      public var className:String;
      
      public var sizeMultiplicator:Number;
      
      public var url:String;
      
      public var embedAsCff:Boolean;
      
      public var maxSize:uint = 0;
      
      public var sharpness:int = 0;
      
      public var antialiasingType:String = "advanced";
      
      public var verticalOffset:Number = 0.0;
      
      public var letterSpacing:Number = 0.0;
      
      public function UserFont(realName:String, className:String, sizeMultiplicator:Number, url:String, embedAsCff:Boolean, maxSize:uint, sharpness:int, verticalOffset:Number, letterSpacing:Number)
      {
         super();
         this.realName = realName;
         this.className = className;
         this.sizeMultiplicator = !!isNaN(sizeMultiplicator) ? Number(0) : Number(sizeMultiplicator);
         this.url = url;
         this.embedAsCff = embedAsCff;
         this.maxSize = maxSize;
         this.sharpness = sharpness;
         this.verticalOffset = !!isNaN(verticalOffset) ? Number(0) : Number(verticalOffset);
         this.letterSpacing = !!isNaN(letterSpacing) ? Number(0) : Number(letterSpacing);
      }
   }
}
