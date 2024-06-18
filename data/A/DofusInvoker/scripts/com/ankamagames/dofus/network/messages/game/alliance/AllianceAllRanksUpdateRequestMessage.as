package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.rank.RankInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceAllRanksUpdateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1620;
       
      
      private var _isInitialized:Boolean = false;
      
      public var ranks:Vector.<RankInformation>;
      
      private var _rankstree:FuncTree;
      
      public function AllianceAllRanksUpdateRequestMessage()
      {
         this.ranks = new Vector.<RankInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1620;
      }
      
      public function initAllianceAllRanksUpdateRequestMessage(ranks:Vector.<RankInformation> = null) : AllianceAllRanksUpdateRequestMessage
      {
         this.ranks = ranks;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.ranks = new Vector.<RankInformation>();
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
         this.serializeAs_AllianceAllRanksUpdateRequestMessage(output);
      }
      
      public function serializeAs_AllianceAllRanksUpdateRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.ranks.length);
         for(var _i1:uint = 0; _i1 < this.ranks.length; _i1++)
         {
            (this.ranks[_i1] as RankInformation).serializeAs_RankInformation(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceAllRanksUpdateRequestMessage(input);
      }
      
      public function deserializeAs_AllianceAllRanksUpdateRequestMessage(input:ICustomDataInput) : void
      {
         var _item1:RankInformation = null;
         var _ranksLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _ranksLen; _i1++)
         {
            _item1 = new RankInformation();
            _item1.deserialize(input);
            this.ranks.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceAllRanksUpdateRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceAllRanksUpdateRequestMessage(tree:FuncTree) : void
      {
         this._rankstree = tree.addChild(this._rankstreeFunc);
      }
      
      private function _rankstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._rankstree.addChild(this._ranksFunc);
         }
      }
      
      private function _ranksFunc(input:ICustomDataInput) : void
      {
         var _item:RankInformation = new RankInformation();
         _item.deserialize(input);
         this.ranks.push(_item);
      }
   }
}
