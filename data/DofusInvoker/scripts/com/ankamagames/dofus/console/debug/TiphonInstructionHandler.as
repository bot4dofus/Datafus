package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.network.messages.authorized.AdminQuietCommandMessage;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.Dictionary;
   
   public class TiphonInstructionHandler implements ConsoleInstructionHandler
   {
      
      private static var _monsters:Dictionary;
      
      private static var _monsterNameList:Array;
       
      
      public function TiphonInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var monsterName:String = null;
         var searchBonesId:uint = 0;
         var look:TiphonEntityLook = null;
         var aqcmsg:AdminQuietCommandMessage = null;
         var entity:IEntity = null;
         switch(cmd)
         {
            case "additem":
               if(args.length != 1)
               {
                  console.output("need 1 parameter (item ID)");
                  return;
               }
               (DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as TiphonSprite).look.addSkin(parseInt(args[0]));
               break;
            case "looklike":
               if(!_monsters)
               {
                  this.parseMonster();
               }
               monsterName = args.join(" ").toLowerCase().split(" {npc}").join("").split(" {monster}").join("");
               if(_monsters[monsterName])
               {
                  console.output("look like " + _monsters[monsterName]);
                  aqcmsg = new AdminQuietCommandMessage();
                  aqcmsg.initAdminQuietCommandMessage("look * " + _monsters[monsterName]);
                  if(PlayerManager.getInstance().hasRights)
                  {
                     ConnectionsHandler.getConnection().send(aqcmsg);
                  }
               }
               break;
            case "relook":
               if(args.length != 2)
               {
                  console.output("need 2 parameters : target bones ID and new look");
               }
               searchBonesId = parseInt(args[0]);
               look = TiphonEntityLook.fromString(args[1]);
               for each(entity in EntitiesManager.getInstance().entities)
               {
                  if(entity is TiphonSprite && TiphonSprite(entity).look.getBone() == searchBonesId)
                  {
                     TiphonSprite(entity).look.updateFrom(look);
                  }
               }
               break;
            case "castshadow":
               OptionManager.getOptionManager("dofus").setOption("shadowCharacter",!OptionManager.getOptionManager("dofus").getOption("shadowCharacter"));
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "looklike":
               return "look a npc or monster, param is monser\'s or pnc\'s name, you can use autocompletion";
            case "relook":
               return "Change the look of all entities currently displayed that have a specific boneId";
            default:
               return null;
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         var searchTerm:String = null;
         var name:String = null;
         var entity:IEntity = null;
         var result:Array = [];
         switch(cmd)
         {
            case "looklike":
               if(!_monsters)
               {
                  this.parseMonster();
               }
               searchTerm = currentParams.join(" ").toLowerCase();
               for each(name in _monsterNameList)
               {
                  if(name.indexOf(searchTerm) != -1)
                  {
                     result.push(name);
                  }
               }
               break;
            case "relook":
               for each(entity in EntitiesManager.getInstance().entities)
               {
                  if(entity is TiphonSprite && result.indexOf(TiphonSprite(entity).look.getBone()) == -1)
                  {
                     result.push(TiphonSprite(entity).look.getBone());
                  }
               }
         }
         return result;
      }
      
      private function parseMonster() : void
      {
         var monster:Monster = null;
         var npc:Npc = null;
         _monsters = new Dictionary();
         _monsterNameList = [];
         var monsters:Array = Monster.getMonsters();
         for each(monster in monsters)
         {
            _monsterNameList.push(monster.name.toLowerCase() + " {monster}");
            _monsters[monster.name.toLowerCase()] = monster.look;
         }
         monsters = Npc.getNpcs();
         for each(npc in monsters)
         {
            _monsterNameList.push(npc.name.toLowerCase() + " {npc}");
            _monsters[npc.name.toLowerCase()] = npc.look;
         }
      }
   }
}
