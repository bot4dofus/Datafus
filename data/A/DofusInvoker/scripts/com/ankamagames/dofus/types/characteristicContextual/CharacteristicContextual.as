package com.ankamagames.dofus.types.characteristicContextual
{
   import com.ankamagames.berilia.types.event.BeriliaEvent;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import flash.display.Sprite;
   
   public class CharacteristicContextual extends Sprite
   {
       
      
      private var _referedEntity:IEntity;
      
      public var gameContext:uint;
      
      public function CharacteristicContextual()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function get referedEntity() : IEntity
      {
         return this._referedEntity;
      }
      
      public function set referedEntity(oEntity:IEntity) : void
      {
         this._referedEntity = oEntity;
      }
      
      public function remove() : void
      {
         dispatchEvent(new BeriliaEvent(BeriliaEvent.REMOVE_COMPONENT));
      }
   }
}
