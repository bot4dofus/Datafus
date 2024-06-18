package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameContextKickMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2032;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public function GameContextKickMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2032;
      }
      
      public function initGameContextKickMessage(targetId:Number = 0) : GameContextKickMessage
      {
         this.targetId = targetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.targetId = 0;
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
         this.serializeAs_GameContextKickMessage(output);
      }
      
      public function serializeAs_GameContextKickMessage(output:ICustomDataOutput) : void
      {
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextKickMessage(input);
      }
      
      public function deserializeAs_GameContextKickMessage(input:ICustomDataInput) : void
      {
         this._targetIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameContextKickMessage(tree);
      }
      
      public function deserializeAsyncAs_GameContextKickMessage(tree:FuncTree) : void
      {
         tree.addChild(this._targetIdFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameContextKickMessage.targetId.");
         }
      }
   }
}
