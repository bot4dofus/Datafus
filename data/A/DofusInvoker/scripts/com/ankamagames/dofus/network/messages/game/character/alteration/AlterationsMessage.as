package com.ankamagames.dofus.network.messages.game.character.alteration
{
   import com.ankamagames.dofus.network.types.game.character.alteration.AlterationInfo;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AlterationsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2600;
       
      
      private var _isInitialized:Boolean = false;
      
      public var alterations:Vector.<AlterationInfo>;
      
      private var _alterationstree:FuncTree;
      
      public function AlterationsMessage()
      {
         this.alterations = new Vector.<AlterationInfo>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2600;
      }
      
      public function initAlterationsMessage(alterations:Vector.<AlterationInfo> = null) : AlterationsMessage
      {
         this.alterations = alterations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.alterations = new Vector.<AlterationInfo>();
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
         this.serializeAs_AlterationsMessage(output);
      }
      
      public function serializeAs_AlterationsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.alterations.length);
         for(var _i1:uint = 0; _i1 < this.alterations.length; _i1++)
         {
            (this.alterations[_i1] as AlterationInfo).serializeAs_AlterationInfo(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlterationsMessage(input);
      }
      
      public function deserializeAs_AlterationsMessage(input:ICustomDataInput) : void
      {
         var _item1:AlterationInfo = null;
         var _alterationsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _alterationsLen; _i1++)
         {
            _item1 = new AlterationInfo();
            _item1.deserialize(input);
            this.alterations.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlterationsMessage(tree);
      }
      
      public function deserializeAsyncAs_AlterationsMessage(tree:FuncTree) : void
      {
         this._alterationstree = tree.addChild(this._alterationstreeFunc);
      }
      
      private function _alterationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._alterationstree.addChild(this._alterationsFunc);
         }
      }
      
      private function _alterationsFunc(input:ICustomDataInput) : void
      {
         var _item:AlterationInfo = new AlterationInfo();
         _item.deserialize(input);
         this.alterations.push(_item);
      }
   }
}
