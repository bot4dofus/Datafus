package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.npc.MapNpcQuestInfo;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ListMapNpcsQuestStatusUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 233;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mapInfo:Vector.<MapNpcQuestInfo>;
      
      private var _mapInfotree:FuncTree;
      
      public function ListMapNpcsQuestStatusUpdateMessage()
      {
         this.mapInfo = new Vector.<MapNpcQuestInfo>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 233;
      }
      
      public function initListMapNpcsQuestStatusUpdateMessage(mapInfo:Vector.<MapNpcQuestInfo> = null) : ListMapNpcsQuestStatusUpdateMessage
      {
         this.mapInfo = mapInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mapInfo = new Vector.<MapNpcQuestInfo>();
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
         this.serializeAs_ListMapNpcsQuestStatusUpdateMessage(output);
      }
      
      public function serializeAs_ListMapNpcsQuestStatusUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.mapInfo.length);
         for(var _i1:uint = 0; _i1 < this.mapInfo.length; _i1++)
         {
            (this.mapInfo[_i1] as MapNpcQuestInfo).serializeAs_MapNpcQuestInfo(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ListMapNpcsQuestStatusUpdateMessage(input);
      }
      
      public function deserializeAs_ListMapNpcsQuestStatusUpdateMessage(input:ICustomDataInput) : void
      {
         var _item1:MapNpcQuestInfo = null;
         var _mapInfoLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _mapInfoLen; _i1++)
         {
            _item1 = new MapNpcQuestInfo();
            _item1.deserialize(input);
            this.mapInfo.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ListMapNpcsQuestStatusUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_ListMapNpcsQuestStatusUpdateMessage(tree:FuncTree) : void
      {
         this._mapInfotree = tree.addChild(this._mapInfotreeFunc);
      }
      
      private function _mapInfotreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._mapInfotree.addChild(this._mapInfoFunc);
         }
      }
      
      private function _mapInfoFunc(input:ICustomDataInput) : void
      {
         var _item:MapNpcQuestInfo = new MapNpcQuestInfo();
         _item.deserialize(input);
         this.mapInfo.push(_item);
      }
   }
}
