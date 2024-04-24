package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.messages.game.social.BulletinMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceBulletinMessage extends BulletinMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3779;
       
      
      private var _isInitialized:Boolean = false;
      
      public function AllianceBulletinMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3779;
      }
      
      public function initAllianceBulletinMessage(content:String = "", timestamp:uint = 0, memberId:Number = 0, memberName:String = "") : AllianceBulletinMessage
      {
         super.initBulletinMessage(content,timestamp,memberId,memberName);
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
         this.serializeAs_AllianceBulletinMessage(output);
      }
      
      public function serializeAs_AllianceBulletinMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_BulletinMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceBulletinMessage(input);
      }
      
      public function deserializeAs_AllianceBulletinMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceBulletinMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceBulletinMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
