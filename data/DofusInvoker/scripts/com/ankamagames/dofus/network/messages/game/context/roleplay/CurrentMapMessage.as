package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CurrentMapMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8909;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mapId:Number = 0;
      
      public var mapKey:String = "";
      
      public function CurrentMapMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8909;
      }
      
      public function initCurrentMapMessage(mapId:Number = 0, mapKey:String = "") : CurrentMapMessage
      {
         this.mapId = mapId;
         this.mapKey = mapKey;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mapId = 0;
         this.mapKey = "";
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
         this.serializeAs_CurrentMapMessage(output);
      }
      
      public function serializeAs_CurrentMapMessage(output:ICustomDataOutput) : void
      {
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         output.writeUTF(this.mapKey);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CurrentMapMessage(input);
      }
      
      public function deserializeAs_CurrentMapMessage(input:ICustomDataInput) : void
      {
         this._mapIdFunc(input);
         this._mapKeyFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CurrentMapMessage(tree);
      }
      
      public function deserializeAsyncAs_CurrentMapMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._mapKeyFunc);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of CurrentMapMessage.mapId.");
         }
      }
      
      private function _mapKeyFunc(input:ICustomDataInput) : void
      {
         this.mapKey = input.readUTF();
      }
   }
}
