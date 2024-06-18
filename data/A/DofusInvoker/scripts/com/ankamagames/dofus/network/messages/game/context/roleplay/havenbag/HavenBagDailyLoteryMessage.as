package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HavenBagDailyLoteryMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9352;
       
      
      private var _isInitialized:Boolean = false;
      
      public var returnType:uint = 0;
      
      public var gameActionId:String = "";
      
      public function HavenBagDailyLoteryMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9352;
      }
      
      public function initHavenBagDailyLoteryMessage(returnType:uint = 0, gameActionId:String = "") : HavenBagDailyLoteryMessage
      {
         this.returnType = returnType;
         this.gameActionId = gameActionId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.returnType = 0;
         this.gameActionId = "";
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
         this.serializeAs_HavenBagDailyLoteryMessage(output);
      }
      
      public function serializeAs_HavenBagDailyLoteryMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.returnType);
         output.writeUTF(this.gameActionId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HavenBagDailyLoteryMessage(input);
      }
      
      public function deserializeAs_HavenBagDailyLoteryMessage(input:ICustomDataInput) : void
      {
         this._returnTypeFunc(input);
         this._gameActionIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HavenBagDailyLoteryMessage(tree);
      }
      
      public function deserializeAsyncAs_HavenBagDailyLoteryMessage(tree:FuncTree) : void
      {
         tree.addChild(this._returnTypeFunc);
         tree.addChild(this._gameActionIdFunc);
      }
      
      private function _returnTypeFunc(input:ICustomDataInput) : void
      {
         this.returnType = input.readByte();
         if(this.returnType < 0)
         {
            throw new Error("Forbidden value (" + this.returnType + ") on element of HavenBagDailyLoteryMessage.returnType.");
         }
      }
      
      private function _gameActionIdFunc(input:ICustomDataInput) : void
      {
         this.gameActionId = input.readUTF();
      }
   }
}
