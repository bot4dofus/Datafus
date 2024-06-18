package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.dofus.network.types.game.Uuid;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MoveTaxCollectorPresetSpellMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6548;
       
      
      private var _isInitialized:Boolean = false;
      
      public var presetId:Uuid;
      
      public var movedFrom:uint = 0;
      
      public var movedTo:uint = 0;
      
      private var _presetIdtree:FuncTree;
      
      public function MoveTaxCollectorPresetSpellMessage()
      {
         this.presetId = new Uuid();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6548;
      }
      
      public function initMoveTaxCollectorPresetSpellMessage(presetId:Uuid = null, movedFrom:uint = 0, movedTo:uint = 0) : MoveTaxCollectorPresetSpellMessage
      {
         this.presetId = presetId;
         this.movedFrom = movedFrom;
         this.movedTo = movedTo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.presetId = new Uuid();
         this.movedTo = 0;
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
         this.serializeAs_MoveTaxCollectorPresetSpellMessage(output);
      }
      
      public function serializeAs_MoveTaxCollectorPresetSpellMessage(output:ICustomDataOutput) : void
      {
         this.presetId.serializeAs_Uuid(output);
         if(this.movedFrom < 0)
         {
            throw new Error("Forbidden value (" + this.movedFrom + ") on element movedFrom.");
         }
         output.writeByte(this.movedFrom);
         if(this.movedTo < 0)
         {
            throw new Error("Forbidden value (" + this.movedTo + ") on element movedTo.");
         }
         output.writeByte(this.movedTo);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MoveTaxCollectorPresetSpellMessage(input);
      }
      
      public function deserializeAs_MoveTaxCollectorPresetSpellMessage(input:ICustomDataInput) : void
      {
         this.presetId = new Uuid();
         this.presetId.deserialize(input);
         this._movedFromFunc(input);
         this._movedToFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MoveTaxCollectorPresetSpellMessage(tree);
      }
      
      public function deserializeAsyncAs_MoveTaxCollectorPresetSpellMessage(tree:FuncTree) : void
      {
         this._presetIdtree = tree.addChild(this._presetIdtreeFunc);
         tree.addChild(this._movedFromFunc);
         tree.addChild(this._movedToFunc);
      }
      
      private function _presetIdtreeFunc(input:ICustomDataInput) : void
      {
         this.presetId = new Uuid();
         this.presetId.deserializeAsync(this._presetIdtree);
      }
      
      private function _movedFromFunc(input:ICustomDataInput) : void
      {
         this.movedFrom = input.readByte();
         if(this.movedFrom < 0)
         {
            throw new Error("Forbidden value (" + this.movedFrom + ") on element of MoveTaxCollectorPresetSpellMessage.movedFrom.");
         }
      }
      
      private function _movedToFunc(input:ICustomDataInput) : void
      {
         this.movedTo = input.readByte();
         if(this.movedTo < 0)
         {
            throw new Error("Forbidden value (" + this.movedTo + ") on element of MoveTaxCollectorPresetSpellMessage.movedTo.");
         }
      }
   }
}
