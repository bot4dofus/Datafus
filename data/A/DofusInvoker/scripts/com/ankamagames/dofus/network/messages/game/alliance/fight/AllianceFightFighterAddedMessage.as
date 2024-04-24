package com.ankamagames.dofus.network.messages.game.alliance.fight
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFightInfo;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceFightFighterAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8723;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceFightInfo:SocialFightInfo;
      
      public var fighter:CharacterMinimalPlusLookInformations;
      
      public var team:uint = 2;
      
      private var _allianceFightInfotree:FuncTree;
      
      private var _fightertree:FuncTree;
      
      public function AllianceFightFighterAddedMessage()
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.fighter = new CharacterMinimalPlusLookInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8723;
      }
      
      public function initAllianceFightFighterAddedMessage(allianceFightInfo:SocialFightInfo = null, fighter:CharacterMinimalPlusLookInformations = null, team:uint = 2) : AllianceFightFighterAddedMessage
      {
         this.allianceFightInfo = allianceFightInfo;
         this.fighter = fighter;
         this.team = team;
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
         this.serializeAs_AllianceFightFighterAddedMessage(output);
      }
      
      public function serializeAs_AllianceFightFighterAddedMessage(output:ICustomDataOutput) : void
      {
         this.allianceFightInfo.serializeAs_SocialFightInfo(output);
         this.fighter.serializeAs_CharacterMinimalPlusLookInformations(output);
         output.writeByte(this.team);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceFightFighterAddedMessage(input);
      }
      
      public function deserializeAs_AllianceFightFighterAddedMessage(input:ICustomDataInput) : void
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.allianceFightInfo.deserialize(input);
         this.fighter = new CharacterMinimalPlusLookInformations();
         this.fighter.deserialize(input);
         this._teamFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceFightFighterAddedMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceFightFighterAddedMessage(tree:FuncTree) : void
      {
         this._allianceFightInfotree = tree.addChild(this._allianceFightInfotreeFunc);
         this._fightertree = tree.addChild(this._fightertreeFunc);
         tree.addChild(this._teamFunc);
      }
      
      private function _allianceFightInfotreeFunc(input:ICustomDataInput) : void
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.allianceFightInfo.deserializeAsync(this._allianceFightInfotree);
      }
      
      private function _fightertreeFunc(input:ICustomDataInput) : void
      {
         this.fighter = new CharacterMinimalPlusLookInformations();
         this.fighter.deserializeAsync(this._fightertree);
      }
      
      private function _teamFunc(input:ICustomDataInput) : void
      {
         this.team = input.readByte();
         if(this.team < 0)
         {
            throw new Error("Forbidden value (" + this.team + ") on element of AllianceFightFighterAddedMessage.team.");
         }
      }
   }
}
