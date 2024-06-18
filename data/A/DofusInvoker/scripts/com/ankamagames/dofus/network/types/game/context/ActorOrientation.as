package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ActorOrientation implements INetworkType
   {
      
      public static const protocolId:uint = 2066;
       
      
      public var id:Number = 0;
      
      public var direction:uint = 1;
      
      public function ActorOrientation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2066;
      }
      
      public function initActorOrientation(id:Number = 0, direction:uint = 1) : ActorOrientation
      {
         this.id = id;
         this.direction = direction;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.direction = 1;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ActorOrientation(output);
      }
      
      public function serializeAs_ActorOrientation(output:ICustomDataOutput) : void
      {
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeDouble(this.id);
         output.writeByte(this.direction);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ActorOrientation(input);
      }
      
      public function deserializeAs_ActorOrientation(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._directionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ActorOrientation(tree);
      }
      
      public function deserializeAsyncAs_ActorOrientation(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._directionFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readDouble();
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of ActorOrientation.id.");
         }
      }
      
      private function _directionFunc(input:ICustomDataInput) : void
      {
         this.direction = input.readByte();
         if(this.direction < 0)
         {
            throw new Error("Forbidden value (" + this.direction + ") on element of ActorOrientation.direction.");
         }
      }
   }
}
