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
   
   public class AllianceFightFinishedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1947;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceFightInfo:SocialFightInfo;
      
      private var _allianceFightInfotree:FuncTree;
      
      public function AllianceFightFinishedMessage()
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
         return 1947;
      }
      
      public function initAllianceFightFinishedMessage(allianceFightInfo:SocialFightInfo = null) : AllianceFightFinishedMessage
      {
         this.allianceFightInfo = allianceFightInfo;
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
         this.serializeAs_AllianceFightFinishedMessage(output);
      }
      
      public function serializeAs_AllianceFightFinishedMessage(output:ICustomDataOutput) : void
      {
         this.allianceFightInfo.serializeAs_SocialFightInfo(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceFightFinishedMessage(input);
      }
      
      public function deserializeAs_AllianceFightFinishedMessage(input:ICustomDataInput) : void
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.allianceFightInfo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceFightFinishedMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceFightFinishedMessage(tree:FuncTree) : void
      {
         this._allianceFightInfotree = tree.addChild(this._allianceFightInfotreeFunc);
      }
      
      private function _allianceFightInfotreeFunc(input:ICustomDataInput) : void
      {
         this.allianceFightInfo = new SocialFightInfo();
         this.allianceFightInfo.deserializeAsync(this._allianceFightInfotree);
      }
   }
}
