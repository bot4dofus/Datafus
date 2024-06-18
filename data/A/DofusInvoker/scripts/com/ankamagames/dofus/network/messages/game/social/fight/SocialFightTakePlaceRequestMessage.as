package com.ankamagames.dofus.network.messages.game.social.fight
{
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFightInfo;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SocialFightTakePlaceRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7755;
       
      
      private var _isInitialized:Boolean = false;
      
      public var socialFightInfo:SocialFightInfo;
      
      public var replacedCharacterId:Number = 0;
      
      private var _socialFightInfotree:FuncTree;
      
      public function SocialFightTakePlaceRequestMessage()
      {
         this.socialFightInfo = new SocialFightInfo();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7755;
      }
      
      public function initSocialFightTakePlaceRequestMessage(socialFightInfo:SocialFightInfo = null, replacedCharacterId:Number = 0) : SocialFightTakePlaceRequestMessage
      {
         this.socialFightInfo = socialFightInfo;
         this.replacedCharacterId = replacedCharacterId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.socialFightInfo = new SocialFightInfo();
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
         this.serializeAs_SocialFightTakePlaceRequestMessage(output);
      }
      
      public function serializeAs_SocialFightTakePlaceRequestMessage(output:ICustomDataOutput) : void
      {
         this.socialFightInfo.serializeAs_SocialFightInfo(output);
         if(this.replacedCharacterId < 0 || this.replacedCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.replacedCharacterId + ") on element replacedCharacterId.");
         }
         output.writeVarLong(this.replacedCharacterId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SocialFightTakePlaceRequestMessage(input);
      }
      
      public function deserializeAs_SocialFightTakePlaceRequestMessage(input:ICustomDataInput) : void
      {
         this.socialFightInfo = new SocialFightInfo();
         this.socialFightInfo.deserialize(input);
         this._replacedCharacterIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SocialFightTakePlaceRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_SocialFightTakePlaceRequestMessage(tree:FuncTree) : void
      {
         this._socialFightInfotree = tree.addChild(this._socialFightInfotreeFunc);
         tree.addChild(this._replacedCharacterIdFunc);
      }
      
      private function _socialFightInfotreeFunc(input:ICustomDataInput) : void
      {
         this.socialFightInfo = new SocialFightInfo();
         this.socialFightInfo.deserializeAsync(this._socialFightInfotree);
      }
      
      private function _replacedCharacterIdFunc(input:ICustomDataInput) : void
      {
         this.replacedCharacterId = input.readVarUhLong();
         if(this.replacedCharacterId < 0 || this.replacedCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.replacedCharacterId + ") on element of SocialFightTakePlaceRequestMessage.replacedCharacterId.");
         }
      }
   }
}
