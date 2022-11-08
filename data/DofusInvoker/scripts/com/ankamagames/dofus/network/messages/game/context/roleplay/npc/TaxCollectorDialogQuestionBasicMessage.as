package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorDialogQuestionBasicMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3089;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guildInfo:BasicGuildInformations;
      
      private var _guildInfotree:FuncTree;
      
      public function TaxCollectorDialogQuestionBasicMessage()
      {
         this.guildInfo = new BasicGuildInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3089;
      }
      
      public function initTaxCollectorDialogQuestionBasicMessage(guildInfo:BasicGuildInformations = null) : TaxCollectorDialogQuestionBasicMessage
      {
         this.guildInfo = guildInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildInfo = new BasicGuildInformations();
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
         this.guildInfo.serializeAs_BasicGuildInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorDialogQuestionBasicMessage(input);
      }
      
      public function deserializeAs_TaxCollectorDialogQuestionBasicMessage(input:ICustomDataInput) : void
      {
         this.guildInfo = new BasicGuildInformations();
         this.guildInfo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorDialogQuestionBasicMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorDialogQuestionBasicMessage(tree:FuncTree) : void
      {
         this._guildInfotree = tree.addChild(this._guildInfotreeFunc);
      }
      
      private function _guildInfotreeFunc(input:ICustomDataInput) : void
      {
         this.guildInfo = new BasicGuildInformations();
         this.guildInfo.deserializeAsync(this._guildInfotree);
      }
   }
}
