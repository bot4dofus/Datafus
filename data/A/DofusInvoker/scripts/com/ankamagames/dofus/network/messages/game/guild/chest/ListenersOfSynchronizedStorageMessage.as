package com.ankamagames.dofus.network.messages.game.guild.chest
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ListenersOfSynchronizedStorageMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8036;
       
      
      private var _isInitialized:Boolean = false;
      
      public var players:Vector.<String>;
      
      private var _playerstree:FuncTree;
      
      public function ListenersOfSynchronizedStorageMessage()
      {
         this.players = new Vector.<String>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8036;
      }
      
      public function initListenersOfSynchronizedStorageMessage(players:Vector.<String> = null) : ListenersOfSynchronizedStorageMessage
      {
         this.players = players;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.players = new Vector.<String>();
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
         this.serializeAs_ListenersOfSynchronizedStorageMessage(output);
      }
      
      public function serializeAs_ListenersOfSynchronizedStorageMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.players.length);
         for(var _i1:uint = 0; _i1 < this.players.length; _i1++)
         {
            output.writeUTF(this.players[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ListenersOfSynchronizedStorageMessage(input);
      }
      
      public function deserializeAs_ListenersOfSynchronizedStorageMessage(input:ICustomDataInput) : void
      {
         var _val1:String = null;
         var _playersLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _playersLen; _i1++)
         {
            _val1 = input.readUTF();
            this.players.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ListenersOfSynchronizedStorageMessage(tree);
      }
      
      public function deserializeAsyncAs_ListenersOfSynchronizedStorageMessage(tree:FuncTree) : void
      {
         this._playerstree = tree.addChild(this._playerstreeFunc);
      }
      
      private function _playerstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._playerstree.addChild(this._playersFunc);
         }
      }
      
      private function _playersFunc(input:ICustomDataInput) : void
      {
         var _val:String = input.readUTF();
         this.players.push(_val);
      }
   }
}
