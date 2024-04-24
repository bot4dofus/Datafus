package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorDialogQuestionExtendedMessage extends TaxCollectorDialogQuestionBasicMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9077;
       
      
      private var _isInitialized:Boolean = false;
      
      public var maxPods:uint = 0;
      
      public var prospecting:uint = 0;
      
      public var alliance:BasicNamedAllianceInformations;
      
      public var taxCollectorsCount:uint = 0;
      
      public var taxCollectorAttack:int = 0;
      
      public var pods:uint = 0;
      
      public var itemsValue:Number = 0;
      
      private var _alliancetree:FuncTree;
      
      public function TaxCollectorDialogQuestionExtendedMessage()
      {
         this.alliance = new BasicNamedAllianceInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9077;
      }
      
      public function initTaxCollectorDialogQuestionExtendedMessage(allianceInfo:BasicAllianceInformations = null, maxPods:uint = 0, prospecting:uint = 0, alliance:BasicNamedAllianceInformations = null, taxCollectorsCount:uint = 0, taxCollectorAttack:int = 0, pods:uint = 0, itemsValue:Number = 0) : TaxCollectorDialogQuestionExtendedMessage
      {
         super.initTaxCollectorDialogQuestionBasicMessage(allianceInfo);
         this.maxPods = maxPods;
         this.prospecting = prospecting;
         this.alliance = alliance;
         this.taxCollectorsCount = taxCollectorsCount;
         this.taxCollectorAttack = taxCollectorAttack;
         this.pods = pods;
         this.itemsValue = itemsValue;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.maxPods = 0;
         this.prospecting = 0;
         this.alliance = new BasicNamedAllianceInformations();
         this.taxCollectorAttack = 0;
         this.pods = 0;
         this.itemsValue = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorDialogQuestionExtendedMessage(output);
      }
      
      public function serializeAs_TaxCollectorDialogQuestionExtendedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_TaxCollectorDialogQuestionBasicMessage(output);
         if(this.maxPods < 0)
         {
            throw new Error("Forbidden value (" + this.maxPods + ") on element maxPods.");
         }
         output.writeVarShort(this.maxPods);
         if(this.prospecting < 0)
         {
            throw new Error("Forbidden value (" + this.prospecting + ") on element prospecting.");
         }
         output.writeVarShort(this.prospecting);
         this.alliance.serializeAs_BasicNamedAllianceInformations(output);
         if(this.taxCollectorsCount < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorsCount + ") on element taxCollectorsCount.");
         }
         output.writeByte(this.taxCollectorsCount);
         output.writeInt(this.taxCollectorAttack);
         if(this.pods < 0)
         {
            throw new Error("Forbidden value (" + this.pods + ") on element pods.");
         }
         output.writeVarInt(this.pods);
         if(this.itemsValue < 0 || this.itemsValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.itemsValue + ") on element itemsValue.");
         }
         output.writeVarLong(this.itemsValue);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorDialogQuestionExtendedMessage(input);
      }
      
      public function deserializeAs_TaxCollectorDialogQuestionExtendedMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._maxPodsFunc(input);
         this._prospectingFunc(input);
         this.alliance = new BasicNamedAllianceInformations();
         this.alliance.deserialize(input);
         this._taxCollectorsCountFunc(input);
         this._taxCollectorAttackFunc(input);
         this._podsFunc(input);
         this._itemsValueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorDialogQuestionExtendedMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorDialogQuestionExtendedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._maxPodsFunc);
         tree.addChild(this._prospectingFunc);
         this._alliancetree = tree.addChild(this._alliancetreeFunc);
         tree.addChild(this._taxCollectorsCountFunc);
         tree.addChild(this._taxCollectorAttackFunc);
         tree.addChild(this._podsFunc);
         tree.addChild(this._itemsValueFunc);
      }
      
      private function _maxPodsFunc(input:ICustomDataInput) : void
      {
         this.maxPods = input.readVarUhShort();
         if(this.maxPods < 0)
         {
            throw new Error("Forbidden value (" + this.maxPods + ") on element of TaxCollectorDialogQuestionExtendedMessage.maxPods.");
         }
      }
      
      private function _prospectingFunc(input:ICustomDataInput) : void
      {
         this.prospecting = input.readVarUhShort();
         if(this.prospecting < 0)
         {
            throw new Error("Forbidden value (" + this.prospecting + ") on element of TaxCollectorDialogQuestionExtendedMessage.prospecting.");
         }
      }
      
      private function _alliancetreeFunc(input:ICustomDataInput) : void
      {
         this.alliance = new BasicNamedAllianceInformations();
         this.alliance.deserializeAsync(this._alliancetree);
      }
      
      private function _taxCollectorsCountFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorsCount = input.readByte();
         if(this.taxCollectorsCount < 0)
         {
            throw new Error("Forbidden value (" + this.taxCollectorsCount + ") on element of TaxCollectorDialogQuestionExtendedMessage.taxCollectorsCount.");
         }
      }
      
      private function _taxCollectorAttackFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorAttack = input.readInt();
      }
      
      private function _podsFunc(input:ICustomDataInput) : void
      {
         this.pods = input.readVarUhInt();
         if(this.pods < 0)
         {
            throw new Error("Forbidden value (" + this.pods + ") on element of TaxCollectorDialogQuestionExtendedMessage.pods.");
         }
      }
      
      private function _itemsValueFunc(input:ICustomDataInput) : void
      {
         this.itemsValue = input.readVarUhLong();
         if(this.itemsValue < 0 || this.itemsValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.itemsValue + ") on element of TaxCollectorDialogQuestionExtendedMessage.itemsValue.");
         }
      }
   }
}
