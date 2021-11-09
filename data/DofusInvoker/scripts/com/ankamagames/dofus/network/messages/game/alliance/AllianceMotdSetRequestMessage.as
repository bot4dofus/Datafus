package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.messages.game.social.SocialNoticeSetRequestMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceMotdSetRequestMessage extends SocialNoticeSetRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5587;
       
      
      private var _isInitialized:Boolean = false;
      
      [Transient]
      public var content:String = "";
      
      public function AllianceMotdSetRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5587;
      }
      
      public function initAllianceMotdSetRequestMessage(content:String = "") : AllianceMotdSetRequestMessage
      {
         this.content = content;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.content = "";
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
         this.serializeAs_AllianceMotdSetRequestMessage(output);
      }
      
      public function serializeAs_AllianceMotdSetRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_SocialNoticeSetRequestMessage(output);
         output.writeUTF(this.content);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceMotdSetRequestMessage(input);
      }
      
      public function deserializeAs_AllianceMotdSetRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._contentFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceMotdSetRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceMotdSetRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._contentFunc);
      }
      
      private function _contentFunc(input:ICustomDataInput) : void
      {
         this.content = input.readUTF();
      }
   }
}
