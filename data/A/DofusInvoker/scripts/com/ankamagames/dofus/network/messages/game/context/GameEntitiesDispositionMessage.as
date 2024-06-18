package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.dofus.network.types.game.context.IdentifiedEntityDispositionInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameEntitiesDispositionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7948;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dispositions:Vector.<IdentifiedEntityDispositionInformations>;
      
      private var _dispositionstree:FuncTree;
      
      public function GameEntitiesDispositionMessage()
      {
         this.dispositions = new Vector.<IdentifiedEntityDispositionInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7948;
      }
      
      public function initGameEntitiesDispositionMessage(dispositions:Vector.<IdentifiedEntityDispositionInformations> = null) : GameEntitiesDispositionMessage
      {
         this.dispositions = dispositions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dispositions = new Vector.<IdentifiedEntityDispositionInformations>();
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
         this.serializeAs_GameEntitiesDispositionMessage(output);
      }
      
      public function serializeAs_GameEntitiesDispositionMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.dispositions.length);
         for(var _i1:uint = 0; _i1 < this.dispositions.length; _i1++)
         {
            (this.dispositions[_i1] as IdentifiedEntityDispositionInformations).serializeAs_IdentifiedEntityDispositionInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameEntitiesDispositionMessage(input);
      }
      
      public function deserializeAs_GameEntitiesDispositionMessage(input:ICustomDataInput) : void
      {
         var _item1:IdentifiedEntityDispositionInformations = null;
         var _dispositionsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _dispositionsLen; _i1++)
         {
            _item1 = new IdentifiedEntityDispositionInformations();
            _item1.deserialize(input);
            this.dispositions.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameEntitiesDispositionMessage(tree);
      }
      
      public function deserializeAsyncAs_GameEntitiesDispositionMessage(tree:FuncTree) : void
      {
         this._dispositionstree = tree.addChild(this._dispositionstreeFunc);
      }
      
      private function _dispositionstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._dispositionstree.addChild(this._dispositionsFunc);
         }
      }
      
      private function _dispositionsFunc(input:ICustomDataInput) : void
      {
         var _item:IdentifiedEntityDispositionInformations = new IdentifiedEntityDispositionInformations();
         _item.deserialize(input);
         this.dispositions.push(_item);
      }
   }
}
