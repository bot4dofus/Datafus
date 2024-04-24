package com.ankamagames.dofus.network.messages.game.guild.application
{
   import com.ankamagames.dofus.network.messages.game.PaginationAnswerAbstractMessage;
   import com.ankamagames.dofus.network.types.game.social.application.SocialApplicationInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildListApplicationAnswerMessage extends PaginationAnswerAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1671;
       
      
      private var _isInitialized:Boolean = false;
      
      public var applies:Vector.<SocialApplicationInformation>;
      
      private var _appliestree:FuncTree;
      
      public function GuildListApplicationAnswerMessage()
      {
         this.applies = new Vector.<SocialApplicationInformation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1671;
      }
      
      public function initGuildListApplicationAnswerMessage(offset:Number = 0, count:uint = 0, total:uint = 0, applies:Vector.<SocialApplicationInformation> = null) : GuildListApplicationAnswerMessage
      {
         super.initPaginationAnswerAbstractMessage(offset,count,total);
         this.applies = applies;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.applies = new Vector.<SocialApplicationInformation>();
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
         this.serializeAs_GuildListApplicationAnswerMessage(output);
      }
      
      public function serializeAs_GuildListApplicationAnswerMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PaginationAnswerAbstractMessage(output);
         output.writeShort(this.applies.length);
         for(var _i1:uint = 0; _i1 < this.applies.length; _i1++)
         {
            (this.applies[_i1] as SocialApplicationInformation).serializeAs_SocialApplicationInformation(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildListApplicationAnswerMessage(input);
      }
      
      public function deserializeAs_GuildListApplicationAnswerMessage(input:ICustomDataInput) : void
      {
         var _item1:SocialApplicationInformation = null;
         super.deserialize(input);
         var _appliesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _appliesLen; _i1++)
         {
            _item1 = new SocialApplicationInformation();
            _item1.deserialize(input);
            this.applies.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildListApplicationAnswerMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildListApplicationAnswerMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._appliestree = tree.addChild(this._appliestreeFunc);
      }
      
      private function _appliestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._appliestree.addChild(this._appliesFunc);
         }
      }
      
      private function _appliesFunc(input:ICustomDataInput) : void
      {
         var _item:SocialApplicationInformation = new SocialApplicationInformation();
         _item.deserialize(input);
         this.applies.push(_item);
      }
   }
}
