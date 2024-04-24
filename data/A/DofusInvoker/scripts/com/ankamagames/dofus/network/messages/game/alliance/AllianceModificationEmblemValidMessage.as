package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.social.SocialEmblem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceModificationEmblemValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3567;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceEmblem:SocialEmblem;
      
      private var _allianceEmblemtree:FuncTree;
      
      public function AllianceModificationEmblemValidMessage()
      {
         this.allianceEmblem = new SocialEmblem();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3567;
      }
      
      public function initAllianceModificationEmblemValidMessage(allianceEmblem:SocialEmblem = null) : AllianceModificationEmblemValidMessage
      {
         this.allianceEmblem = allianceEmblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceEmblem = new SocialEmblem();
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
         this.serializeAs_AllianceModificationEmblemValidMessage(output);
      }
      
      public function serializeAs_AllianceModificationEmblemValidMessage(output:ICustomDataOutput) : void
      {
         this.allianceEmblem.serializeAs_SocialEmblem(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceModificationEmblemValidMessage(input);
      }
      
      public function deserializeAs_AllianceModificationEmblemValidMessage(input:ICustomDataInput) : void
      {
         this.allianceEmblem = new SocialEmblem();
         this.allianceEmblem.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceModificationEmblemValidMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceModificationEmblemValidMessage(tree:FuncTree) : void
      {
         this._allianceEmblemtree = tree.addChild(this._allianceEmblemtreeFunc);
      }
      
      private function _allianceEmblemtreeFunc(input:ICustomDataInput) : void
      {
         this.allianceEmblem = new SocialEmblem();
         this.allianceEmblem.deserializeAsync(this._allianceEmblemtree);
      }
   }
}
