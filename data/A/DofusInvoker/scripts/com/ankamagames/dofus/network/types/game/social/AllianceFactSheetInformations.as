package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AllianceFactSheetInformations extends AllianceInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3583;
       
      
      public var creationDate:uint = 0;
      
      public var nbGuilds:uint = 0;
      
      public var nbMembers:uint = 0;
      
      public var nbSubarea:uint = 0;
      
      public function AllianceFactSheetInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3583;
      }
      
      public function initAllianceFactSheetInformations(allianceId:uint = 0, allianceTag:String = "", allianceName:String = "", allianceEmblem:GuildEmblem = null, creationDate:uint = 0, nbGuilds:uint = 0, nbMembers:uint = 0, nbSubarea:uint = 0) : AllianceFactSheetInformations
      {
         super.initAllianceInformations(allianceId,allianceTag,allianceName,allianceEmblem);
         this.creationDate = creationDate;
         this.nbGuilds = nbGuilds;
         this.nbMembers = nbMembers;
         this.nbSubarea = nbSubarea;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.creationDate = 0;
         this.nbGuilds = 0;
         this.nbMembers = 0;
         this.nbSubarea = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceFactSheetInformations(output);
      }
      
      public function serializeAs_AllianceFactSheetInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_AllianceInformations(output);
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
         }
         output.writeInt(this.creationDate);
         if(this.nbGuilds < 0)
         {
            throw new Error("Forbidden value (" + this.nbGuilds + ") on element nbGuilds.");
         }
         output.writeVarShort(this.nbGuilds);
         if(this.nbMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element nbMembers.");
         }
         output.writeVarShort(this.nbMembers);
         if(this.nbSubarea < 0)
         {
            throw new Error("Forbidden value (" + this.nbSubarea + ") on element nbSubarea.");
         }
         output.writeVarShort(this.nbSubarea);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceFactSheetInformations(input);
      }
      
      public function deserializeAs_AllianceFactSheetInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._creationDateFunc(input);
         this._nbGuildsFunc(input);
         this._nbMembersFunc(input);
         this._nbSubareaFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceFactSheetInformations(tree);
      }
      
      public function deserializeAsyncAs_AllianceFactSheetInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._creationDateFunc);
         tree.addChild(this._nbGuildsFunc);
         tree.addChild(this._nbMembersFunc);
         tree.addChild(this._nbSubareaFunc);
      }
      
      private function _creationDateFunc(input:ICustomDataInput) : void
      {
         this.creationDate = input.readInt();
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element of AllianceFactSheetInformations.creationDate.");
         }
      }
      
      private function _nbGuildsFunc(input:ICustomDataInput) : void
      {
         this.nbGuilds = input.readVarUhShort();
         if(this.nbGuilds < 0)
         {
            throw new Error("Forbidden value (" + this.nbGuilds + ") on element of AllianceFactSheetInformations.nbGuilds.");
         }
      }
      
      private function _nbMembersFunc(input:ICustomDataInput) : void
      {
         this.nbMembers = input.readVarUhShort();
         if(this.nbMembers < 0)
         {
            throw new Error("Forbidden value (" + this.nbMembers + ") on element of AllianceFactSheetInformations.nbMembers.");
         }
      }
      
      private function _nbSubareaFunc(input:ICustomDataInput) : void
      {
         this.nbSubarea = input.readVarUhShort();
         if(this.nbSubarea < 0)
         {
            throw new Error("Forbidden value (" + this.nbSubarea + ") on element of AllianceFactSheetInformations.nbSubarea.");
         }
      }
   }
}
