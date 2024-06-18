package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorDialogQuestionBasicMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3500;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceInfo:BasicAllianceInformations;
      
      private var _allianceInfotree:FuncTree;
      
      public function TaxCollectorDialogQuestionBasicMessage()
      {
         this.allianceInfo = new BasicAllianceInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3500;
      }
      
      public function initTaxCollectorDialogQuestionBasicMessage(allianceInfo:BasicAllianceInformations = null) : TaxCollectorDialogQuestionBasicMessage
      {
         this.allianceInfo = allianceInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceInfo = new BasicAllianceInformations();
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
         this.serializeAs_TaxCollectorDialogQuestionBasicMessage(output);
      }
      
      public function serializeAs_TaxCollectorDialogQuestionBasicMessage(output:ICustomDataOutput) : void
      {
         this.allianceInfo.serializeAs_BasicAllianceInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorDialogQuestionBasicMessage(input);
      }
      
      public function deserializeAs_TaxCollectorDialogQuestionBasicMessage(input:ICustomDataInput) : void
      {
         this.allianceInfo = new BasicAllianceInformations();
         this.allianceInfo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorDialogQuestionBasicMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorDialogQuestionBasicMessage(tree:FuncTree) : void
      {
         this._allianceInfotree = tree.addChild(this._allianceInfotreeFunc);
      }
      
      private function _allianceInfotreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInfo = new BasicAllianceInformations();
         this.allianceInfo.deserializeAsync(this._allianceInfotree);
      }
   }
}
