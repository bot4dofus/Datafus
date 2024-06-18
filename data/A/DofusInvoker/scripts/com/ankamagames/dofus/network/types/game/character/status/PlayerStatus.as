package com.ankamagames.dofus.network.types.game.character.status
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PlayerStatus implements INetworkType
   {
      
      public static const protocolId:uint = 2273;
       
      
      public var statusId:uint = 1;
      
      public function PlayerStatus()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2273;
      }
      
      public function initPlayerStatus(statusId:uint = 1) : PlayerStatus
      {
         this.statusId = statusId;
         return this;
      }
      
      public function reset() : void
      {
         this.statusId = 1;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PlayerStatus(output);
      }
      
      public function serializeAs_PlayerStatus(output:ICustomDataOutput) : void
      {
         output.writeByte(this.statusId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PlayerStatus(input);
      }
      
      public function deserializeAs_PlayerStatus(input:ICustomDataInput) : void
      {
         this._statusIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PlayerStatus(tree);
      }
      
      public function deserializeAsyncAs_PlayerStatus(tree:FuncTree) : void
      {
         tree.addChild(this._statusIdFunc);
      }
      
      private function _statusIdFunc(input:ICustomDataInput) : void
      {
         this.statusId = input.readByte();
         if(this.statusId < 0)
         {
            throw new Error("Forbidden value (" + this.statusId + ") on element of PlayerStatus.statusId.");
         }
      }
   }
}
