package com.ankamagames.dofus.network.types.game.pvp
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AgressableStatusMessage implements INetworkType
   {
      
      public static const protocolId:uint = 6140;
       
      
      public var playerId:Number = 0;
      
      public var enable:uint = 0;
      
      public var roleAvAId:int = 0;
      
      public var pictoScore:int = 0;
      
      public function AgressableStatusMessage()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 6140;
      }
      
      public function initAgressableStatusMessage(playerId:Number = 0, enable:uint = 0, roleAvAId:int = 0, pictoScore:int = 0) : AgressableStatusMessage
      {
         this.playerId = playerId;
         this.enable = enable;
         this.roleAvAId = roleAvAId;
         this.pictoScore = pictoScore;
         return this;
      }
      
      public function reset() : void
      {
         this.playerId = 0;
         this.enable = 0;
         this.roleAvAId = 0;
         this.pictoScore = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AgressableStatusMessage(output);
      }
      
      public function serializeAs_AgressableStatusMessage(output:ICustomDataOutput) : void
      {
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeByte(this.enable);
         output.writeInt(this.roleAvAId);
         output.writeInt(this.pictoScore);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AgressableStatusMessage(input);
      }
      
      public function deserializeAs_AgressableStatusMessage(input:ICustomDataInput) : void
      {
         this._playerIdFunc(input);
         this._enableFunc(input);
         this._roleAvAIdFunc(input);
         this._pictoScoreFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AgressableStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_AgressableStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._enableFunc);
         tree.addChild(this._roleAvAIdFunc);
         tree.addChild(this._pictoScoreFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of AgressableStatusMessage.playerId.");
         }
      }
      
      private function _enableFunc(input:ICustomDataInput) : void
      {
         this.enable = input.readByte();
         if(this.enable < 0)
         {
            throw new Error("Forbidden value (" + this.enable + ") on element of AgressableStatusMessage.enable.");
         }
      }
      
      private function _roleAvAIdFunc(input:ICustomDataInput) : void
      {
         this.roleAvAId = input.readInt();
      }
      
      private function _pictoScoreFunc(input:ICustomDataInput) : void
      {
         this.pictoScore = input.readInt();
      }
   }
}
