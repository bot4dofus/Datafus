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
   
   public class AllianceFightStartedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6842;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceFightInfo:SocialFightInfo;
      
      public var phase:FightPhase;
      
      private var _allianceFightInfotree:FuncTree;
      
      private var _phasetree:FuncTree;
      
      public function AllianceFightStartedMessage()
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.phase = new FightPhase();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6842;
      }
      
      public function initAllianceFightStartedMessage(allianceFightInfo:SocialFightInfo = null, phase:FightPhase = null) : AllianceFightStartedMessage
      {
         this.allianceFightInfo = allianceFightInfo;
         this.phase = phase;
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
         this.serializeAs_AllianceFightStartedMessage(output);
      }
      
      public function serializeAs_AllianceFightStartedMessage(output:ICustomDataOutput) : void
      {
         this.allianceFightInfo.serializeAs_SocialFightInfo(output);
         this.phase.serializeAs_FightPhase(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceFightStartedMessage(input);
      }
      
      public function deserializeAs_AllianceFightStartedMessage(input:ICustomDataInput) : void
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.allianceFightInfo.deserialize(input);
         this.phase = new FightPhase();
         this.phase.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceFightStartedMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceFightStartedMessage(tree:FuncTree) : void
      {
         this._allianceFightInfotree = tree.addChild(this._allianceFightInfotreeFunc);
         this._phasetree = tree.addChild(this._phasetreeFunc);
      }
      
      private function _allianceFightInfotreeFunc(input:ICustomDataInput) : void
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.allianceFightInfo.deserializeAsync(this._allianceFightInfotree);
      }
      
      private function _phasetreeFunc(input:ICustomDataInput) : void
      {
         this.phase = new FightPhase();
         this.phase.deserializeAsync(this._phasetree);
      }
   }
}
