package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.guild.Contribution;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildChestTabContributionsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4062;
       
      
      private var _isInitialized:Boolean = false;
      
      public var contributions:Vector.<Contribution>;
      
      private var _contributionstree:FuncTree;
      
      public function GuildChestTabContributionsMessage()
      {
         this.contributions = new Vector.<Contribution>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4062;
      }
      
      public function initGuildChestTabContributionsMessage(contributions:Vector.<Contribution> = null) : GuildChestTabContributionsMessage
      {
         this.contributions = contributions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.contributions = new Vector.<Contribution>();
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
         this.serializeAs_GuildChestTabContributionsMessage(output);
      }
      
      public function serializeAs_GuildChestTabContributionsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.contributions.length);
         for(var _i1:uint = 0; _i1 < this.contributions.length; _i1++)
         {
            (this.contributions[_i1] as Contribution).serializeAs_Contribution(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildChestTabContributionsMessage(input);
      }
      
      public function deserializeAs_GuildChestTabContributionsMessage(input:ICustomDataInput) : void
      {
         var _item1:Contribution = null;
         var _contributionsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _contributionsLen; _i1++)
         {
            _item1 = new Contribution();
            _item1.deserialize(input);
            this.contributions.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildChestTabContributionsMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildChestTabContributionsMessage(tree:FuncTree) : void
      {
         this._contributionstree = tree.addChild(this._contributionstreeFunc);
      }
      
      private function _contributionstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._contributionstree.addChild(this._contributionsFunc);
         }
      }
      
      private function _contributionsFunc(input:ICustomDataInput) : void
      {
         var _item:Contribution = new Contribution();
         _item.deserialize(input);
         this.contributions.push(_item);
      }
   }
}
