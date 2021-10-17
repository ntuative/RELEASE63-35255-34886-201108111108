package com.sulake.habbo.inventory.trading
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import flash.events.Event;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.habbo.inventory.enum.InventorySubCategory;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.room.utils.Vector3d;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAlreadyOpenEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.OpenTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemToTradeComposer;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.RemoveItemFromTradeComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AcceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.UnacceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmAcceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmDeclineTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.CloseTradingComposer;

    public class TradingModel implements IInventoryModel, IGetImageListener 
    {

        public static const var_1283:uint = 9;
        public static const var_1284:uint = 0;
        public static const var_1285:uint = 1;
        public static const var_1286:uint = 2;
        public static const var_1287:uint = 3;
        public static const var_1288:uint = 4;
        public static const var_1289:uint = 5;
        public static const TRADING_STATE_CANCELLED:uint = 6;

        private var var_3071:HabboInventory;
        private var _assetLibrary:IAssetLibrary;
        private var _roomEngine:IRoomEngine;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _soundManager:IHabboSoundManager;
        private var var_4113:TradingView;
        private var _disposed:Boolean = false;
        private var var_2581:Boolean = false;
        private var _state:uint = 0;
        private var var_4105:int = -1;
        private var var_4039:String = "";
        private var var_4106:Map;
        private var var_4107:Boolean = false;
        private var var_4108:Boolean = false;
        private var var_4109:int = -1;
        private var var_4110:String = "";
        private var var_4111:Map;
        private var var_4112:Boolean = false;
        private var var_3724:Boolean = false;

        public function TradingModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IRoomEngine, param6:IHabboLocalizationManager, param7:IHabboSoundManager)
        {
            this.var_3071 = param1;
            this._communication = param3;
            this._assetLibrary = param4;
            this._roomEngine = param5;
            this._localization = param6;
            this._soundManager = param7;
            this.var_4113 = new TradingView(this, param2, param4, param5, param6, param7);
        }

        public function get running():Boolean
        {
            return (!(this._state == var_1284));
        }

        public function get state():uint
        {
            return (this._state);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get ownUserId():int
        {
            return (this.var_4105);
        }

        public function get ownUserName():String
        {
            return (this.var_4039);
        }

        public function get ownUserItems():Map
        {
            return (this.var_4106);
        }

        public function get ownUserAccepts():Boolean
        {
            return (this.var_4107);
        }

        public function get ownUserCanTrade():Boolean
        {
            return (this.var_4108);
        }

        public function get otherUserId():int
        {
            return (this.var_4109);
        }

        public function get otherUserName():String
        {
            return (this.var_4110);
        }

        public function get otherUserItems():Map
        {
            return (this.var_4111);
        }

        public function get otherUserAccepts():Boolean
        {
            return (this.var_4112);
        }

        public function get otherUserCanTrade():Boolean
        {
            return (this.var_3724);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                if (((this.var_4113) && (!(this.var_4113.disposed))))
                {
                    this.var_4113.dispose();
                    this.var_4113 = null;
                };
                this.var_3071 = null;
                this._communication = null;
                this._assetLibrary = null;
                this._roomEngine = null;
                this._localization = null;
                this._disposed = true;
            };
        }

        public function startTrading(param1:int, param2:String, param3:Boolean, param4:int, param5:String, param6:Boolean):void
        {
            this.var_4105 = param1;
            this.var_4039 = param2;
            this.var_4106 = new Map();
            this.var_4107 = false;
            this.var_4108 = param3;
            this.var_4109 = param4;
            this.var_4110 = param5;
            this.var_4111 = new Map();
            this.var_4112 = false;
            this.var_3724 = param6;
            this.var_2581 = true;
            this.state = var_1285;
            this.var_4113.setup(param1, param3, param4, param6);
            this.var_4113.updateItemList(this.var_4105);
            this.var_4113.updateItemList(this.var_4109);
            this.var_4113.updateUserInterface();
            this.var_4113.clearItemLists();
            this.var_3071.toggleInventoryPage(InventoryCategory.var_125);
            this.var_3071.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING));
        }

        public function close():void
        {
            if (this.var_2581)
            {
                if (((!(this._state == var_1284)) && (!(this._state == var_1289))))
                {
                    this.requestCancelTrading();
                    this.state = TradingModel.TRADING_STATE_CANCELLED;
                };
                this.state = var_1284;
                this.var_3071.toggleInventorySubPage(InventorySubCategory.var_1290);
                this.var_2581 = false;
            };
            this.var_4113.setMinimized(false);
        }

        public function categorySwitch(param1:String):void
        {
            this.var_4113.setMinimized((!(param1 == InventoryCategory.var_125)));
            this.var_3071.updateSubView();
        }

        public function set state(param1:uint):void
        {
            Logger.log(((((((("OLD STATE: " + this._state) + " NEW STATE: ") + param1) + " OWN: ") + this.var_4107) + " OTHER: ") + this.var_4112));
            var _loc2_:Boolean;
            if (this._state == param1)
            {
                return;
            };
            switch (this._state)
            {
                case var_1284:
                    if (((param1 == var_1285) || (param1 == var_1289)))
                    {
                        this._state = param1;
                        _loc2_ = true;
                    };
                    break;
                case var_1285:
                    if (param1 == var_1286)
                    {
                        this._state = param1;
                        _loc2_ = true;
                        this.startConfirmCountdown();
                    }
                    else
                    {
                        if (param1 == TRADING_STATE_CANCELLED)
                        {
                            this._state = param1;
                            this.var_4113.setMinimized(false);
                            _loc2_ = true;
                        };
                    };
                    break;
                case var_1286:
                    if (param1 == var_1287)
                    {
                        this._state = param1;
                        _loc2_ = true;
                    }
                    else
                    {
                        if (param1 == TRADING_STATE_CANCELLED)
                        {
                            this._state = param1;
                            this.var_4113.setMinimized(false);
                            _loc2_ = true;
                        }
                        else
                        {
                            if (param1 == var_1285)
                            {
                                this._state = param1;
                                _loc2_ = true;
                                this.cancelConfirmCountdown();
                            };
                        };
                    };
                    break;
                case var_1287:
                    if (param1 == var_1288)
                    {
                        this._state = param1;
                        _loc2_ = true;
                    }
                    else
                    {
                        if (param1 == var_1289)
                        {
                            this._state = param1;
                            _loc2_ = true;
                            this.close();
                        }
                        else
                        {
                            if (param1 == TRADING_STATE_CANCELLED)
                            {
                                this._state = param1;
                                this.var_4113.setMinimized(false);
                                _loc2_ = true;
                                this.close();
                            };
                        };
                    };
                    break;
                case var_1288:
                    if (param1 == var_1289)
                    {
                        this._state = param1;
                        this.var_4113.setMinimized(false);
                        _loc2_ = true;
                        this.close();
                    }
                    else
                    {
                        if (param1 == TRADING_STATE_CANCELLED)
                        {
                            this._state = param1;
                            this.var_4113.setMinimized(false);
                            _loc2_ = true;
                            this.close();
                        };
                    };
                    break;
                case var_1289:
                    if (param1 == var_1284)
                    {
                        this._state = param1;
                        _loc2_ = true;
                    };
                    break;
                case TRADING_STATE_CANCELLED:
                    if (param1 == var_1284)
                    {
                        this._state = param1;
                        _loc2_ = true;
                    }
                    else
                    {
                        if (param1 == var_1285)
                        {
                            this._state = param1;
                            _loc2_ = true;
                        };
                    };
                    break;
                default:
                    throw (new Error((('Unknown trading progress state: "' + this._state) + '"')));
            };
            if (_loc2_)
            {
                this.var_4113.updateUserInterface();
            }
            else
            {
                throw (new Error("Error assigning trading process status!"));
            };
        }

        public function getFurniInventoryModel():FurniModel
        {
            return (this.var_3071.furniModel);
        }

        public function updateItemGroupMaps(param1:int, param2:Map, param3:int, param4:Map):void
        {
            if (this.var_3071 == null)
            {
                return;
            };
            if (this.var_4106 != null)
            {
                this.var_4106.dispose();
            };
            if (this.var_4111 != null)
            {
                this.var_4111.dispose();
            };
            if (param1 == this.var_4105)
            {
                this.var_4106 = param2;
                this.var_4111 = param4;
            }
            else
            {
                this.var_4106 = param4;
                this.var_4111 = param2;
            };
            this.var_4107 = false;
            this.var_4112 = false;
            this.var_4113.updateItemList(this.var_4105);
            this.var_4113.updateItemList(this.var_4109);
            this.var_4113.updateUserInterface();
            var _loc5_:FurniModel = this.var_3071.furniModel;
            if (_loc5_ != null)
            {
                _loc5_.updateItemLocks();
            };
        }

        public function getOwnItemIdsInTrade():Array
        {
            var _loc2_:GroupItem;
            var _loc3_:IItem;
            var _loc5_:int;
            var _loc1_:Array = new Array();
            if (((this.var_4106 == null) || (this.var_4106.disposed)))
            {
                return (_loc1_);
            };
            var _loc4_:int;
            while (_loc4_ < this.var_4106.length)
            {
                _loc2_ = (this.var_4106.getWithIndex(_loc4_) as GroupItem);
                if (_loc2_ != null)
                {
                    _loc5_ = 0;
                    while (_loc5_ < _loc2_.getTotalCount())
                    {
                        _loc3_ = _loc2_.getAt(_loc5_);
                        if (_loc3_ != null)
                        {
                            _loc1_.push(_loc3_.ref);
                        };
                        _loc5_++;
                    };
                };
                _loc4_++;
            };
            return (_loc1_);
        }

        public function getWindowContainer():IWindowContainer
        {
            return (this.var_4113.getWindowContainer());
        }

        public function requestInitialization(param1:int=0):void
        {
        }

        public function subCategorySwitch(param1:String):void
        {
            if (this.var_2581)
            {
                if (this._state != var_1284)
                {
                    this.requestCancelTrading();
                };
            };
        }

        public function closingInventoryView():void
        {
            if (this.var_2581)
            {
                this.close();
            };
        }

        public function startConfirmCountdown():void
        {
            this.var_4113.startConfirmCountdown();
        }

        public function cancelConfirmCountdown():void
        {
            this.var_4113.cancelConfirmCountdown();
        }

        public function confirmCountdownReady():void
        {
            if (this._state == var_1286)
            {
                this.state = var_1287;
            };
        }

        public function getItemImage(param1:IItem):BitmapData
        {
            var _loc2_:ImageResult;
            if ((param1 is FloorItem))
            {
                _loc2_ = this._roomEngine.getFurnitureImage(param1.type, new Vector3d(180, 0, 0), 64, this, 0, String(param1.extra));
            }
            else
            {
                _loc2_ = this._roomEngine.getWallItemImage(param1.type, new Vector3d(180, 0, 0), 64, this, 0, param1.stuffData);
            };
            return (_loc2_.data as BitmapData);
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            this.var_4113.updateItemImage(param1, param2);
        }

        public function handleMessageEvent(param1:IMessageEvent):void
        {
            var _loc2_:TradingCloseEvent;
            if ((param1 is TradingAlreadyOpenEvent))
            {
                Logger.log("TRADING::TradingAlreadyOpenEvent");
                this.var_4113.alertPopup(TradingView.var_1291);
            }
            else
            {
                if ((param1 is TradingAcceptEvent))
                {
                    Logger.log("TRADING::TradingAcceptEvent");
                    if (TradingAcceptEvent(param1).userID == this.var_4105)
                    {
                        this.var_4107 = (!(TradingAcceptEvent(param1).userAccepts == 0));
                    }
                    else
                    {
                        this.var_4112 = (!(TradingAcceptEvent(param1).userAccepts == 0));
                    };
                    this.var_4113.updateUserInterface();
                }
                else
                {
                    if ((param1 is TradingConfirmationEvent))
                    {
                        Logger.log("TRADING::TradingConfirmationEvent");
                        this.state = var_1286;
                    }
                    else
                    {
                        if ((param1 is TradingCompletedEvent))
                        {
                            Logger.log("TRADING::TradingCompletedEvent");
                            this.state = var_1289;
                        }
                        else
                        {
                            if ((param1 is TradingCloseEvent))
                            {
                                Logger.log("TRADING::TradingCloseEvent");
                                if (!this.var_2581)
                                {
                                    Logger.log("Received TradingCloseEvent, but trading already stopped!!!");
                                    return;
                                };
                                _loc2_ = (param1 as TradingCloseEvent);
                                if (_loc2_.userID != this.var_4105)
                                {
                                    this.var_4113.alertPopup(TradingView.var_1292);
                                };
                                this.close();
                            }
                            else
                            {
                                if ((param1 is TradingNotOpenEvent))
                                {
                                    Logger.log("TRADING::TradingNotOpenEvent");
                                }
                                else
                                {
                                    if ((param1 is TradingOtherNotAllowedEvent))
                                    {
                                        this.var_4113.showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
                                    }
                                    else
                                    {
                                        if ((param1 is TradingYouAreNotAllowedEvent))
                                        {
                                            this.var_4113.showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
                                        }
                                        else
                                        {
                                            Logger.log(("TRADING/Unknown message event: " + param1));
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public function requestFurniViewOpen():void
        {
            this.var_3071.toggleInventoryPage(InventoryCategory.var_125);
        }

        public function requestOpenTrading(param1:int):void
        {
            this._communication.getHabboMainConnection(null).send(new OpenTradingComposer(param1));
        }

        public function requestAddItemToTrading(param1:int, param2:int, param3:int, param4:Boolean, param5:String=""):Boolean
        {
            var _loc6_:String;
            if (this.var_4107)
            {
                return (false);
            };
            if (this.var_4106 == null)
            {
                return (false);
            };
            if (this.var_4106.length < var_1283)
            {
                this._communication.getHabboMainConnection(null).send(new AddItemToTradeComposer(param1));
            }
            else
            {
                if (!param4)
                {
                    return (false);
                };
                _loc6_ = String(param2);
                if (param3 == FurniCategory.var_615)
                {
                    _loc6_ = ((String(param2) + "poster") + param5);
                };
                if (this.var_4106.getValue(_loc6_) != null)
                {
                    this._communication.getHabboMainConnection(null).send(new AddItemToTradeComposer(param1));
                }
                else
                {
                    return (false);
                };
            };
            return (true);
        }

        public function requestRemoveItemFromTrading(param1:int):void
        {
            var _loc3_:IItem;
            if (this.var_4107)
            {
                return;
            };
            var _loc2_:GroupItem = this.ownUserItems.getWithIndex(param1);
            if (_loc2_)
            {
                _loc3_ = _loc2_.var_1293();
                if (_loc3_)
                {
                    this._communication.getHabboMainConnection(null).send(new RemoveItemFromTradeComposer(_loc3_.id));
                };
            };
        }

        public function requestAcceptTrading():void
        {
            this._communication.getHabboMainConnection(null).send(new AcceptTradingComposer());
        }

        public function requestUnacceptTrading():void
        {
            this._communication.getHabboMainConnection(null).send(new UnacceptTradingComposer());
        }

        public function requestConfirmAcceptTrading():void
        {
            this.state = var_1288;
            this._communication.getHabboMainConnection(null).send(new ConfirmAcceptTradingComposer());
        }

        public function requestConfirmDeclineTrading():void
        {
            this._communication.getHabboMainConnection(null).send(new ConfirmDeclineTradingComposer());
        }

        public function requestCancelTrading():void
        {
            this._communication.getHabboMainConnection(null).send(new CloseTradingComposer());
        }


    }
}