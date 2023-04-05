package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.Sprite;
   
   public class CheckPointEntity extends Sprite implements IEntity, IDisplayable
   {
       
      
      private var _id:Number;
      
      private var _position:MapPoint;
      
      private var _displayed:Boolean;
      
      private var _displayedObject:Sprite;
      
      public function CheckPointEntity(spr:Sprite = null, pos:MapPoint = null)
      {
         super();
         this._position = pos;
         if(spr != null)
         {
            this._displayedObject = spr;
            addChild(this._displayedObject);
         }
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function set id(nValue:Number) : void
      {
         this._id = nValue;
      }
      
      public function get position() : MapPoint
      {
         return this._position;
      }
      
      public function set position(oValue:MapPoint) : void
      {
         this._position = oValue;
      }
      
      public function get displayBehaviors() : IDisplayBehavior
      {
         return null;
      }
      
      public function set displayBehaviors(oValue:IDisplayBehavior) : void
      {
      }
      
      public function get absoluteBounds() : IRectangle
      {
         return null;
      }
      
      public function get displayed() : Boolean
      {
         return this._displayed;
      }
      
      public function display(strata:uint = 0) : void
      {
         this._displayed = true;
      }
      
      public function remove() : void
      {
         if(this._displayedObject != null)
         {
            removeChild(this._displayedObject);
            this._displayedObject = null;
         }
         this._displayed = false;
      }
   }
}
