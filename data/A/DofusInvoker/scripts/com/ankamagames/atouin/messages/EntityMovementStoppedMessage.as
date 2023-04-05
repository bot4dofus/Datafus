package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.messages.Message;
   
   public class EntityMovementStoppedMessage implements Message
   {
       
      
      private var _entity:IEntity;
      
      public var id:Number;
      
      public function EntityMovementStoppedMessage(entity:IEntity)
      {
         super();
         this._entity = entity;
         if(this._entity)
         {
            this.id = entity.id;
         }
      }
      
      public function get entity() : IEntity
      {
         return this._entity;
      }
   }
}
