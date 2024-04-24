package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildCharacsUpgradeRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4530;
       
      
      private var _isInitialized:Boolean = false;
      
      public var charaTypeTarget:uint = 0;
      
      public function GuildCharacsUpgradeRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4530;
      }
      
      public function initGuildCharacsUpgradeRequestMessage(charaTypeTarget:uint = 0) : GuildCharacsUpgradeRequestMessage
      {
         this.charaTypeTarget = charaTypeTarget;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.charaTypeTarget = 0;
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
         this.serializeAs_GuildCharacsUpgradeRequestMessage(output);
      }
      
      public function serializeAs_GuildCharacsUpgradeRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.charaTypeTarget);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildCharacsUpgradeRequestMessage(input);
      }
      
      public function deserializeAs_GuildCharacsUpgradeRequestMessage(input:ICustomDataInput) : void
      {
         this._charaTypeTargetFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildCharacsUpgradeRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildCharacsUpgradeRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._charaTypeTargetFunc);
      }
      
      private function _charaTypeTargetFunc(input:ICustomDataInput) : void
      {
         this.charaTypeTarget = input.readByte();
         if(this.charaTypeTarget < 0)
         {
            throw new Error("Forbidden value (" + this.charaTypeTarget + ") on element of GuildCharacsUpgradeRequestMessage.charaTypeTarget.");
         }
      }
   }
}
