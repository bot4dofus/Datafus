package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.messages.game.social.SocialNoticeMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceMotdMessage extends SocialNoticeMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9589;
       
      
      private var _isInitialized:Boolean = false;
      
      public function AllianceMotdMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9589;
      }
      
      public function initAllianceMotdMessage(content:String = "", timestamp:uint = 0, memberId:Number = 0, memberName:String = "") : AllianceMotdMessage
      {
         super.initSocialNoticeMessage(content,timestamp,memberId,memberName);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceMotdMessage(output);
      }
      
      public function serializeAs_AllianceMotdMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_SocialNoticeMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceMotdMessage(input);
      }
      
      public function deserializeAs_AllianceMotdMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceMotdMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceMotdMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
