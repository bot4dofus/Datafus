package com.ankamagames.dofus.network.types.game.character.status
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PlayerStatusExtended extends PlayerStatus implements INetworkType
   {
      
      public static const protocolId:uint = 5742;
       
      
      public var message:String = "";
      
      public function PlayerStatusExtended()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5742;
      }
      
      public function initPlayerStatusExtended(statusId:uint = 1, message:String = "") : PlayerStatusExtended
      {
         super.initPlayerStatus(statusId);
         this.message = message;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.message = "";
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PlayerStatusExtended(output);
      }
      
      public function serializeAs_PlayerStatusExtended(output:ICustomDataOutput) : void
      {
         super.serializeAs_PlayerStatus(output);
         output.writeUTF(this.message);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PlayerStatusExtended(input);
      }
      
      public function deserializeAs_PlayerStatusExtended(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._messageFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PlayerStatusExtended(tree);
      }
      
      public function deserializeAsyncAs_PlayerStatusExtended(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._messageFunc);
      }
      
      private function _messageFunc(input:ICustomDataInput) : void
      {
         this.message = input.readUTF();
      }
   }
}
