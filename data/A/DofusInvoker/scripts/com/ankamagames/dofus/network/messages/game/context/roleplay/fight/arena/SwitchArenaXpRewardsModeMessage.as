package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SwitchArenaXpRewardsModeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4870;
       
      
      private var _isInitialized:Boolean = false;
      
      public var xpRewards:Boolean = false;
      
      public function SwitchArenaXpRewardsModeMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4870;
      }
      
      public function initSwitchArenaXpRewardsModeMessage(xpRewards:Boolean = false) : SwitchArenaXpRewardsModeMessage
      {
         this.xpRewards = xpRewards;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.xpRewards = false;
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
         this.serializeAs_SwitchArenaXpRewardsModeMessage(output);
      }
      
      public function serializeAs_SwitchArenaXpRewardsModeMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.xpRewards);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SwitchArenaXpRewardsModeMessage(input);
      }
      
      public function deserializeAs_SwitchArenaXpRewardsModeMessage(input:ICustomDataInput) : void
      {
         this._xpRewardsFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SwitchArenaXpRewardsModeMessage(tree);
      }
      
      public function deserializeAsyncAs_SwitchArenaXpRewardsModeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._xpRewardsFunc);
      }
      
      private function _xpRewardsFunc(input:ICustomDataInput) : void
      {
         this.xpRewards = input.readBoolean();
      }
   }
}
