package com.ankamagames.dofus.network.messages.game.alliance.fight
{
   import com.ankamagames.dofus.network.types.game.context.fight.FightPhase;
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFightInfo;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceFightPhaseUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1193;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceFightInfo:SocialFightInfo;
      
      public var newPhase:FightPhase;
      
      private var _allianceFightInfotree:FuncTree;
      
      private var _newPhasetree:FuncTree;
      
      public function AllianceFightPhaseUpdateMessage()
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.newPhase = new FightPhase();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1193;
      }
      
      public function initAllianceFightPhaseUpdateMessage(allianceFightInfo:SocialFightInfo = null, newPhase:FightPhase = null) : AllianceFightPhaseUpdateMessage
      {
         this.allianceFightInfo = allianceFightInfo;
         this.newPhase = newPhase;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceFightInfo = new SocialFightInfo();
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
         this.serializeAs_AllianceFightPhaseUpdateMessage(output);
      }
      
      public function serializeAs_AllianceFightPhaseUpdateMessage(output:ICustomDataOutput) : void
      {
         this.allianceFightInfo.serializeAs_SocialFightInfo(output);
         this.newPhase.serializeAs_FightPhase(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceFightPhaseUpdateMessage(input);
      }
      
      public function deserializeAs_AllianceFightPhaseUpdateMessage(input:ICustomDataInput) : void
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.allianceFightInfo.deserialize(input);
         this.newPhase = new FightPhase();
         this.newPhase.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceFightPhaseUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceFightPhaseUpdateMessage(tree:FuncTree) : void
      {
         this._allianceFightInfotree = tree.addChild(this._allianceFightInfotreeFunc);
         this._newPhasetree = tree.addChild(this._newPhasetreeFunc);
      }
      
      private function _allianceFightInfotreeFunc(input:ICustomDataInput) : void
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.allianceFightInfo.deserializeAsync(this._allianceFightInfotree);
      }
      
      private function _newPhasetreeFunc(input:ICustomDataInput) : void
      {
         this.newPhase = new FightPhase();
         this.newPhase.deserializeAsync(this._newPhasetree);
      }
   }
}
