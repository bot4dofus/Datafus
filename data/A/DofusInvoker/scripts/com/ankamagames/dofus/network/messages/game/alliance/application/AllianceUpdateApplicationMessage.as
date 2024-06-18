package com.ankamagames.dofus.network.messages.game.alliance.application
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceUpdateApplicationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8299;
       
      
      private var _isInitialized:Boolean = false;
      
      public var applyText:String = "";
      
      public var allianceId:uint = 0;
      
      public function AllianceUpdateApplicationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8299;
      }
      
      public function initAllianceUpdateApplicationMessage(applyText:String = "", allianceId:uint = 0) : AllianceUpdateApplicationMessage
      {
         this.applyText = applyText;
         this.allianceId = allianceId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.applyText = "";
         this.allianceId = 0;
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
         this.serializeAs_AllianceUpdateApplicationMessage(output);
      }
      
      public function serializeAs_AllianceUpdateApplicationMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.applyText);
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         output.writeVarInt(this.allianceId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceUpdateApplicationMessage(input);
      }
      
      public function deserializeAs_AllianceUpdateApplicationMessage(input:ICustomDataInput) : void
      {
         this._applyTextFunc(input);
         this._allianceIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceUpdateApplicationMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceUpdateApplicationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._applyTextFunc);
         tree.addChild(this._allianceIdFunc);
      }
      
      private function _applyTextFunc(input:ICustomDataInput) : void
      {
         this.applyText = input.readUTF();
      }
      
      private function _allianceIdFunc(input:ICustomDataInput) : void
      {
         this.allianceId = input.readVarUhInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of AllianceUpdateApplicationMessage.allianceId.");
         }
      }
   }
}
