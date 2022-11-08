package com.ankamagames.dofus.network.messages.game.idol
{
   import com.ankamagames.dofus.network.types.game.idol.PartyIdol;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IdolPartyRefreshMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 443;
       
      
      private var _isInitialized:Boolean = false;
      
      public var partyIdol:PartyIdol;
      
      private var _partyIdoltree:FuncTree;
      
      public function IdolPartyRefreshMessage()
      {
         this.partyIdol = new PartyIdol();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 443;
      }
      
      public function initIdolPartyRefreshMessage(partyIdol:PartyIdol = null) : IdolPartyRefreshMessage
      {
         this.partyIdol = partyIdol;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.partyIdol = new PartyIdol();
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
         this.serializeAs_IdolPartyRefreshMessage(output);
      }
      
      public function serializeAs_IdolPartyRefreshMessage(output:ICustomDataOutput) : void
      {
         this.partyIdol.serializeAs_PartyIdol(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdolPartyRefreshMessage(input);
      }
      
      public function deserializeAs_IdolPartyRefreshMessage(input:ICustomDataInput) : void
      {
         this.partyIdol = new PartyIdol();
         this.partyIdol.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdolPartyRefreshMessage(tree);
      }
      
      public function deserializeAsyncAs_IdolPartyRefreshMessage(tree:FuncTree) : void
      {
         this._partyIdoltree = tree.addChild(this._partyIdoltreeFunc);
      }
      
      private function _partyIdoltreeFunc(input:ICustomDataInput) : void
      {
         this.partyIdol = new PartyIdol();
         this.partyIdol.deserializeAsync(this._partyIdoltree);
      }
   }
}
