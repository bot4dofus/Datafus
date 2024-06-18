package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightSpellCooldown implements INetworkType
   {
      
      public static const protocolId:uint = 9361;
       
      
      public var spellId:int = 0;
      
      public var cooldown:uint = 0;
      
      public function GameFightSpellCooldown()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9361;
      }
      
      public function initGameFightSpellCooldown(spellId:int = 0, cooldown:uint = 0) : GameFightSpellCooldown
      {
         this.spellId = spellId;
         this.cooldown = cooldown;
         return this;
      }
      
      public function reset() : void
      {
         this.spellId = 0;
         this.cooldown = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightSpellCooldown(output);
      }
      
      public function serializeAs_GameFightSpellCooldown(output:ICustomDataOutput) : void
      {
         output.writeInt(this.spellId);
         if(this.cooldown < 0)
         {
            throw new Error("Forbidden value (" + this.cooldown + ") on element cooldown.");
         }
         output.writeByte(this.cooldown);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightSpellCooldown(input);
      }
      
      public function deserializeAs_GameFightSpellCooldown(input:ICustomDataInput) : void
      {
         this._spellIdFunc(input);
         this._cooldownFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightSpellCooldown(tree);
      }
      
      public function deserializeAsyncAs_GameFightSpellCooldown(tree:FuncTree) : void
      {
         tree.addChild(this._spellIdFunc);
         tree.addChild(this._cooldownFunc);
      }
      
      private function _spellIdFunc(input:ICustomDataInput) : void
      {
         this.spellId = input.readInt();
      }
      
      private function _cooldownFunc(input:ICustomDataInput) : void
      {
         this.cooldown = input.readByte();
         if(this.cooldown < 0)
         {
            throw new Error("Forbidden value (" + this.cooldown + ") on element of GameFightSpellCooldown.cooldown.");
         }
      }
   }
}
