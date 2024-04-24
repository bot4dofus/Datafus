package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterExperienceGainMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2271;
       
      
      private var _isInitialized:Boolean = false;
      
      public var experienceCharacter:Number = 0;
      
      public var experienceMount:Number = 0;
      
      public var experienceGuild:Number = 0;
      
      public var experienceIncarnation:Number = 0;
      
      public function CharacterExperienceGainMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2271;
      }
      
      public function initCharacterExperienceGainMessage(experienceCharacter:Number = 0, experienceMount:Number = 0, experienceGuild:Number = 0, experienceIncarnation:Number = 0) : CharacterExperienceGainMessage
      {
         this.experienceCharacter = experienceCharacter;
         this.experienceMount = experienceMount;
         this.experienceGuild = experienceGuild;
         this.experienceIncarnation = experienceIncarnation;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.experienceCharacter = 0;
         this.experienceMount = 0;
         this.experienceGuild = 0;
         this.experienceIncarnation = 0;
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
         this.serializeAs_CharacterExperienceGainMessage(output);
      }
      
      public function serializeAs_CharacterExperienceGainMessage(output:ICustomDataOutput) : void
      {
         if(this.experienceCharacter < 0 || this.experienceCharacter > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceCharacter + ") on element experienceCharacter.");
         }
         output.writeVarLong(this.experienceCharacter);
         if(this.experienceMount < 0 || this.experienceMount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceMount + ") on element experienceMount.");
         }
         output.writeVarLong(this.experienceMount);
         if(this.experienceGuild < 0 || this.experienceGuild > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceGuild + ") on element experienceGuild.");
         }
         output.writeVarLong(this.experienceGuild);
         if(this.experienceIncarnation < 0 || this.experienceIncarnation > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceIncarnation + ") on element experienceIncarnation.");
         }
         output.writeVarLong(this.experienceIncarnation);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterExperienceGainMessage(input);
      }
      
      public function deserializeAs_CharacterExperienceGainMessage(input:ICustomDataInput) : void
      {
         this._experienceCharacterFunc(input);
         this._experienceMountFunc(input);
         this._experienceGuildFunc(input);
         this._experienceIncarnationFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterExperienceGainMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterExperienceGainMessage(tree:FuncTree) : void
      {
         tree.addChild(this._experienceCharacterFunc);
         tree.addChild(this._experienceMountFunc);
         tree.addChild(this._experienceGuildFunc);
         tree.addChild(this._experienceIncarnationFunc);
      }
      
      private function _experienceCharacterFunc(input:ICustomDataInput) : void
      {
         this.experienceCharacter = input.readVarUhLong();
         if(this.experienceCharacter < 0 || this.experienceCharacter > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceCharacter + ") on element of CharacterExperienceGainMessage.experienceCharacter.");
         }
      }
      
      private function _experienceMountFunc(input:ICustomDataInput) : void
      {
         this.experienceMount = input.readVarUhLong();
         if(this.experienceMount < 0 || this.experienceMount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceMount + ") on element of CharacterExperienceGainMessage.experienceMount.");
         }
      }
      
      private function _experienceGuildFunc(input:ICustomDataInput) : void
      {
         this.experienceGuild = input.readVarUhLong();
         if(this.experienceGuild < 0 || this.experienceGuild > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceGuild + ") on element of CharacterExperienceGainMessage.experienceGuild.");
         }
      }
      
      private function _experienceIncarnationFunc(input:ICustomDataInput) : void
      {
         this.experienceIncarnation = input.readVarUhLong();
         if(this.experienceIncarnation < 0 || this.experienceIncarnation > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceIncarnation + ") on element of CharacterExperienceGainMessage.experienceIncarnation.");
         }
      }
   }
}
