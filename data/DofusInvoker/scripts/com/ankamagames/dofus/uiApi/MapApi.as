package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.datacenter.world.Dungeon;
   import com.ankamagames.dofus.datacenter.world.Hint;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.MapReference;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.SuperArea;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.CharacterDisplacementManager;
   import com.ankamagames.dofus.logic.game.common.managers.FlagManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.modules.utils.pathfinding.world.Edge;
   import com.ankamagames.dofus.modules.utils.pathfinding.world.WorldPathFinder;
   import com.ankamagames.dofus.types.entities.SearchResult;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class MapApi implements IApi
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapApi));
      
      public static var DEBUG_WORLD_GRAPH_SHORTCUTS:Boolean = false;
      
      private static const HINT_SEARCH_TYPE:uint = 1;
      
      private static const SUBAREA_SEARCH_TYPE:uint = 2;
      
      private static const MONSTER_SEARCH_TYPE:uint = 3;
      
      private static const ITEM_SEARCH_TYPE:uint = 4;
      
      private static const HINT_GROUP_SEARCH_TYPE:uint = 5;
       
      
      private const SEARCH_OPENING_TAG:String = "<b>";
      
      private const SEARCH_CLOSING_TAG:String = "</b>";
      
      private var _currentUi:UiRootContainer;
      
      private var _lastMapTotalRewardRate:int = 0;
      
      private var _searchResult:SearchResult;
      
      private var _hasResultsInOtherWorldMap:Boolean;
      
      private var _searchHints:Dictionary;
      
      private var _search:String;
      
      private var _currentCartographyWorldmapId:uint;
      
      public function MapApi()
      {
         this._searchResult = new SearchResult();
         this._searchHints = new Dictionary(true);
         super();
      }
      
      [ApiData(name="currentUi")]
      public function set currentUi(value:UiRootContainer) : void
      {
         if(!this._currentUi)
         {
            this._currentUi = value;
         }
      }
      
      public function destroy() : void
      {
         this._currentUi = null;
      }
      
      public function getCurrentSubArea() : SubArea
      {
         var frame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(frame)
         {
            return SubArea.getSubAreaById(frame.currentSubAreaId);
         }
         return null;
      }
      
      public function getCurrentWorldMap() : WorldMap
      {
         if(PlayedCharacterManager.getInstance().currentWorldMap)
         {
            return PlayedCharacterManager.getInstance().currentWorldMap;
         }
         return null;
      }
      
      public function getAllSuperArea() : Array
      {
         return SuperArea.getAllSuperArea();
      }
      
      public function getAllArea() : Array
      {
         return Area.getAllArea();
      }
      
      public function getAllSubArea() : Array
      {
         return SubArea.getAllSubArea();
      }
      
      public function getSubArea(subAreaId:uint) : SubArea
      {
         return SubArea.getSubAreaById(subAreaId);
      }
      
      public function getSubAreaMapIds(subAreaId:uint) : Vector.<Number>
      {
         return SubArea.getSubAreaById(subAreaId).mapIds;
      }
      
      public function getSubAreaCenter(subAreaId:uint) : Point
      {
         return SubArea.getSubAreaById(subAreaId).center;
      }
      
      public function getWorldPoint(mapId:Number) : WorldPoint
      {
         return WorldPoint.fromMapId(mapId);
      }
      
      public function getMapCoords(mapId:Number) : Point
      {
         var mapPosition:MapPosition = MapPosition.getMapPositionById(mapId);
         return new Point(mapPosition.posX,mapPosition.posY);
      }
      
      public function getMapTotalRewardRate() : int
      {
         var ref:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(ref != null)
         {
            this._lastMapTotalRewardRate = ref.mapTotalRewardRate;
         }
         return this._lastMapTotalRewardRate;
      }
      
      public function getSubAreaShape(subAreaId:uint) : Vector.<int>
      {
         var subArea:SubArea = SubArea.getSubAreaById(subAreaId);
         if(subArea)
         {
            return subArea.shape;
         }
         return null;
      }
      
      public function getMapShape(pX:int, pY:int) : Vector.<int>
      {
         var coordList:Vector.<int> = new Vector.<int>();
         coordList.push(11000 + pX,11000 + pY,pX,pY,pX + 1,pY,pX + 1,pY + 1,pX,pY + 1,pX,pY);
         return coordList;
      }
      
      public function getHints() : Array
      {
         return Hint.getHints();
      }
      
      public function getShortcuts(worldMap:int) : Array
      {
         var fromUID:* = null;
         var destEdges:Dictionary = null;
         var destUID:* = null;
         var currentEdge:Edge = null;
         var oldFromUID:String = null;
         var to:MapPosition = null;
         var from:MapPosition = null;
         var manhattanDistance:int = 0;
         var result:Array = [];
         var fromEdges:Dictionary = WorldPathFinder.getWorldGraph().getEdges();
         for(fromUID in fromEdges)
         {
            destEdges = fromEdges[fromUID];
            for(destUID in destEdges)
            {
               currentEdge = destEdges[destUID] as Edge;
               oldFromUID = "";
               to = this.getMapPositionById(currentEdge.to.mapId);
               if(fromUID != oldFromUID)
               {
                  from = this.getMapPositionById(currentEdge.from.mapId);
                  oldFromUID = fromUID;
               }
               if(from != null && to != null && from.worldMap == worldMap && to.worldMap == worldMap)
               {
                  manhattanDistance = Math.abs(from.posX - to.posX) + Math.abs(from.posY - to.posY);
                  if(manhattanDistance > 1)
                  {
                     result.push({
                        "from":from,
                        "to":to,
                        "fromRp":currentEdge.from.zoneId,
                        "toRp":currentEdge.to.zoneId,
                        "transitionText":currentEdge.transitions.length + "/" + currentEdge.transitions[0].toString()
                     });
                  }
               }
            }
         }
         return result;
      }
      
      public function subAreaByMapId(mapId:Number) : SubArea
      {
         return SubArea.getSubAreaByMapId(mapId);
      }
      
      public function getMapIdByCoord(x:int, y:int) : Vector.<Number>
      {
         return MapPosition.getMapIdByCoord(x,y);
      }
      
      public function getMapPositionById(mapId:Number) : MapPosition
      {
         return MapPosition.getMapPositionById(mapId);
      }
      
      public function intersects(rect1:Object, rect2:Object) : Boolean
      {
         if(!rect1 || !rect2)
         {
            return false;
         }
         var r1:Rectangle = Rectangle(rect1);
         var r2:Rectangle = Rectangle(rect2);
         if(r1 && r2)
         {
            return r1.intersects(r2);
         }
         return false;
      }
      
      public function autoTravel(x:int, y:int, worldId:int = -1) : void
      {
         CharacterDisplacementManager.getInstance().autoTravel(x,y,worldId);
      }
      
      public function movePlayer(x:int, y:int, world:int = -1) : void
      {
         CharacterDisplacementManager.getInstance().movePlayer(x,y,world);
      }
      
      public function movePlayerOnMapId(mapId:Number) : void
      {
         CharacterDisplacementManager.getInstance().movePlayerOnMapId(mapId);
      }
      
      public function getMapReference(refId:uint) : MapReference
      {
         return MapReference.getMapReferenceById(refId);
      }
      
      public function getPhoenixsMaps() : Array
      {
         return FlagManager.getInstance().phoenixs;
      }
      
      public function isInIncarnam() : Boolean
      {
         return this.getCurrentSubArea().areaId == DataEnum.AREA_INCARNAM;
      }
      
      public function setCurrentCartographyWorldmapId(value:uint) : void
      {
         this._currentCartographyWorldmapId = value;
      }
      
      public function getSearchAllResults(pSearch:String) : Object
      {
         var resultsTmp:Array = null;
         var id:* = undefined;
         var search:String = null;
         var result:* = undefined;
         if(!DataApi.isStaticCartographyInit)
         {
            this._currentUi.uiClass.dataApi.initStaticCartographyData();
         }
         var results:Array = [];
         var resultsAll:Array = [];
         for(id in this._searchHints)
         {
            delete this._searchHints[id];
         }
         this._hasResultsInOtherWorldMap = false;
         this._search = pSearch;
         search = StringUtils.noAccent(pSearch).toLowerCase();
         resultsTmp = this.getResults(Hint,HINT_SEARCH_TYPE,search);
         resultsAll.push({
            "content":resultsTmp,
            "minLevenshteinDist":this.minProp("levenshteinDist",resultsTmp) / resultsTmp.length
         });
         resultsTmp = this.getResults(SubArea,SUBAREA_SEARCH_TYPE,search);
         resultsAll.push({
            "content":resultsTmp,
            "minLevenshteinDist":this.minProp("levenshteinDist",resultsTmp) / resultsTmp.length
         });
         resultsTmp = this.getResults(Monster,MONSTER_SEARCH_TYPE,search);
         resultsAll.push({
            "content":resultsTmp,
            "minLevenshteinDist":this.minProp("levenshteinDist",resultsTmp) / resultsTmp.length
         });
         resultsTmp = this.getResults(Item,ITEM_SEARCH_TYPE,search);
         resultsAll.push({
            "content":resultsTmp,
            "minLevenshteinDist":this.minProp("levenshteinDist",resultsTmp) / resultsTmp.length
         });
         resultsAll = resultsAll.sortOn("minLevenshteinDist",Array.NUMERIC);
         for each(result in resultsAll)
         {
            results = results.concat(result.content);
         }
         return {
            "results":results,
            "hasResultsInOtherWorldMap":this._hasResultsInOtherWorldMap,
            "searchHints":this._searchHints
         };
      }
      
      private function getResults(pClass:Class, pType:uint, pSearch:String) : Array
      {
         var result:Object = null;
         var id:int = 0;
         var results:Array = [];
         var ids:Vector.<int> = this.queryString(pClass,"undiatricalName",pSearch);
         for each(id in ids)
         {
            result = this.getSearchResultEntry(id,pType,pSearch);
            if(result)
            {
               result.levenshteinDist = this.levenshtein(result.data.undiatricalName,pSearch);
               results.push(result);
            }
         }
         return results.sortOn("levenshteinDist",Array.NUMERIC);
      }
      
      private function minProp(prop:String, arr:Array) : int
      {
         var element:* = undefined;
         var min:int = -1;
         for each(element in arr)
         {
            if(min == -1 || element[prop] < min)
            {
               min = element[prop];
            }
         }
         return min;
      }
      
      private function levenshtein(string1:String, string2:String) : int
      {
         var dist:int = 0;
         var i:int = 0;
         var j:int = 0;
         if(!string1)
         {
            return string2.length;
         }
         var matrix:Array = [];
         for(i = 0; i <= string1.length; i++)
         {
            matrix[i] = [];
            for(j = 0; j <= string2.length; j++)
            {
               if(i != 0)
               {
                  matrix[i].push(0);
               }
               else
               {
                  matrix[i].push(j);
               }
            }
            matrix[i][0] = i;
         }
         for(i = 1; i <= string1.length; i++)
         {
            for(j = 1; j <= string2.length; j++)
            {
               if(string1.charAt(i - 1) == string2.charAt(j - 1))
               {
                  dist = 0;
               }
               else
               {
                  dist = 1;
               }
               matrix[i][j] = Math.min(matrix[i - 1][j] + 1,matrix[i][j - 1] + 1,matrix[i - 1][j - 1] + dist);
            }
         }
         return matrix[string1.length][string2.length];
      }
      
      private function queryString(dataClass:Class, field:String, pattern:String) : Vector.<int>
      {
         var elements:Dictionary = null;
         var element:* = undefined;
         var nb:int = 0;
         var blacklist:Array = null;
         var toTest:Array = null;
         var wordMatch:String = null;
         var wordTest:String = null;
         var ids:Vector.<int> = new Vector.<int>();
         switch(dataClass)
         {
            case Hint:
               elements = DataApi.allHints;
               break;
            case SubArea:
               elements = DataApi.allSubAreas;
               break;
            case Monster:
               elements = DataApi.allMonsters;
               break;
            case Item:
               elements = DataApi.allItems;
         }
         var toMatch:Array = StringUtils.noAccent(pattern).toLowerCase().split(" ");
         for each(element in elements)
         {
            nb = 0;
            blacklist = [];
            toTest = element[field].split(" ");
            if(toMatch.length <= toTest.length)
            {
               for each(wordMatch in toMatch)
               {
                  for each(wordTest in toTest)
                  {
                     if(blacklist.indexOf(wordMatch) == -1 && wordTest.indexOf(wordMatch) != -1)
                     {
                        nb++;
                        blacklist.push(wordMatch);
                     }
                  }
               }
               if(nb >= toMatch.length)
               {
                  if(dataClass is Item && (element.dropMonsterIds.length > 0 || element.resourcesBySubarea.length > 0))
                  {
                     ids.push(element.id);
                  }
                  else if(!(dataClass is Item))
                  {
                     ids.push(element.id);
                  }
               }
            }
         }
         return ids;
      }
      
      private function getSearchResultEntry(pId:int, pType:uint, pSearch:String) : Object
      {
         var entry:Object = null;
         var searchResult:SearchResult = null;
         var i:int = 0;
         var strNoAccent:String = null;
         var hint:Hint = null;
         var subArea:SubArea = null;
         var monster:Monster = null;
         var monsterSubAreasIds:Vector.<int> = null;
         var item:Item = null;
         var subAreasIds:Vector.<int> = null;
         var resourceSubAreaIds:Vector.<int> = null;
         var beforeSearchString:String = null;
         var searchString:String = null;
         var afterSearchString:String = null;
         var hintName:String = null;
         var parent:Hint = null;
         var moreInfo:* = "";
         switch(pType)
         {
            case HINT_SEARCH_TYPE:
               hint = DataApi.allHints[pId];
               if(!hint)
               {
                  return null;
               }
               if(hint.worldMapId != this._currentCartographyWorldmapId)
               {
                  this._hasResultsInOtherWorldMap = true;
                  return null;
               }
               entry = {};
               entry.data = hint;
               if(hint.categoryId == 6)
               {
                  entry.uri = this._currentUi.getConstant("texture") + "windowIcon/icon__0022_Groupe.png";
               }
               else
               {
                  entry.uri = this._currentUi.getConstant("hintIcons") + hint.gfx + ".png";
               }
               break;
            case SUBAREA_SEARCH_TYPE:
               subArea = DataApi.allSubAreas[pId];
               if(DataApi.dungeonsBySubArea[subArea.id] || !this.isValidSubArea(subArea))
               {
                  return null;
               }
               if(subArea.worldmap.id != this._currentCartographyWorldmapId)
               {
                  this._hasResultsInOtherWorldMap = true;
                  return null;
               }
               entry = {};
               entry.data = subArea;
               entry.uri = this._currentUi.getConstant("texture") + "windowIcon/icon__0025_Geoposition.png";
               moreInfo = " (" + subArea.area.name + ")";
               break;
            case MONSTER_SEARCH_TYPE:
               monster = DataApi.allMonsters[pId];
               searchResult = this.getMonsterValidSubAreas(monster);
               monsterSubAreasIds = searchResult.resultData;
               if(searchResult.resultCode == SearchResult.VALID_PARTIAL)
               {
                  this._hasResultsInOtherWorldMap = true;
               }
               if(!monsterSubAreasIds)
               {
                  return null;
               }
               entry = {};
               entry.data = monster;
               entry.subAreasIds = monsterSubAreasIds;
               entry.uri = this._currentUi.getConstant("texture") + "windowIcon/icon__0020_Bestiaire.png";
               break;
            case ITEM_SEARCH_TYPE:
               item = DataApi.allItems[pId];
               if(!item)
               {
                  return null;
               }
               if(item.dropMonsterIds.length > 0)
               {
                  searchResult = this.getItemValidSubAreas(item);
                  subAreasIds = searchResult.resultData;
                  if(searchResult.resultCode == SearchResult.VALID_PARTIAL)
                  {
                     this._hasResultsInOtherWorldMap = true;
                  }
               }
               if(item.resourcesBySubarea.length > 0)
               {
                  searchResult = this.getResourceItemValidSubAreaIds(item);
                  resourceSubAreaIds = searchResult.resultData;
                  if(searchResult.resultCode == SearchResult.VALID_PARTIAL)
                  {
                     this._hasResultsInOtherWorldMap = true;
                  }
               }
               if(!subAreasIds && !resourceSubAreaIds)
               {
                  return null;
               }
               entry = {};
               entry.data = item;
               entry.subAreasIds = subAreasIds;
               entry.resourceSubAreaIds = resourceSubAreaIds;
               entry.uri = this._currentUi.getConstant("texture") + "windowIcon/icon__0027_Inventaire.png";
               if(item.category == ItemCategoryEnum.QUEST_CATEGORY)
               {
                  entry.typeUri = this._currentUi.getConstant("texture") + "success/success_cat_6.png";
               }
               else if(resourceSubAreaIds)
               {
                  entry.typeUri = this._currentUi.getConstant("texture") + "success/success_cat_5.png";
               }
               break;
         }
         entry.type = pType;
         entry.name = entry.data.name;
         var label:String = entry.name;
         var labelTmp:String = label.toLowerCase();
         var searchLen:int = pSearch.length;
         var nextIndex:int = 0;
         for(i = 0; i < label.length; i++)
         {
            strNoAccent = StringUtils.noAccent(labelTmp.substring(i,i + searchLen));
            if(strNoAccent == pSearch)
            {
               nextIndex = i + searchLen;
               beforeSearchString = label.substring(0,i);
               searchString = this.SEARCH_OPENING_TAG + label.substring(i,nextIndex) + this.SEARCH_CLOSING_TAG;
               afterSearchString = label.substring(nextIndex);
               i += beforeSearchString.length + searchString.length - 1;
               label = beforeSearchString + searchString + afterSearchString;
               labelTmp = label.toLowerCase();
            }
         }
         entry.label = label + moreInfo;
         if(entry.type == HINT_SEARCH_TYPE)
         {
            hintName = StringUtils.noAccent(labelTmp);
            if(this._searchHints[hintName])
            {
               if(this._searchHints[hintName].data is Hint)
               {
                  this._searchHints[hintName].type = HINT_GROUP_SEARCH_TYPE;
                  parent = this._searchHints[hintName].data;
                  this._searchHints[hintName].data = [];
                  this._searchHints[hintName].data.push(parent);
               }
               this._searchHints[hintName].data.push(entry.data);
               return null;
            }
            this._searchHints[hintName] = entry;
         }
         return entry;
      }
      
      private function isValidSubArea(pSubArea:SubArea) : Boolean
      {
         return DataApi.dungeonsBySubArea[pSubArea.id] || DataApi.hintsBySubArea[pSubArea.id] || pSubArea.displayOnWorldMap && pSubArea.shape.length > 0;
      }
      
      private function getMonsterValidSubAreas(pMonster:Monster) : SearchResult
      {
         var subAreasIds:Vector.<int> = null;
         var subArea:SubArea = null;
         var subAreaId:uint = 0;
         var resultCode:int = SearchResult.VALID_ALL;
         if(pMonster.subareas.length > 0)
         {
            for each(subAreaId in pMonster.subareas)
            {
               subArea = DataApi.allSubAreas[subAreaId];
               if(this.isValidSubArea(subArea))
               {
                  if(subArea.worldmap.id == this._currentCartographyWorldmapId)
                  {
                     if(!subAreasIds)
                     {
                        subAreasIds = new Vector.<int>(0);
                     }
                     subAreasIds.push(subArea.id);
                  }
                  else
                  {
                     resultCode = SearchResult.VALID_PARTIAL;
                  }
               }
            }
         }
         this._searchResult.resultData = subAreasIds;
         this._searchResult.resultCode = !subAreasIds && resultCode != SearchResult.VALID_PARTIAL ? int(SearchResult.VALID_NONE) : int(resultCode);
         return this._searchResult;
      }
      
      private function getItemValidSubAreas(pItem:Item) : SearchResult
      {
         var subAreasIds:Vector.<int> = null;
         var monster:Monster = null;
         var monsterId:uint = 0;
         var monsterSubAreas:Vector.<int> = null;
         var monsterSubAreasResult:SearchResult = null;
         var resultCode:int = SearchResult.VALID_ALL;
         for each(monsterId in pItem.dropMonsterIds)
         {
            monster = DataApi.allMonsters[monsterId];
            monsterSubAreasResult = this.getMonsterValidSubAreas(monster);
            monsterSubAreas = monsterSubAreasResult.resultData;
            if(monsterSubAreas)
            {
               if(!subAreasIds)
               {
                  subAreasIds = new Vector.<int>(0);
               }
               if(subAreasIds.indexOf(monsterId) == -1)
               {
                  subAreasIds.push(monsterId);
                  subAreasIds.push(monsterSubAreas.length);
                  subAreasIds = subAreasIds.concat(monsterSubAreas);
               }
            }
            if(monsterSubAreasResult.resultCode == SearchResult.VALID_PARTIAL)
            {
               resultCode = SearchResult.VALID_PARTIAL;
            }
         }
         this._searchResult.resultData = subAreasIds;
         this._searchResult.resultCode = !subAreasIds && resultCode != SearchResult.VALID_PARTIAL ? int(SearchResult.VALID_NONE) : int(resultCode);
         return this._searchResult;
      }
      
      private function getResourceItemValidSubAreaIds(pItem:Item) : SearchResult
      {
         var subAreasIds:Vector.<int> = null;
         var resourceBySubarea:Vector.<int> = null;
         var subArea:SubArea = null;
         var resultCode:int = SearchResult.VALID_ALL;
         for each(resourceBySubarea in pItem.resourcesBySubarea)
         {
            subArea = DataApi.allSubAreas[resourceBySubarea[0]];
            if(this.isValidSubArea(subArea))
            {
               if(subArea.worldmap.id == this._currentCartographyWorldmapId)
               {
                  if(!subAreasIds)
                  {
                     subAreasIds = new Vector.<int>(0);
                  }
                  subAreasIds.push(resourceBySubarea[0]);
                  subAreasIds.push(resourceBySubarea[1]);
               }
               else
               {
                  resultCode = SearchResult.VALID_PARTIAL;
               }
            }
         }
         this._searchResult.resultData = subAreasIds;
         this._searchResult.resultCode = !subAreasIds && resultCode != SearchResult.VALID_PARTIAL ? int(SearchResult.VALID_NONE) : int(resultCode);
         return this._searchResult;
      }
      
      public function isDungeonSubArea(pSubAreaId:int) : int
      {
         var mapPos:MapPosition = null;
         var dungeon:Dungeon = null;
         var dungeonPos:MapPosition = null;
         var dungeonIds:Vector.<uint> = null;
         var mapId:Number = NaN;
         var count:int = 0;
         var subArea:SubArea = SubArea.getSubAreaById(pSubAreaId);
         var dungeons:Array = Dungeon.getAllDungeons();
         dungeonIds = GameDataQuery.queryEquals(Dungeon,"mapIds",subArea.mapIds);
         if(dungeonIds.length > 0)
         {
            dungeon = Dungeon.getDungeonById(dungeonIds[0]);
            if(dungeon.mapIds.length == subArea.mapIds.length)
            {
               return dungeonIds[0];
            }
            dungeons = [dungeon];
         }
         for each(dungeon in dungeons)
         {
            count = 0;
            if(dungeon.mapIds.length > subArea.mapIds.length)
            {
               for each(mapId in subArea.mapIds)
               {
                  if(dungeon.mapIds.indexOf(mapId) != -1)
                  {
                     count++;
                  }
               }
               if(count == subArea.mapIds.length)
               {
                  return dungeon.id;
               }
            }
            else
            {
               for each(mapId in dungeon.mapIds)
               {
                  if(subArea.mapIds.indexOf(mapId) != -1)
                  {
                     count++;
                  }
               }
               if(count == dungeon.mapIds.length)
               {
                  return dungeon.id;
               }
            }
            dungeonPos = MapPosition.getMapPositionById(dungeon.entranceMapId);
            if(dungeonPos)
            {
               for each(mapId in subArea.mapIds)
               {
                  mapPos = MapPosition.getMapPositionById(mapId);
                  if(mapPos && (mapPos.posX != dungeonPos.posX || mapPos.posY != dungeonPos.posY))
                  {
                     return -1;
                  }
               }
               return dungeon.id;
            }
         }
         return -1;
      }
      
      public function hasPublicPaddock(mapId:int) : Boolean
      {
         var mp:MapPosition = this.getMapPositionById(mapId);
         return mp.hasPublicPaddock;
      }
   }
}
