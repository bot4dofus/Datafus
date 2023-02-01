package com.ankamagames.tiphon.types
{
   public class TiphonEventInfo
   {
       
      
      public var type:String;
      
      private var _label:String;
      
      private var _sprite;
      
      private var _params:String;
      
      private var _animationType:String;
      
      private var _direction:int = -1;
      
      public function TiphonEventInfo(pType:String, pParams:String = "")
      {
         super();
         this.type = pType;
         this._params = pParams;
      }
      
      private static function getAnimationParameters(pAnimationName:String) : Array
      {
         var splited:Array = pAnimationName.split("_");
         var size:uint = splited.length;
         var animationType:String = "";
         for(var i:uint = 0; i < size - 1; i++)
         {
            if(i > 0)
            {
               animationType += "_" + splited[i];
            }
            else
            {
               animationType = splited[i];
            }
         }
         var direction:int = splited[splited.length - 1];
         if(direction == 3)
         {
            direction = 1;
         }
         if(direction == 7)
         {
            direction = 5;
         }
         return [animationType,direction];
      }
      
      private static function getAnimationName(animationType:String, direction:int) : String
      {
         return animationType + "_" + direction;
      }
      
      public static function parseAnimationName(pAnimationName:String) : String
      {
         var result:Array = getAnimationParameters(pAnimationName);
         return getAnimationName(result[0],result[1]);
      }
      
      public function set label(pLabel:String) : void
      {
         this._label = pLabel;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function get sprite() : *
      {
         return this._sprite;
      }
      
      public function get params() : String
      {
         return this._params;
      }
      
      public function get animationType() : String
      {
         if(this._animationType == null)
         {
            return "undefined";
         }
         return this._animationType;
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
      
      public function get animationName() : String
      {
         return getAnimationName(this._animationType,this._direction);
      }
      
      public function set animationName(pAnimationName:String) : void
      {
         var result:Array = getAnimationParameters(pAnimationName);
         this._animationType = result[0];
         this._direction = result[1];
      }
      
      public function duplicate() : TiphonEventInfo
      {
         return new TiphonEventInfo(this.type,this._params);
      }
      
      public function destroy() : void
      {
         this._sprite = null;
      }
   }
}
