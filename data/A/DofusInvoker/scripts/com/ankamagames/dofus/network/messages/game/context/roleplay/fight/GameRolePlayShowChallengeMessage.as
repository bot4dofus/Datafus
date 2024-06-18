package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayShowChallengeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7254;
       
      
      private var _isInitialized:Boolean = false;
      
      public var commonsInfos:FightCommonInformations;
      
      private var _commonsInfostree:FuncTree;
      
      public function GameRolePlayShowChallengeMessage()
      {
         this.commonsInfos = new FightCommonInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7254;
      }
      
      public function initGameRolePlayShowChallengeMessage(commonsInfos:FightCommonInformations = null) : GameRolePlayShowChallengeMessage
      {
         this.commonsInfos = commonsInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.commonsInfos = new FightCommonInformations();
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
         this.serializeAs_GameRolePlayShowChallengeMessage(output);
      }
      
      public function serializeAs_GameRolePlayShowChallengeMessage(output:ICustomDataOutput) : void
      {
         this.commonsInfos.serializeAs_FightCommonInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayShowChallengeMessage(input);
      }
      
      public function deserializeAs_GameRolePlayShowChallengeMessage(input:ICustomDataInput) : void
      {
         this.commonsInfos = new FightCommonInformations();
         this.commonsInfos.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayShowChallengeMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayShowChallengeMessage(tree:FuncTree) : void
      {
         this._commonsInfostree = tree.addChild(this._commonsInfostreeFunc);
      }
      
      private function _commonsInfostreeFunc(input:ICustomDataInput) : void
      {
         this.commonsInfos = new FightCommonInformations();
         this.commonsInfos.deserializeAsync(this._commonsInfostree);
      }
   }
}
