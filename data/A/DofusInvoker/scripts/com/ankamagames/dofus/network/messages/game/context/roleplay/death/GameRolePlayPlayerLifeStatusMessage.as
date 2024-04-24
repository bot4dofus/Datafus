package com.ankamagames.dofus.network.messages.game.context.roleplay.death
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayPlayerLifeStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3890;
       
      
      private var _isInitialized:Boolean = false;
      
      public var state:uint = 0;
      
      public var phenixMapId:Number = 0;
      
      public function GameRolePlayPlayerLifeStatusMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3890;
      }
      
      public function initGameRolePlayPlayerLifeStatusMessage(state:uint = 0, phenixMapId:Number = 0) : GameRolePlayPlayerLifeStatusMessage
      {
         this.state = state;
         this.phenixMapId = phenixMapId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.state = 0;
         this.phenixMapId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayPlayerLifeStatusMessage(output);
      }
      
      public function serializeAs_GameRolePlayPlayerLifeStatusMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.state);
         if(this.phenixMapId < 0 || this.phenixMapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.phenixMapId + ") on element phenixMapId.");
         }
         output.writeDouble(this.phenixMapId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayPlayerLifeStatusMessage(input);
      }
      
      public function deserializeAs_GameRolePlayPlayerLifeStatusMessage(input:ICustomDataInput) : void
      {
         this._stateFunc(input);
         this._phenixMapIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayPlayerLifeStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayPlayerLifeStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this._stateFunc);
         tree.addChild(this._phenixMapIdFunc);
      }
      
      private function _stateFunc(input:ICustomDataInput) : void
      {
         this.state = input.readByte();
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element of GameRolePlayPlayerLifeStatusMessage.state.");
         }
      }
      
      private function _phenixMapIdFunc(input:ICustomDataInput) : void
      {
         this.phenixMapId = input.readDouble();
         if(this.phenixMapId < 0 || this.phenixMapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.phenixMapId + ") on element of GameRolePlayPlayerLifeStatusMessage.phenixMapId.");
         }
      }
   }
}
