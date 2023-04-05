package com.ankamagames.atouin.types
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import com.ankamagames.jerakine.pools.Poolable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class WorldEntitySprite extends TiphonSprite implements ICustomUnicNameGetter, Poolable, IEntity
   {
       
      
      private var _cellId:int;
      
      private var _identifier:int;
      
      private var _name:String;
      
      private var _id:Number;
      
      private var _position:MapPoint;
      
      public function WorldEntitySprite(look:TiphonEntityLook, cellId:int, identifier:int)
      {
         this._identifier = identifier;
         this._name = "mapGfx::" + identifier;
         this._cellId = cellId;
         this._id = EntitiesManager.getInstance().getFreeEntityId();
         super(look);
         EntitiesManager.getInstance().addAnimatedEntity(this._id,this);
      }
      
      public function get cellId() : int
      {
         return this._cellId;
      }
      
      public function get identifier() : int
      {
         return this._identifier;
      }
      
      public function get customUnicName() : String
      {
         return this._name;
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
      
      public function initialize(look:TiphonEntityLook, cellId:int, identifier:int) : void
      {
         this._name = "mapGfx::" + identifier;
         this._cellId = cellId;
         this._identifier = identifier;
         super.init(look);
      }
      
      public function free() : void
      {
         this.x = 0;
         this.y = 0;
         this._cellId = 0;
         this._identifier = 0;
         this._name = null;
         dispatchEvent(new TiphonEvent(TiphonEvent.ADDED_IN_POOL,this));
         super.destroy();
      }
      
      override public function destroy() : void
      {
         EntitiesManager.getInstance().removeEntity(this._id);
         super.destroy();
      }
   }
}
