package com.ankamagames.tiphon.types
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class BehaviorData
   {
       
      
      private var _animation:String;
      
      private var _animationStartValue:String;
      
      private var _direction:int;
      
      private var _directionStartValue:int;
      
      private var _parent:TiphonSprite;
      
      public var lock:Boolean = false;
      
      public function BehaviorData(animation:String, direction:int, parent:TiphonSprite)
      {
         super();
         this._animation = animation;
         this._animationStartValue = animation;
         this._parent = parent;
         this._direction = direction;
         this._directionStartValue = direction;
      }
      
      public function get animation() : String
      {
         return this._animation;
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
      
      public function set animation(v:String) : void
      {
         if(!this.lock)
         {
            this._animation = v;
         }
      }
      
      public function get animationStartValue() : String
      {
         return this._animationStartValue;
      }
      
      public function get directionStartValue() : int
      {
         return this._directionStartValue;
      }
      
      public function get parent() : TiphonSprite
      {
         return this._parent;
      }
   }
}
