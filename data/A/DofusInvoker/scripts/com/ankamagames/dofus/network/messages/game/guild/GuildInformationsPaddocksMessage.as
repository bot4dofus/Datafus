package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildInformationsPaddocksMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6226;
       
      
      private var _isInitialized:Boolean = false;
      
      public var nbPaddockMax:uint = 0;
      
      public var paddocksInformations:Vector.<PaddockContentInformations>;
      
      private var _paddocksInformationstree:FuncTree;
      
      public function GuildInformationsPaddocksMessage()
      {
         this.paddocksInformations = new Vector.<PaddockContentInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6226;
      }
      
      public function initGuildInformationsPaddocksMessage(nbPaddockMax:uint = 0, paddocksInformations:Vector.<PaddockContentInformations> = null) : GuildInformationsPaddocksMessage
      {
         this.nbPaddockMax = nbPaddockMax;
         this.paddocksInformations = paddocksInformations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.nbPaddockMax = 0;
         this.paddocksInformations = new Vector.<PaddockContentInformations>();
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
         this.serializeAs_GuildInformationsPaddocksMessage(output);
      }
      
      public function serializeAs_GuildInformationsPaddocksMessage(output:ICustomDataOutput) : void
      {
         if(this.nbPaddockMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbPaddockMax + ") on element nbPaddockMax.");
         }
         output.writeByte(this.nbPaddockMax);
         output.writeShort(this.paddocksInformations.length);
         for(var _i2:uint = 0; _i2 < this.paddocksInformations.length; _i2++)
         {
            (this.paddocksInformations[_i2] as PaddockContentInformations).serializeAs_PaddockContentInformations(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInformationsPaddocksMessage(input);
      }
      
      public function deserializeAs_GuildInformationsPaddocksMessage(input:ICustomDataInput) : void
      {
         var _item2:PaddockContentInformations = null;
         this._nbPaddockMaxFunc(input);
         var _paddocksInformationsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _paddocksInformationsLen; _i2++)
         {
            _item2 = new PaddockContentInformations();
            _item2.deserialize(input);
            this.paddocksInformations.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInformationsPaddocksMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildInformationsPaddocksMessage(tree:FuncTree) : void
      {
         tree.addChild(this._nbPaddockMaxFunc);
         this._paddocksInformationstree = tree.addChild(this._paddocksInformationstreeFunc);
      }
      
      private function _nbPaddockMaxFunc(input:ICustomDataInput) : void
      {
         this.nbPaddockMax = input.readByte();
         if(this.nbPaddockMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbPaddockMax + ") on element of GuildInformationsPaddocksMessage.nbPaddockMax.");
         }
      }
      
      private function _paddocksInformationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._paddocksInformationstree.addChild(this._paddocksInformationsFunc);
         }
      }
      
      private function _paddocksInformationsFunc(input:ICustomDataInput) : void
      {
         var _item:PaddockContentInformations = new PaddockContentInformations();
         _item.deserialize(input);
         this.paddocksInformations.push(_item);
      }
   }
}
