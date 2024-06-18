package com.ankamagames.dofus.network.messages.game.pvp
{
   import com.ankamagames.dofus.network.types.game.pvp.AgressableStatusMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class UpdateMapPlayersAgressableStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1751;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerAvAMessages:Vector.<AgressableStatusMessage>;
      
      private var _playerAvAMessagestree:FuncTree;
      
      public function UpdateMapPlayersAgressableStatusMessage()
      {
         this.playerAvAMessages = new Vector.<AgressableStatusMessage>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1751;
      }
      
      public function initUpdateMapPlayersAgressableStatusMessage(playerAvAMessages:Vector.<AgressableStatusMessage> = null) : UpdateMapPlayersAgressableStatusMessage
      {
         this.playerAvAMessages = playerAvAMessages;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.playerAvAMessages = new Vector.<AgressableStatusMessage>();
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
         this.serializeAs_UpdateMapPlayersAgressableStatusMessage(output);
      }
      
      public function serializeAs_UpdateMapPlayersAgressableStatusMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.playerAvAMessages.length);
         for(var _i1:uint = 0; _i1 < this.playerAvAMessages.length; _i1++)
         {
            (this.playerAvAMessages[_i1] as AgressableStatusMessage).serializeAs_AgressableStatusMessage(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateMapPlayersAgressableStatusMessage(input);
      }
      
      public function deserializeAs_UpdateMapPlayersAgressableStatusMessage(input:ICustomDataInput) : void
      {
         var _item1:AgressableStatusMessage = null;
         var _playerAvAMessagesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _playerAvAMessagesLen; _i1++)
         {
            _item1 = new AgressableStatusMessage();
            _item1.deserialize(input);
            this.playerAvAMessages.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdateMapPlayersAgressableStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_UpdateMapPlayersAgressableStatusMessage(tree:FuncTree) : void
      {
         this._playerAvAMessagestree = tree.addChild(this._playerAvAMessagestreeFunc);
      }
      
      private function _playerAvAMessagestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._playerAvAMessagestree.addChild(this._playerAvAMessagesFunc);
         }
      }
      
      private function _playerAvAMessagesFunc(input:ICustomDataInput) : void
      {
         var _item:AgressableStatusMessage = new AgressableStatusMessage();
         _item.deserialize(input);
         this.playerAvAMessages.push(_item);
      }
   }
}
