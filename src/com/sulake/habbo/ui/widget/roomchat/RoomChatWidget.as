package com.sulake.habbo.ui.widget.roomchat
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.geom.Point;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import flash.utils.getTimer;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatSelectAvatarMessage;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class RoomChatWidget extends RoomWidgetBase implements IUpdateReceiver 
    {

        private static const var_1647:int = 18;
        private static const var_1660:int = 9;
        private static const var_1657:int = 10;
        private static const var_1659:int = 25;
        private static const var_1649:int = 25;
        private static const var_1651:int = 4000;
        private static const var_1656:int = 6000;
        private static const var_1650:int = 3;
        private static const var_1655:int = 1;
        private static const var_1645:int = 8;
        private static const var_1646:int = 0;
        private static const var_1664:int = (((var_1645 + var_1646) * var_1647) + var_1647);//162
        private static const var_1658:int = 9;
        private static const var_1663:int = 40;

        private var var_5448:int = 0;
        private var var_5449:int = 0;
        private var var_5415:IWindowContainer;
        private var var_5445:IItemListWindow;
        private var var_5446:IWindowContainer;
        private var _itemList:Array = new Array();
        private var var_5450:Array = new Array();
        private var var_5451:Array = new Array();
        private var var_5452:int;
        private var var_5453:int = 0;
        private var var_5454:Number = 1;
        private var _baseUrl:String;
        private var var_5455:Number = 1;
        private var var_5456:Number = 0;
        private var var_5457:Point = new Point();
        private var var_5447:RoomChatHistoryViewer;
        private var var_3029:Boolean = false;
        private var var_5458:Boolean = false;
        private var var_4007:Component = null;
        private var _config:IHabboConfigurationManager;
        private var var_5459:int = 150;
        private var var_5444:int = 171;
        private var var_5460:int = 18;
        private var var_5461:int = 100;
        private var var_5462:int = 195;

        public function RoomChatWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IHabboConfigurationManager, param6:int, param7:Component)
        {
            super(param1, param2, param3, param4);
            this._config = param5;
            this.var_5452 = param6;
            this.var_5415 = (param2.createWindow("chat_container", "", HabboWindowType.var_218, HabboWindowStyle.var_613, HabboWindowParam.var_157, new Rectangle(0, 0, 200, (this.var_5444 + RoomChatHistoryPulldown.var_1648)), null, 0) as IWindowContainer);
            this.var_5415.background = true;
            this.var_5415.color = 0x1FFFFFF;
            this.var_5415.tags.push("room_widget_chat");
            this.var_5445 = (param2.createWindow("chat_contentlist", "", HabboWindowType.var_231, HabboWindowStyle.var_157, (HabboWindowParam.var_159 | HabboWindowParam.var_847), new Rectangle(0, 0, 200, this.var_5444), null, 0) as IItemListWindow);
            this.var_5415.addChild(this.var_5445);
            this.var_5446 = (param2.createWindow("chat_active_content", "", HabboWindowType.var_218, HabboWindowStyle.var_157, HabboWindowParam.var_159, new Rectangle(0, 0, 200, this.var_5444), null, 0) as IWindowContainer);
            this.var_5446.clipping = false;
            this.var_5445.addListItem(this.var_5446);
            this.var_5447 = new RoomChatHistoryViewer(this, param2, this.var_5415, param3);
            this._baseUrl = param5.getKey("site.url");
            this.var_5459 = int(param5.getKey("chat.history.item.max.count", "150"));
            var _loc8_:Boolean = param5.getBoolean("chat.history.disabled", false);
            if (this.var_5447 != null)
            {
                this.var_5447.disabled = _loc8_;
            };
            if (param7 != null)
            {
                this.var_4007 = param7;
                this.var_4007.registerUpdateReceiver(this, 1);
            };
        }

        override public function get mainWindow():IWindow
        {
            return (this.var_5415);
        }

        public function get config():IHabboConfigurationManager
        {
            return (this._config);
        }

        override public function dispose():void
        {
            var _loc1_:RoomChatItem;
            var _loc2_:int;
            if (disposed)
            {
                return;
            };
            while (this.var_5451.length > 0)
            {
                _loc1_ = this.var_5451.shift();
            };
            this.var_5447.dispose();
            this.var_5447 = null;
            while (this._itemList.length > 0)
            {
                _loc1_ = this._itemList.shift();
                _loc1_.dispose();
            };
            while (this.var_5450.length > 0)
            {
                _loc1_ = this.var_5450.shift();
                _loc1_.dispose();
            };
            this.var_5415.dispose();
            if (this.var_4007 != null)
            {
                this.var_4007.removeUpdateReceiver(this);
                this.var_4007 = null;
            };
            super.dispose();
        }

        public function update(param1:uint):void
        {
            var _loc2_:int;
            if (((getTimer() > this.var_5448) && (this.var_5448 > 0)))
            {
                this.var_5448 = -1;
                this.animationStart();
            };
            if (this.var_3029)
            {
                _loc2_ = int(((param1 / var_1649) * var_1650));
                if ((_loc2_ + this.var_5449) > this.var_5460)
                {
                    _loc2_ = (this.var_5460 - this.var_5449);
                };
                if (_loc2_ > 0)
                {
                    this.moveItemsUp(_loc2_);
                    this.var_5449 = (this.var_5449 + _loc2_);
                };
                if (this.var_5449 >= this.var_5460)
                {
                    this.var_5460 = var_1647;
                    this.var_5449 = 0;
                    this.animationStop();
                    this.processBuffer();
                    this.var_5448 = (getTimer() + var_1651);
                };
            };
            if (this.var_5447 != null)
            {
                this.var_5447.update(param1);
            };
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetChatUpdateEvent.var_1652, this.onChatMessage);
            param1.addEventListener(RoomWidgetRoomViewUpdateEvent.var_1538, this.onRoomViewUpdate);
            param1.addEventListener(RoomWidgetRoomViewUpdateEvent.var_1653, this.onRoomViewUpdate);
            param1.addEventListener(RoomWidgetRoomViewUpdateEvent.var_1654, this.onRoomViewUpdate);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetChatUpdateEvent.var_1652, this.onChatMessage);
            param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.var_1538, this.onRoomViewUpdate);
            param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.var_1653, this.onRoomViewUpdate);
            param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.var_1654, this.onRoomViewUpdate);
        }

        private function onChatMessage(param1:RoomWidgetChatUpdateEvent):void
        {
            var _loc2_:RoomChatItem = new RoomChatItem(this, windowManager, assets, this.getFreeItemId(), localizations, this._baseUrl);
            _loc2_.define(param1);
            if (this.var_5455 != 1)
            {
                _loc2_.senderX = (_loc2_.senderX / this.var_5455);
            };
            _loc2_.senderX = (_loc2_.senderX - this.var_5457.x);
            this.setChatItemLocHorizontal(_loc2_);
            this.var_5450.push(_loc2_);
            this.processBuffer();
        }

        private function onRoomViewUpdate(param1:RoomWidgetRoomViewUpdateEvent):void
        {
            var _loc2_:Rectangle = param1.rect;
            if (param1.scale > 0)
            {
                if (this.var_5456 == 0)
                {
                    this.var_5456 = param1.scale;
                }
                else
                {
                    this.var_5455 = (param1.scale / this.var_5456);
                };
            };
            if (param1.positionDelta != null)
            {
                this.var_5457.x = (this.var_5457.x + (param1.positionDelta.x / this.var_5455));
                this.var_5457.y = (this.var_5457.y + (param1.positionDelta.y / this.var_5455));
            };
            if (param1.rect != null)
            {
                if (this.var_5447 == null)
                {
                    return;
                };
                this.var_5415.width = _loc2_.width;
                this.var_5415.height = (this.var_5444 + this.var_5447.pulldownBarHeight);
                this.var_5445.width = (this.var_5415.width - this.var_5447.scrollbarWidth);
                this.var_5445.height = this.var_5444;
                this.var_5445.x = this.var_5415.x;
                this.var_5445.y = this.var_5415.y;
                this.var_5446.width = (this.var_5415.width - this.var_5447.scrollbarWidth);
                this.var_5446.height = this.var_5444;
                if (this.historyViewerActive())
                {
                    this.reAlignItemsToHistoryContent();
                };
                this.var_5447.containerResized(this.var_5415.rectangle, true);
            };
            this.alignItems();
        }

        private function processBuffer():void
        {
            if (this.var_3029)
            {
                return;
            };
            if (this.var_5450.length == 0)
            {
                return;
            };
            while (((this.var_5450.length > var_1655) || ((this.historyViewerActive()) && (this.var_5450.length > 0))))
            {
                this.activateItemFromBuffer();
            };
            var _loc1_:Boolean;
            if (this._itemList.length == 0)
            {
                _loc1_ = true;
            }
            else
            {
                _loc1_ = this.checkLastItemAllowsAdding(this.var_5450[0]);
            };
            if (_loc1_)
            {
                this.activateItemFromBuffer();
                this.var_5448 = (getTimer() + var_1651);
            }
            else
            {
                if (((this._itemList.length > 0) && (this.var_5450.length > 0)))
                {
                    this.var_5460 = this.getItemSpacing(this._itemList[(this._itemList.length - 1)], this.var_5450[0]);
                }
                else
                {
                    this.var_5460 = var_1647;
                };
                this.animationStart();
            };
        }

        private function activateItemFromBuffer():void
        {
            var _loc1_:RoomChatItem;
            var _loc2_:IWindowContainer;
            var _loc3_:int;
            if (this.var_5450.length == 0)
            {
                return;
            };
            if (this.historyViewerMinimized())
            {
                this.resetArea();
                this.hideHistoryViewer();
            };
            if (!this.checkLastItemAllowsAdding(this.var_5450[0]))
            {
                this.selectItemsToMove();
                this.moveItemsUp(this.getItemSpacing(this._itemList[(this._itemList.length - 1)], this.var_5450[0]));
                if (!this.checkLastItemAllowsAdding(this.var_5450[0]))
                {
                    this.var_5446.height = (this.var_5446.height + var_1647);
                    if (this.var_5447 != null)
                    {
                        this.var_5447.containerResized(this.var_5415.rectangle);
                    };
                };
            };
            _loc1_ = this.var_5450.shift();
            if (_loc1_ != null)
            {
                _loc1_.renderView();
                _loc2_ = _loc1_.view;
                if (_loc2_ != null)
                {
                    this.var_5446.addChild(_loc2_);
                    _loc1_.timeStamp = new Date().time;
                    this._itemList.push(_loc1_);
                    _loc3_ = 0;
                    if (this._itemList.length > 1)
                    {
                        _loc3_ = this._itemList[(this._itemList.length - 2)].screenLevel;
                        if (this.historyViewerActive())
                        {
                            _loc1_.screenLevel = (_loc3_ + 1);
                        }
                        else
                        {
                            _loc1_.screenLevel = (_loc3_ + Math.max(this.var_5454, 1));
                        };
                    }
                    else
                    {
                        _loc1_.screenLevel = 100;
                    };
                    _loc1_.aboveLevels = this.var_5454;
                    if (_loc1_.aboveLevels > ((var_1645 + var_1646) + 2))
                    {
                        _loc1_.aboveLevels = ((var_1645 + var_1646) + 2);
                    };
                    this.var_5454 = 0;
                    this.setChatItemLocHorizontal(_loc1_);
                    this.setChatItemLocVertical(_loc1_);
                    this.setChatItemRenderable(_loc1_);
                };
            };
        }

        private function checkLastItemAllowsAdding(param1:RoomChatItem):Boolean
        {
            if (this._itemList.length == 0)
            {
                return (true);
            };
            var _loc2_:RoomChatItem = this._itemList[(this._itemList.length - 1)];
            if (((param1 == null) || (_loc2_ == null)))
            {
                return (false);
            };
            if (_loc2_.view == null)
            {
                return (true);
            };
            if ((this.var_5446.rectangle.bottom - ((this.var_5446.y + _loc2_.y) + _loc2_.height)) <= this.getItemSpacing(_loc2_, param1))
            {
                return (false);
            };
            return (true);
        }

        private function alignItems():void
        {
            var _loc1_:int;
            var _loc2_:RoomChatItem;
            var _loc3_:IWindowContainer;
            if (this.var_5447 == null)
            {
                return;
            };
            _loc1_ = (this._itemList.length - 1);
            while (_loc1_ >= 0)
            {
                _loc2_ = this._itemList[_loc1_];
                if (_loc2_ != null)
                {
                    this.setChatItemLocHorizontal(_loc2_);
                    this.setChatItemLocVertical(_loc2_);
                };
                _loc1_--;
            };
            _loc1_ = 0;
            while (_loc1_ < this._itemList.length)
            {
                _loc2_ = this._itemList[_loc1_];
                if (_loc2_ != null)
                {
                    this.setChatItemRenderable(_loc2_);
                };
                _loc1_++;
            };
            _loc1_ = 0;
            while (_loc1_ < this.var_5450.length)
            {
                _loc2_ = this.var_5450[_loc1_];
                if (_loc2_ != null)
                {
                    this.setChatItemLocHorizontal(_loc2_);
                };
                _loc1_++;
            };
        }

        private function animationStart():void
        {
            if (this.var_3029)
            {
                return;
            };
            this.selectItemsToMove();
            this.var_3029 = true;
        }

        private function animationStop():void
        {
            this.var_3029 = false;
        }

        private function selectItemsToMove():void
        {
            var _loc4_:RoomChatItem;
            if (this.var_3029)
            {
                return;
            };
            this.purgeItems();
            this.var_5451 = new Array();
            var _loc1_:int = new Date().time;
            var _loc2_:int;
            if (this._itemList.length == 0)
            {
                this.var_5454 = 1;
                return;
            };
            if (this.historyViewerActive())
            {
                return;
            };
            this.var_5454++;
            var _loc3_:int = (this._itemList.length - 1);
            while (_loc3_ >= 0)
            {
                _loc4_ = this._itemList[_loc3_];
                if (_loc4_.view != null)
                {
                    if ((((_loc4_.screenLevel > var_1646) || (_loc4_.screenLevel == (_loc2_ - 1))) || ((_loc1_ - _loc4_.timeStamp) >= var_1656)))
                    {
                        _loc4_.timeStamp = _loc1_;
                        _loc2_ = _loc4_.screenLevel;
                        _loc4_.screenLevel--;
                        this.var_5451.push(_loc4_);
                    };
                };
                _loc3_--;
            };
        }

        private function moveItemsUp(param1:int):void
        {
            var _loc3_:Boolean;
            if (this.var_5451 == null)
            {
                return;
            };
            if (this.var_5451.length == 0)
            {
                return;
            };
            var _loc2_:RoomChatItem;
            var _loc4_:int = -1;
            var _loc5_:int = (this.var_5451.length - 1);
            while (_loc5_ >= 0)
            {
                _loc2_ = this.var_5451[_loc5_];
                if (_loc2_ != null)
                {
                    if (_loc4_ == -1)
                    {
                        _loc4_ = this._itemList.indexOf(_loc2_);
                    }
                    else
                    {
                        _loc4_++;
                    };
                    _loc3_ = true;
                    if (this.historyViewerActive())
                    {
                        if (((_loc2_.y - param1) + _loc2_.height) < 0)
                        {
                            _loc3_ = false;
                        };
                    };
                    if (_loc4_ > 0)
                    {
                        if (this._itemList[(_loc4_ - 1)].view != null)
                        {
                            if (((_loc2_.y - param1) - this._itemList[(_loc4_ - 1)].y) < this.getItemSpacing(this._itemList[(_loc4_ - 1)], _loc2_))
                            {
                                _loc3_ = false;
                            };
                        };
                    };
                    if (_loc3_)
                    {
                        _loc2_.y = (_loc2_.y - param1);
                    };
                };
                _loc5_--;
            };
        }

        private function setChatItemLocHorizontal(param1:RoomChatItem):void
        {
            var _loc9_:Number;
            var _loc10_:Number;
            if (((param1 == null) || (this.var_5447 == null)))
            {
                return;
            };
            var _loc2_:Number = ((param1.senderX + this.var_5457.x) * this.var_5455);
            var _loc3_:Number = (_loc2_ - (param1.width / 2));
            var _loc4_:Number = (_loc3_ + param1.width);
            var _loc5_:Number = (((-(this.var_5415.width) / 2) - var_1657) + this.var_5461);
            var _loc6_:Number = ((((this.var_5415.width / 2) + var_1657) - this.var_5447.scrollbarWidth) - this.var_5462);
            var _loc7_:Boolean = ((_loc3_ >= _loc5_) && (_loc3_ <= _loc6_));
            var _loc8_:Boolean = ((_loc4_ >= _loc5_) && (_loc4_ <= _loc6_));
            if (((_loc7_) && (_loc8_)))
            {
                _loc9_ = _loc3_;
                _loc10_ = _loc9_;
            }
            else
            {
                if (_loc2_ >= 0)
                {
                    _loc9_ = (_loc6_ - param1.width);
                }
                else
                {
                    _loc9_ = _loc5_;
                };
            };
            param1.x = ((_loc9_ + (this.var_5415.width / 2)) + this.var_5415.x);
            if (((_loc2_ < _loc5_) || (_loc2_ > _loc6_)))
            {
                param1.hidePointer();
            }
            else
            {
                param1.setPointerOffset((_loc3_ - _loc9_));
            };
        }

        private function setChatItemLocVertical(param1:RoomChatItem):void
        {
            var _loc2_:int;
            var _loc3_:Number;
            var _loc4_:Number;
            if (param1 != null)
            {
                _loc2_ = this._itemList.indexOf(param1);
                _loc3_ = ((this.historyViewerActive()) ? 0 : this.var_5454);
                if (_loc2_ == (this._itemList.length - 1))
                {
                    param1.y = ((this.getAreaBottom() - ((_loc3_ + 1) * var_1647)) - var_1658);
                }
                else
                {
                    _loc4_ = this._itemList[(_loc2_ + 1)].aboveLevels;
                    if (_loc4_ < 2)
                    {
                        param1.y = (this._itemList[(_loc2_ + 1)].y - this.getItemSpacing(param1, this._itemList[(_loc2_ + 1)]));
                    }
                    else
                    {
                        param1.y = (this._itemList[(_loc2_ + 1)].y - (_loc4_ * var_1647));
                    };
                };
            };
        }

        private function setChatItemRenderable(param1:RoomChatItem):void
        {
            if (param1 != null)
            {
                if (param1.y < -(var_1659))
                {
                    if (param1.view != null)
                    {
                        this.var_5446.removeChild(param1.view);
                        param1.hideView();
                    };
                }
                else
                {
                    if (param1.view == null)
                    {
                        param1.renderView();
                        if (param1.view != null)
                        {
                            this.var_5446.addChild(param1.view);
                        };
                    };
                };
            };
        }

        public function getTotalContentHeight():int
        {
            var _loc1_:RoomChatItem;
            var _loc2_:int;
            var _loc3_:int;
            while (_loc3_ < this._itemList.length)
            {
                _loc1_ = this._itemList[_loc3_];
                if (_loc1_ != null)
                {
                    if (_loc3_ == 0)
                    {
                        _loc2_ = (_loc2_ + var_1647);
                    }
                    else
                    {
                        _loc2_ = (_loc2_ + this.getItemSpacing(this._itemList[(_loc3_ - 1)], _loc1_));
                    };
                    _loc2_ = (_loc2_ + ((_loc1_.aboveLevels - 1) * var_1647));
                };
                _loc3_++;
            };
            return (_loc2_);
        }

        private function getAreaBottom():Number
        {
            if (this.historyViewerActive())
            {
                return (this.var_5446.height);
            };
            return (this.var_5444 + this.var_5415.y);
        }

        private function getItemSpacing(param1:RoomChatItem, param2:RoomChatItem):Number
        {
            if (param1.checkOverlap(param2.x, param1.y, param2.width, param2.height))
            {
                return (var_1647);
            };
            return (var_1660);
        }

        private function purgeItems():void
        {
            var _loc2_:RoomChatItem;
            if (this.historyViewerActive())
            {
                return;
            };
            var _loc1_:int;
            var _loc3_:int;
            while (this._itemList.length > this.var_5459)
            {
                _loc2_ = this._itemList.shift();
                _loc3_ = this.var_5451.indexOf(_loc2_);
                if (_loc3_ > -1)
                {
                    this.var_5451.splice(_loc3_, 1);
                };
                if (_loc2_.view != null)
                {
                    this.var_5446.removeChild(_loc2_.view);
                    _loc2_.hideView();
                };
                _loc2_.dispose();
                _loc2_ = null;
            };
            var _loc4_:Boolean;
            _loc1_ = 0;
            while (_loc1_ < this._itemList.length)
            {
                _loc2_ = this._itemList[_loc1_];
                if (_loc2_ != null)
                {
                    if (_loc2_.y <= -(var_1659))
                    {
                        _loc2_.aboveLevels = 1;
                        if (_loc2_.view != null)
                        {
                            _loc3_ = this.var_5451.indexOf(_loc2_);
                            if (_loc3_ > -1)
                            {
                                this.var_5451.splice(_loc3_, 1);
                            };
                            this.var_5446.removeChild(_loc2_.view);
                            _loc2_.hideView();
                        };
                    }
                    else
                    {
                        _loc4_ = true;
                        break;
                    };
                };
                _loc1_++;
            };
            if (this.var_5450.length > 0)
            {
                _loc4_ = true;
            };
            if ((((this.getTotalContentHeight() > var_1647) && (!(_loc4_))) && (!(this.historyViewerActive()))))
            {
                if (this.var_5447 != null)
                {
                    this.stretchAreaBottomTo(this.var_5415.y);
                    this.alignItems();
                    if (!this.historyViewerActive())
                    {
                        this.var_5447.showHistoryViewer();
                    };
                    if (!this.historyViewerVisible())
                    {
                        this.var_5447.visible = true;
                    };
                };
            }
            else
            {
                if (this.historyViewerVisible())
                {
                    this.var_5447.visible = false;
                };
            };
        }

        private function getFreeItemId():String
        {
            return ((("chat_" + this.var_5452.toString()) + "_item_") + this.var_5453++.toString());
        }

        public function onItemMouseClick(param1:int, param2:String, param3:int, param4:int, param5:int, param6:WindowMouseEvent):void
        {
            if (param6.shiftKey)
            {
                if (this.var_5447 != null)
                {
                    this.var_5447.toggleHistoryViewer();
                };
                return;
            };
            var _loc7_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.var_1661, param1, param3);
            messageListener.processWidgetMessage(_loc7_);
            var _loc8_:RoomWidgetChatSelectAvatarMessage = new RoomWidgetChatSelectAvatarMessage(RoomWidgetChatSelectAvatarMessage.var_1662, param1, param2, param4, param5);
            messageListener.processWidgetMessage(_loc8_);
        }

        public function onItemMouseDown(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent):void
        {
            if (this.historyViewerVisible())
            {
                return;
            };
            if (this.var_5447 != null)
            {
                this.var_5447.beginDrag(param5.stageY);
            };
        }

        public function onItemMouseOver(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent):void
        {
        }

        public function onItemMouseOut(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent):void
        {
        }

        public function onPulldownMouseDown(param1:WindowMouseEvent):void
        {
            if (this.var_5447 != null)
            {
                this.var_5447.beginDrag(param1.stageY, true);
            };
        }

        public function onPulldownCloseButtonClicked(param1:WindowMouseEvent):void
        {
            if (this.var_5447 != null)
            {
                this.var_5447.hideHistoryViewer();
            };
        }

        public function stretchAreaBottomBy(param1:Number):void
        {
            var _loc2_:Number = ((this.var_5415.rectangle.bottom + param1) - RoomChatHistoryPulldown.var_1648);
            this.stretchAreaBottomTo(_loc2_);
        }

        public function stretchAreaBottomTo(param1:Number):void
        {
            var _loc2_:int = ((this.var_5415.context.getDesktopWindow().height - RoomChatHistoryPulldown.var_1648) - var_1663);
            param1 = Math.min(param1, _loc2_);
            this.var_5444 = (param1 - this.var_5415.y);
            this.var_5415.height = (this.var_5444 + RoomChatHistoryPulldown.var_1648);
            if (this.var_5447 != null)
            {
                this.var_5447.containerResized(this.var_5415.rectangle);
            };
        }

        public function resetArea():void
        {
            if (this.var_5447 == null)
            {
                return;
            };
            this.animationStop();
            this.var_5444 = (var_1664 + var_1658);
            this.var_5415.height = (this.var_5444 + this.var_5447.pulldownBarHeight);
            this.var_5445.width = (this.var_5415.width - this.var_5447.scrollbarWidth);
            this.var_5445.height = this.var_5444;
            this.var_5446.width = (this.var_5415.width - this.var_5447.scrollbarWidth);
            if (this.historyViewerActive())
            {
                this.var_5446.height = (this.getTotalContentHeight() + var_1658);
            }
            else
            {
                this.var_5446.height = this.var_5444;
            };
            this.var_5445.scrollV = 1;
            if (!this.historyViewerActive())
            {
                this.var_5447.containerResized(this.var_5415.rectangle);
            };
            this.purgeItems();
            this.alignItems();
        }

        private function historyViewerActive():Boolean
        {
            return ((this.var_5447 == null) ? false : this.var_5447.active);
        }

        private function historyViewerVisible():Boolean
        {
            return ((this.var_5447 == null) ? false : this.var_5447.visible);
        }

        public function hideHistoryViewer():void
        {
            if (this.var_5447 != null)
            {
                this.var_5447.hideHistoryViewer();
            };
        }

        private function historyViewerMinimized():Boolean
        {
            return (this.var_5445.height <= 1);
        }

        public function resizeContainerToLowestItem():void
        {
            var _loc4_:RoomChatItem;
            var _loc1_:int;
            var _loc2_:int;
            while (_loc2_ < this._itemList.length)
            {
                _loc4_ = this._itemList[_loc2_];
                if (_loc4_.y > _loc1_)
                {
                    _loc1_ = _loc4_.y;
                };
                _loc2_++;
            };
            _loc2_ = 0;
            while (_loc2_ < this.var_5450.length)
            {
                _loc4_ = this.var_5450[_loc2_];
                if (_loc4_.y > _loc1_)
                {
                    _loc1_ = _loc4_.y;
                };
                _loc2_++;
            };
            _loc1_ = (_loc1_ + var_1659);
            _loc1_ = ((_loc1_ < 0) ? 0 : _loc1_);
            var _loc3_:int = this.var_5415.rectangle.bottom;
            this.stretchAreaBottomTo((this.var_5415.rectangle.top + _loc1_));
            _loc3_ = (_loc3_ - this.var_5415.rectangle.bottom);
            if (Math.abs(_loc3_) < RoomChatHistoryViewer.var_1665)
            {
                this.resetArea();
                return;
            };
            _loc2_ = 0;
            while (_loc2_ < this._itemList.length)
            {
                _loc4_ = this._itemList[_loc2_];
                _loc4_.y = (_loc4_.y + _loc3_);
                _loc2_++;
            };
            _loc2_ = 0;
            while (_loc2_ < this.var_5450.length)
            {
                _loc4_ = this.var_5450[_loc2_];
                _loc4_.y = (_loc4_.y + _loc3_);
                _loc2_++;
            };
            this.var_5458 = true;
        }

        public function mouseUp():void
        {
            var _loc1_:Number = (this.var_5415.rectangle.bottom - RoomChatHistoryPulldown.var_1648);
            if (_loc1_ < var_1664)
            {
                if (_loc1_ <= (this.var_5444 + this.var_5415.y))
                {
                    if (this.historyViewerActive())
                    {
                        this.hideHistoryViewer();
                    };
                    this.resetArea();
                    return;
                };
            };
            if (((this.var_5458) && (!(this.historyViewerActive()))))
            {
                this.resetArea();
                this.var_5458 = false;
            };
        }

        public function reAlignItemsToHistoryContent():void
        {
            if (this.historyViewerActive())
            {
                this.var_5446.height = (this.getTotalContentHeight() + var_1658);
                this.alignItems();
            };
        }

        public function enableDragTooltips():void
        {
            var _loc2_:int;
            var _loc1_:RoomChatItem;
            _loc2_ = 0;
            while (_loc2_ < this._itemList.length)
            {
                _loc1_ = this._itemList[_loc2_];
                _loc1_.enableTooltip();
                _loc2_++;
            };
            _loc2_ = 0;
            while (_loc2_ < this.var_5450.length)
            {
                _loc1_ = this.var_5450[_loc2_];
                _loc1_.enableTooltip();
                _loc2_++;
            };
        }

        public function disableDragTooltips():void
        {
            var _loc2_:int;
            var _loc1_:RoomChatItem;
            _loc2_ = 0;
            while (_loc2_ < this._itemList.length)
            {
                _loc1_ = this._itemList[_loc2_];
                _loc1_.disableTooltip();
                _loc2_++;
            };
            _loc2_ = 0;
            while (_loc2_ < this.var_5450.length)
            {
                _loc1_ = this.var_5450[_loc2_];
                _loc1_.disableTooltip();
                _loc2_++;
            };
        }


    }
}