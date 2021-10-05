package com.ankama.haapi.client.api
{
   import com.ankama.haapi.client.ApiInvokerHelper;
   import com.ankama.haapi.client.model.ShopArticle;
   import com.ankama.haapi.client.model.ShopArticlesList;
   import com.ankama.haapi.client.model.ShopBuyResult;
   import com.ankama.haapi.client.model.ShopCategory;
   import com.ankama.haapi.client.model.ShopGondolaHead;
   import com.ankama.haapi.client.model.ShopHighlight;
   import com.ankama.haapi.client.model.ShopHome;
   import com.ankama.haapi.client.model.ShopIAPsListResponse;
   import com.ankama.haapi.client.model.ShopOneClickToken;
   import com.ankama.haapi.client.model.ShopOrder;
   import com.ankama.haapi.client.model.ShopPaymentHkCodeSendResult;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.common.OpenApi;
   import org.openapitools.exception.ApiError;
   
   public class ShopApi extends OpenApi
   {
      
      public static const event_articles_list_by_category:String = "articles_list_by_category";
      
      public static const event_articles_list_by_category_key:String = "articles_list_by_category_key";
      
      public static const event_articles_list_by_gondolahead:String = "articles_list_by_gondolahead";
      
      public static const event_articles_list_by_ids:String = "articles_list_by_ids";
      
      public static const event_articles_list_by_key:String = "articles_list_by_key";
      
      public static const event_articles_list_search:String = "articles_list_search";
      
      public static const event_buy:String = "buy";
      
      public static const event_categories_list:String = "categories_list";
      
      public static const event_categories_list_by_key:String = "categories_list_by_key";
      
      public static const event_gondola_heads_list:String = "gondola_heads_list";
      
      public static const event_hight_lights_list:String = "hight_lights_list";
      
      public static const event_home:String = "home";
      
      public static const event_i_a_ps_list:String = "i_a_ps_list";
      
      public static const event_mobile_cancel_order:String = "mobile_cancel_order";
      
      public static const event_mobile_get_order_by_receipt:String = "mobile_get_order_by_receipt";
      
      public static const event_mobile_validate_order:String = "mobile_validate_order";
      
      public static const event_one_click_buy:String = "one_click_buy";
      
      public static const event_one_click_send_code:String = "one_click_send_code";
      
      public static const event_one_click_tokens:String = "one_click_tokens";
      
      public static const event_one_click_validate_order:String = "one_click_validate_order";
      
      public static const event_partner_finalize_transaction:String = "partner_finalize_transaction";
      
      public static const event_pending_orders:String = "pending_orders";
      
      public static const event_simple_buy:String = "simple_buy";
      
      public static const hightLightsList_TypeEnum_IMAGE:String = "IMAGE";
      
      public static const hightLightsList_TypeEnum_CAROUSEL:String = "CAROUSEL";
      
      public static const hightLightsList_TypeEnum_POPUP:String = "POPUP";
      
      public static const iAPsList_ShopKeyEnum_KROSMASTERINGAME:String = "KROSMASTER_INGAME";
      
      public static const iAPsList_ShopKeyEnum_TACTILEWARSINGAME:String = "TACTILEWARS_INGAME";
      
      public static const iAPsList_ShopKeyEnum_DOFUSTOUCHINGAME:String = "DOFUS_TOUCH_INGAME";
      
      public static const iAPsList_ShopKeyEnum_DOFUSTOUCHBETA:String = "DOFUS_TOUCH_BETA";
      
      public static const iAPsList_ShopKeyEnum_KROSMAGAINGAME:String = "KROSMAGA_INGAME";
      
      public static const iAPsList_ShopKeyEnum_DOFUSPETSINGAME:String = "DOFUS_PETS_INGAME";
       
      
      public function ShopApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher = null)
      {
         super(apiCredentials,eventDispatcher);
      }
      
      private static function isValidParam(param:*) : Boolean
      {
         if(param is int || param is uint)
         {
            return true;
         }
         if(param is Number)
         {
            return !isNaN(param);
         }
         return param != null;
      }
      
      public function articles_list_by_category(category_id:Number, page:Number, size:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/ArticlesListByCategory".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(category_id))
         {
            throw new ApiError(400,"missing required params : category_id");
         }
         queryParams["category_id"] = toPathValue(category_id);
         queryParams["page"] = toPathValue(page);
         queryParams["size"] = toPathValue(size);
         var forceImport_ShopArticlesList:ShopArticlesList = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "articles_list_by_category";
            _token.returnType = "com.ankama.haapi.client.model.ShopArticlesList";
         });
      }
      
      public function articles_list_by_category_key(key:String, page:Number, size:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/ArticlesListByCategoryKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(key))
         {
            throw new ApiError(400,"missing required params : key");
         }
         queryParams["key"] = toPathValue(key);
         queryParams["page"] = toPathValue(page);
         queryParams["size"] = toPathValue(size);
         var forceImport_ShopArticlesList:ShopArticlesList = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "articles_list_by_category_key";
            _token.returnType = "com.ankama.haapi.client.model.ShopArticlesList";
         });
      }
      
      public function articles_list_by_gondolahead(gondolahead_id:Number, page:Number, size:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/ArticlesListByGondolahead".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(gondolahead_id))
         {
            throw new ApiError(400,"missing required params : gondolahead_id");
         }
         queryParams["gondolahead_id"] = toPathValue(gondolahead_id);
         queryParams["page"] = toPathValue(page);
         queryParams["size"] = toPathValue(size);
         var forceImport_ShopArticle:ShopArticle = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "articles_list_by_gondolahead";
            _token.returnType = "com.ankama.haapi.client.model.ShopArticle";
         });
      }
      
      public function articles_list_by_ids(ids:Array) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/ArticlesListByIds".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(ids))
         {
            throw new ApiError(400,"missing required params : ids");
         }
         queryParams["ids"] = toPathValue(ids);
         var forceImport_ShopArticlesList:ShopArticlesList = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "articles_list_by_ids";
            _token.returnType = "com.ankama.haapi.client.model.ShopArticlesList";
         });
      }
      
      public function articles_list_by_key(key:Array) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/ArticlesListByKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(key))
         {
            throw new ApiError(400,"missing required params : key");
         }
         queryParams["key"] = toPathValue(key);
         var forceImport_ShopArticlesList:ShopArticlesList = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "articles_list_by_key";
            _token.returnType = "com.ankama.haapi.client.model.ShopArticlesList";
         });
      }
      
      public function articles_list_search(text:String, categories_ids:Array, page:Number, size:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/ArticlesListSearch".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(text))
         {
            throw new ApiError(400,"missing required params : text");
         }
         queryParams["text"] = toPathValue(text);
         queryParams["categories_ids"] = toPathValue(categories_ids);
         queryParams["page"] = toPathValue(page);
         queryParams["size"] = toPathValue(size);
         var forceImport_ShopArticlesList:ShopArticlesList = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "articles_list_search";
            _token.returnType = "com.ankama.haapi.client.model.ShopArticlesList";
         });
      }
      
      public function buy(data:String, currency:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/Buy".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(data))
         {
            throw new ApiError(400,"missing required params : data");
         }
         queryParams["data"] = toPathValue(data);
         queryParams["currency"] = toPathValue(currency);
         var forceImport_ShopBuyResult:ShopBuyResult = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "buy";
            _token.returnType = "com.ankama.haapi.client.model.ShopBuyResult";
         });
      }
      
      public function categories_list() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/CategoriesList".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         var forceImport_ShopCategory:ShopCategory = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "categories_list";
            _token.returnType = "com.ankama.haapi.client.model.ShopCategory";
         });
      }
      
      public function categories_list_by_key(key:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/CategoriesListByKey".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(key))
         {
            throw new ApiError(400,"missing required params : key");
         }
         queryParams["key"] = toPathValue(key);
         var forceImport_ShopCategory:ShopCategory = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "categories_list_by_key";
            _token.returnType = "com.ankama.haapi.client.model.ShopCategory";
         });
      }
      
      public function gondola_heads_list(home:Boolean, category_id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/GondolaHeadsList".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         queryParams["home"] = toPathValue(home);
         queryParams["category_id"] = toPathValue(category_id);
         var forceImport_ShopGondolaHead:ShopGondolaHead = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "gondola_heads_list";
            _token.returnType = "com.ankama.haapi.client.model.ShopGondolaHead";
         });
      }
      
      public function hight_lights_list(type:String, category_id:Number, game_id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/HightLightsList".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         queryParams["type"] = toPathValue(type);
         queryParams["category_id"] = toPathValue(category_id);
         queryParams["game_id"] = toPathValue(game_id);
         var forceImport_ShopHighlight:ShopHighlight = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "hight_lights_list";
            _token.returnType = "com.ankama.haapi.client.model.ShopHighlight";
         });
      }
      
      public function home() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/Home".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         var forceImport_ShopHome:ShopHome = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "home";
            _token.returnType = "com.ankama.haapi.client.model.ShopHome";
         });
      }
      
      public function i_a_ps_list(shop_key:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/IAPsList".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(shop_key))
         {
            throw new ApiError(400,"missing required params : shop_key");
         }
         queryParams["shop_key"] = toPathValue(shop_key);
         var forceImport_ShopIAPsListResponse:ShopIAPsListResponse = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "i_a_ps_list";
            _token.returnType = "com.ankama.haapi.client.model.ShopIAPsListResponse";
         });
      }
      
      public function mobile_cancel_order(order_id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/MobileCancelOrder".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(order_id))
         {
            throw new ApiError(400,"missing required params : order_id");
         }
         postParams["order_id"] = toPathValue(order_id);
         var forceImport_ShopBuyResult:ShopBuyResult = undefined;
         var contentTypes:Array = new Array("application/x-www-form-urlencoded");
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"POST",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "mobile_cancel_order";
            _token.returnType = "com.ankama.haapi.client.model.ShopBuyResult";
         });
      }
      
      public function mobile_get_order_by_receipt(receipt:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/MobileGetOrderByReceipt".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(receipt))
         {
            throw new ApiError(400,"missing required params : receipt");
         }
         postParams["receipt"] = toPathValue(receipt);
         var forceImport_ShopBuyResult:ShopBuyResult = undefined;
         var contentTypes:Array = new Array("application/x-www-form-urlencoded");
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"POST",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "mobile_get_order_by_receipt";
            _token.returnType = "com.ankama.haapi.client.model.ShopBuyResult";
         });
      }
      
      public function mobile_validate_order(receipt:String, order_id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/MobileValidateOrder".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(receipt))
         {
            throw new ApiError(400,"missing required params : receipt");
         }
         postParams["receipt"] = toPathValue(receipt);
         postParams["order_id"] = toPathValue(order_id);
         var forceImport_ShopBuyResult:ShopBuyResult = undefined;
         var contentTypes:Array = new Array("application/x-www-form-urlencoded");
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"POST",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "mobile_validate_order";
            _token.returnType = "com.ankama.haapi.client.model.ShopBuyResult";
         });
      }
      
      public function one_click_buy(data:String, currency:String, token:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/OneClickBuy".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(data))
         {
            throw new ApiError(400,"missing required params : data");
         }
         if(!isValidParam(currency))
         {
            throw new ApiError(400,"missing required params : currency");
         }
         if(!isValidParam(token))
         {
            throw new ApiError(400,"missing required params : token");
         }
         queryParams["data"] = toPathValue(data);
         queryParams["currency"] = toPathValue(currency);
         queryParams["token"] = toPathValue(token);
         var forceImport_ShopBuyResult:ShopBuyResult = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "one_click_buy";
            _token.returnType = "com.ankama.haapi.client.model.ShopBuyResult";
         });
      }
      
      public function one_click_send_code(order:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/OneClickSendCode".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(order))
         {
            throw new ApiError(400,"missing required params : order");
         }
         queryParams["order"] = toPathValue(order);
         var forceImport_ShopPaymentHkCodeSendResult:ShopPaymentHkCodeSendResult = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "one_click_send_code";
            _token.returnType = "com.ankama.haapi.client.model.ShopPaymentHkCodeSendResult";
         });
      }
      
      public function one_click_tokens() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/OneClickTokens".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         var forceImport_ShopOneClickToken:ShopOneClickToken = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "one_click_tokens";
            _token.returnType = "com.ankama.haapi.client.model.ShopOneClickToken";
         });
      }
      
      public function one_click_validate_order(order_id:Number, code:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/OneClickValidateOrder".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(order_id))
         {
            throw new ApiError(400,"missing required params : order_id");
         }
         if(!isValidParam(code))
         {
            throw new ApiError(400,"missing required params : code");
         }
         queryParams["order_id"] = toPathValue(order_id);
         queryParams["code"] = toPathValue(code);
         var forceImport_ShopBuyResult:ShopBuyResult = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "one_click_validate_order";
            _token.returnType = "com.ankama.haapi.client.model.ShopBuyResult";
         });
      }
      
      public function partner_finalize_transaction(finalize:Boolean, order_id:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/PartnerFinalizeTransaction".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(finalize))
         {
            throw new ApiError(400,"missing required params : finalize");
         }
         queryParams["finalize"] = toPathValue(finalize);
         queryParams["order_id"] = toPathValue(order_id);
         var forceImport_ShopBuyResult:ShopBuyResult = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "partner_finalize_transaction";
            _token.returnType = "com.ankama.haapi.client.model.ShopBuyResult";
         });
      }
      
      public function pending_orders() : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/PendingOrders".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         var forceImport_ShopOrder:ShopOrder = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "pending_orders";
            _token.returnType = "com.ankama.haapi.client.model.ShopOrder";
         });
      }
      
      public function simple_buy(article_id:Number, quantity:Number, amount:Number, currency:String) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Shop/SimpleBuy".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(article_id))
         {
            throw new ApiError(400,"missing required params : article_id");
         }
         if(!isValidParam(quantity))
         {
            throw new ApiError(400,"missing required params : quantity");
         }
         queryParams["article_id"] = toPathValue(article_id);
         queryParams["quantity"] = toPathValue(quantity);
         queryParams["amount"] = toPathValue(amount);
         queryParams["currency"] = toPathValue(currency);
         var forceImport_ShopBuyResult:ShopBuyResult = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "simple_buy";
            _token.returnType = "com.ankama.haapi.client.model.ShopBuyResult";
         });
      }
   }
}
