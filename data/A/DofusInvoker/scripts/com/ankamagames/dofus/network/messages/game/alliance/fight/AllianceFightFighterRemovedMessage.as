package com.ankamagames.dofus.network.messages.game.alliance.fight
{
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFightInfo;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceFightFighterRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4881;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceFightInfo:SocialFightInfo;
      
      public var fighterId:Number = 0;
      
      private var _allianceFightInfotree:FuncTree;
      
      public function AllianceFightFighterRemovedMessage()
      {
         this.allianceFightInfo = new SocialFightInfo();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4881;
      }
      
      public function initAllianceFightFighterRemovedMessage(allianceFightInfo:SocialFightInfo = null, fighterId:Number = 0) : AllianceFightFighterRemovedMessage
      {
         this.allianceFightInfo = allianceFightInfo;
         this.fighterId = fighterId;
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
         this.serializeAs_AllianceFightFighterRemovedMessage(output);
      }
      
      public function serializeAs_AllianceFightFighterRemovedMessage(output:ICustomDataOutput) : void
      {
         this.allianceFightInfo.serializeAs_SocialFightInfo(output);
         if(this.fighterId < 0 || this.fighterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fighterId + ") on element fighterId.");
         }
         output.writeVarLong(this.fighterId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceFightFighterRemovedMessage(input);
      }
      
      public function deserializeAs_AllianceFightFighterRemovedMessage(input:ICustomDataInput) : void
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.allianceFightInfo.deserialize(input);
         this._fighterIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceFightFighterRemovedMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceFightFighterRemovedMessage(tree:FuncTree) : void
      {
         this._allianceFightInfotree = tree.addChild(this._allianceFightInfotreeFunc);
         tree.addChild(this._fighterIdFunc);
      }
      
      private function _allianceFightInfotreeFunc(input:ICustomDataInput) : void
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.allianceFightInfo.deserializeAsync(this._allianceFightInfotree);
      }
      
      private function _fighterIdFunc(input:ICustomDataInput) : void
      {
         this.fighterId = input.readVarUhLong();
         if(this.fighterId < 0 || this.fighterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fighterId + ") on element of AllianceFightFighterRemovedMessage.fighterId.");
         }
      }
   }
}
