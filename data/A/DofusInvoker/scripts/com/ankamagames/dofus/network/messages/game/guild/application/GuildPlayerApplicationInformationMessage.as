package com.ankamagames.dofus.network.messages.game.guild.application
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.dofus.network.types.game.social.application.SocialApplicationInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildPlayerApplicationInformationMessage extends GuildPlayerApplicationAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 656;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guildInformation:GuildInformations;
      
      public var apply:SocialApplicationInformation;
      
      private var _guildInformationtree:FuncTree;
      
      private var _applytree:FuncTree;
      
      public function GuildPlayerApplicationInformationMessage()
      {
         this.guildInformation = new GuildInformations();
         this.apply = new SocialApplicationInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 656;
      }
      
      public function initGuildPlayerApplicationInformationMessage(guildInformation:GuildInformations = null, apply:SocialApplicationInformation = null) : GuildPlayerApplicationInformationMessage
      {
         this.guildInformation = guildInformation;
         this.apply = apply;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildInformation = new GuildInformations();
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
         this.serializeAs_GuildPlayerApplicationInformationMessage(output);
      }
      
      public function serializeAs_GuildPlayerApplicationInformationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildPlayerApplicationAbstractMessage(output);
         this.guildInformation.serializeAs_GuildInformations(output);
         this.apply.serializeAs_SocialApplicationInformation(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildPlayerApplicationInformationMessage(input);
      }
      
      public function deserializeAs_GuildPlayerApplicationInformationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.guildInformation = new GuildInformations();
         this.guildInformation.deserialize(input);
         this.apply = new SocialApplicationInformation();
         this.apply.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildPlayerApplicationInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildPlayerApplicationInformationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._guildInformationtree = tree.addChild(this._guildInformationtreeFunc);
         this._applytree = tree.addChild(this._applytreeFunc);
      }
      
      private function _guildInformationtreeFunc(input:ICustomDataInput) : void
      {
         this.guildInformation = new GuildInformations();
         this.guildInformation.deserializeAsync(this._guildInformationtree);
      }
      
      private function _applytreeFunc(input:ICustomDataInput) : void
      {
         this.apply = new SocialApplicationInformation();
         this.apply.deserializeAsync(this._applytree);
      }
   }
}
