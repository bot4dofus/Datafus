package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TopTaxCollectorListMessage extends AbstractTaxCollectorListMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2111;
       
      
      private var _isInitialized:Boolean = false;
      
      public var isDungeon:Boolean = false;
      
      public function TopTaxCollectorListMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2111;
      }
      
      public function initTopTaxCollectorListMessage(informations:Vector.<TaxCollectorInformations> = null, isDungeon:Boolean = false) : TopTaxCollectorListMessage
      {
         super.initAbstractTaxCollectorListMessage(informations);
         this.isDungeon = isDungeon;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.isDungeon = false;
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
         this.serializeAs_TopTaxCollectorListMessage(output);
      }
      
      public function serializeAs_TopTaxCollectorListMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractTaxCollectorListMessage(output);
         output.writeBoolean(this.isDungeon);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TopTaxCollectorListMessage(input);
      }
      
      public function deserializeAs_TopTaxCollectorListMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._isDungeonFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TopTaxCollectorListMessage(tree);
      }
      
      public function deserializeAsyncAs_TopTaxCollectorListMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._isDungeonFunc);
      }
      
      private function _isDungeonFunc(input:ICustomDataInput) : void
      {
         this.isDungeon = input.readBoolean();
      }
   }
}
