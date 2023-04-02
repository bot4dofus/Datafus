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
   
   public class SocialFightLeaveRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4248;
       
      
      private var _isInitialized:Boolean = false;
      
      public var socialFightInfo:SocialFightInfo;
      
      private var _socialFightInfotree:FuncTree;
      
      public function SocialFightLeaveRequestMessage()
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
         return 4248;
      }
      
      public function initSocialFightLeaveRequestMessage(socialFightInfo:SocialFightInfo = null) : SocialFightLeaveRequestMessage
      {
         this.socialFightInfo = socialFightInfo;
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
         this.serializeAs_SocialFightLeaveRequestMessage(output);
      }
      
      public function serializeAs_SocialFightLeaveRequestMessage(output:ICustomDataOutput) : void
      {
         this.socialFightInfo.serializeAs_SocialFightInfo(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SocialFightLeaveRequestMessage(input);
      }
      
      public function deserializeAs_SocialFightLeaveRequestMessage(input:ICustomDataInput) : void
      {
         this.socialFightInfo = new SocialFightInfo();
         this.socialFightInfo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SocialFightLeaveRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_SocialFightLeaveRequestMessage(tree:FuncTree) : void
      {
         this._socialFightInfotree = tree.addChild(this._socialFightInfotreeFunc);
      }
      
      private function _socialFightInfotreeFunc(input:ICustomDataInput) : void
      {
         this.socialFightInfo = new SocialFightInfo();
         this.socialFightInfo.deserializeAsync(this._socialFightInfotree);
      }
   }
}
