package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceFactsRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1534;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceId:uint = 0;
      
      public function AllianceFactsRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1534;
      }
      
      public function initAllianceFactsRequestMessage(allianceId:uint = 0) : AllianceFactsRequestMessage
      {
         this.allianceId = allianceId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
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
         this.serializeAs_AllianceFactsRequestMessage(output);
      }
      
      public function serializeAs_AllianceFactsRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         output.writeVarInt(this.allianceId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceFactsRequestMessage(input);
      }
      
      public function deserializeAs_AllianceFactsRequestMessage(input:ICustomDataInput) : void
      {
         this._allianceIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceFactsRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceFactsRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._allianceIdFunc);
      }
      
      private function _allianceIdFunc(input:ICustomDataInput) : void
      {
         this.allianceId = input.readVarUhInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of AllianceFactsRequestMessage.allianceId.");
         }
      }
   }
}
