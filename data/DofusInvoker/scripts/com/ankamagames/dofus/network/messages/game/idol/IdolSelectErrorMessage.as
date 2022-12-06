package com.ankamagames.dofus.network.messages.game.idol
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IdolSelectErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7505;
       
      
      private var _isInitialized:Boolean = false;
      
      public var reason:uint = 0;
      
      public var idolId:uint = 0;
      
      public var activate:Boolean = false;
      
      public var party:Boolean = false;
      
      public function IdolSelectErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7505;
      }
      
      public function initIdolSelectErrorMessage(reason:uint = 0, idolId:uint = 0, activate:Boolean = false, party:Boolean = false) : IdolSelectErrorMessage
      {
         this.reason = reason;
         this.idolId = idolId;
         this.activate = activate;
         this.party = party;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.reason = 0;
         this.idolId = 0;
         this.activate = false;
         this.party = false;
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
         this.serializeAs_IdolSelectErrorMessage(output);
      }
      
      public function serializeAs_IdolSelectErrorMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.activate);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.party);
         output.writeByte(_box0);
         output.writeByte(this.reason);
         if(this.idolId < 0)
         {
            throw new Error("Forbidden value (" + this.idolId + ") on element idolId.");
         }
         output.writeVarShort(this.idolId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdolSelectErrorMessage(input);
      }
      
      public function deserializeAs_IdolSelectErrorMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this._reasonFunc(input);
         this._idolIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdolSelectErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_IdolSelectErrorMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._reasonFunc);
         tree.addChild(this._idolIdFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.activate = BooleanByteWrapper.getFlag(_box0,0);
         this.party = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _reasonFunc(input:ICustomDataInput) : void
      {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of IdolSelectErrorMessage.reason.");
         }
      }
      
      private function _idolIdFunc(input:ICustomDataInput) : void
      {
         this.idolId = input.readVarUhShort();
         if(this.idolId < 0)
         {
            throw new Error("Forbidden value (" + this.idolId + ") on element of IdolSelectErrorMessage.idolId.");
         }
      }
   }
}
