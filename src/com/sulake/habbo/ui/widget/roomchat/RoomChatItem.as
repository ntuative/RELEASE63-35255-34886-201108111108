package com.sulake.habbo.ui.widget.roomchat
{
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;
    import flash.text.TextFormat;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;
    import flash.geom.ColorTransform;
    import flash.display.BlendMode;
    import flash.geom.Matrix;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.utils.HabboWebTools;

    public class RoomChatItem 
    {

        private static const var_2351:Number = 18;
        private static const var_2353:int = 6;
        private static const var_2355:int = 6;
        private static const var_2354:int = 35;
        private static const var_316:String = "name";
        private static const var_2094:String = "message";
        private static const var_2352:String = "pointer";
        private static const var_20:String = "background";
        private static var var_2350:IRegionWindow;
        private static var var_2348:IRegionWindow;
        private static var var_2347:IRegionWindow;
        private static var var_2349:IRegionWindow;

        private var _widget:RoomChatWidget;
        private var _windowManager:IHabboWindowManager;
        private var var_1600:IHabboLocalizationManager;
        private var _window:IRegionWindow;
        private var _assetLibrary:IAssetLibrary;
        private var _id:String;
        private var var_5433:String;
        private var var_5434:int = 0;
        private var var_5435:int = -1;
        private var var_4968:int;
        private var var_3670:int;
        private var var_3389:String = new String();
        private var _message:String = new String();
        private var var_5436:Array;
        private var var_5437:Array;
        private var var_3737:int;
        private var var_5438:Number;
        private var var_5439:BitmapData;
        private var var_5440:uint;
        private var _roomId:int;
        private var _roomCategory:int;
        private var var_5441:int;
        private var var_2731:Number = 0;
        private var var_5442:Boolean = false;
        private var var_5443:Number = 0;
        private var _x:Number = 0;
        private var var_2960:Number = 0;

        public function RoomChatItem(param1:RoomChatWidget, param2:IHabboWindowManager, param3:IAssetLibrary, param4:String, param5:IHabboLocalizationManager, param6:String)
        {
            this._widget = param1;
            this._windowManager = param2;
            this._assetLibrary = param3;
            this._id = param4;
            this.var_1600 = param5;
            this.var_5433 = param6;
            if (((((!(var_2347)) || (!(var_2348))) || (!(var_2349))) || (!(var_2350))))
            {
                var_2347 = this.buildBubbleWindow("bubble_speak");
                var_2348 = this.buildBubbleWindow("bubble_shout");
                var_2349 = this.buildBubbleWindow("bubble_whisper");
                var_2350 = this.buildBubbleWindow("bubble_whisper");
            };
        }

        private function buildBubbleWindow(param1:String):IRegionWindow
        {
            var _loc2_:IRegionWindow = (this._windowManager.buildFromXML((this._assetLibrary.getAssetByName(param1).content as XML), 1) as IRegionWindow);
            _loc2_.tags.push("roomchat_bubble");
            _loc2_.x = 0;
            _loc2_.y = 0;
            _loc2_.width = 0;
            _loc2_.background = true;
            _loc2_.mouseThreshold = 0;
            _loc2_.setParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING, true);
            return (_loc2_);
        }

        public function dispose():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
                this._widget = null;
                this._windowManager = null;
                this.var_1600 = null;
                this.var_5439 = null;
            };
        }

        public function define(param1:RoomWidgetChatUpdateEvent):void
        {
            this.var_4968 = param1.chatType;
            this.var_3670 = param1.userId;
            this.var_3389 = param1.userName;
            this.var_5441 = param1.userCategory;
            this._message = param1.text;
            this.var_5436 = param1.links;
            this.var_5438 = param1.userX;
            this.var_5439 = param1.userImage;
            this.var_5440 = param1.userColor;
            this._roomId = param1.roomId;
            this._roomCategory = param1.roomCategory;
            this.renderView();
        }

        public function get view():IWindowContainer
        {
            return (this._window);
        }

        public function get screenLevel():int
        {
            return (this.var_5435);
        }

        public function get timeStamp():int
        {
            return (this.var_3737);
        }

        public function get senderX():Number
        {
            return (this.var_5438);
        }

        public function set senderX(param1:Number):void
        {
            this.var_5438 = param1;
        }

        public function get width():Number
        {
            return (this.var_2731);
        }

        public function get height():Number
        {
            return (var_2351);
        }

        public function get message():String
        {
            return (this._message);
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function get y():Number
        {
            return (this.var_2960);
        }

        public function get aboveLevels():int
        {
            return (this.var_5434);
        }

        public function set aboveLevels(param1:int):void
        {
            this.var_5434 = param1;
        }

        public function set screenLevel(param1:int):void
        {
            this.var_5435 = param1;
        }

        public function set timeStamp(param1:int):void
        {
            this.var_3737 = param1;
        }

        public function set x(param1:Number):void
        {
            this._x = param1;
            if (this._window != null)
            {
                this._window.x = param1;
            };
        }

        public function set y(param1:Number):void
        {
            this.var_2960 = param1;
            if (this._window != null)
            {
                this._window.y = (param1 - this.var_5443);
            };
        }

        public function hidePointer():void
        {
            if (this._window)
            {
                this._window.findChildByName("pointer").visible = false;
            };
        }

        public function setPointerOffset(param1:Number):void
        {
            if (((!(this._window)) || (this._window.disposed)))
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("pointer") as IBitmapWrapperWindow);
            var _loc3_:IBitmapWrapperWindow = (this._window.findChildByName("middle") as IBitmapWrapperWindow);
            if (((_loc3_ == null) || (_loc2_ == null)))
            {
                return;
            };
            _loc2_.visible = true;
            param1 = (param1 + (this._window.width / 2));
            param1 = Math.min(param1, (_loc3_.rectangle.right - _loc2_.width));
            param1 = Math.max(param1, _loc3_.rectangle.left);
            _loc2_.x = param1;
        }

        public function checkOverlap(param1:Number, param2:Number, param3:Number, param4:Number):Boolean
        {
            var _loc5_:Rectangle = new Rectangle(this._x, this.var_2960, this.width, var_2351);
            var _loc6_:Rectangle = new Rectangle(param1, param2, param3, param4);
            return (_loc5_.intersects(_loc6_));
        }

        public function hideView():void
        {
            if (this._window)
            {
                this._window.dispose();
            };
            this._window = null;
            this.var_5442 = false;
        }

        public function renderView():void
        {
            var messageWidth:int;
            var x1:int;
            var y1:int;
            var userIconWindow:IBitmapWrapperWindow;
            var i:int;
            var lastLinkEndPos:int;
            var linkFormat:TextFormat;
            var filteredLink:String;
            var placeHolder:String;
            var placeholderPos:int;
            var linkPos:Array;
            if (this.var_5442)
            {
                return;
            };
            this.var_5442 = true;
            if (this._window)
            {
                return;
            };
            var isRespect:Boolean;
            switch (this.var_4968)
            {
                case RoomWidgetChatUpdateEvent.var_542:
                    this._window = (var_2347.clone() as IRegionWindow);
                    break;
                case RoomWidgetChatUpdateEvent.var_545:
                    this._window = (var_2349.clone() as IRegionWindow);
                    break;
                case RoomWidgetChatUpdateEvent.var_546:
                    this._window = (var_2348.clone() as IRegionWindow);
                    break;
                case RoomWidgetChatUpdateEvent.var_543:
                    this._window = (var_2350.clone() as IRegionWindow);
                    isRespect = true;
                    break;
                case RoomWidgetChatUpdateEvent.var_544:
                    this._window = (var_2350.clone() as IRegionWindow);
                    isRespect = true;
                    break;
            };
            var background:IBitmapWrapperWindow = (this._window.findChildByName(var_20) as IBitmapWrapperWindow);
            var nameWindow:ILabelWindow = (this._window.findChildByName(var_316) as ILabelWindow);
            var textWindow:ITextWindow = (this._window.findChildByName(var_2094) as ITextWindow);
            var pointerWindow:IBitmapWrapperWindow = (this._window.findChildByName(var_2352) as IBitmapWrapperWindow);
            var pointerBitmapData:BitmapData = (this._assetLibrary.getAssetByName("chat_bubble_pointer").content as BitmapData);
            var totalHeight:Number = this._window.height;
            var topOffset:int;
            if (this.var_5439 != null)
            {
                topOffset = int(Math.max(0, ((this.var_5439.height - background.height) / 2)));
                totalHeight = Math.max(totalHeight, this.var_5439.height);
            };
            this.var_2731 = 0;
            this._window.x = this._x;
            this._window.y = this.var_2960;
            this._window.width = 0;
            this._window.height = totalHeight;
            this.enableTooltip();
            this.addEventListeners(this._window);
            if (((this.var_5439) && (!(isRespect))))
            {
                x1 = int((14 - (this.var_5439.width / 2)));
                y1 = int(Math.max(0, ((background.height - this.var_5439.height) / 2)));
                userIconWindow = (this._window.findChildByName("user_image") as IBitmapWrapperWindow);
                if (userIconWindow)
                {
                    userIconWindow.width = this.var_5439.width;
                    userIconWindow.height = this.var_5439.height;
                    userIconWindow.bitmap = this.var_5439;
                    userIconWindow.disposesBitmap = false;
                    userIconWindow.x = x1;
                    userIconWindow.y = y1;
                    this.var_5443 = Math.max(0, ((this.var_5439.height - background.height) / 2));
                    this.var_2731 = (this.var_2731 + (userIconWindow.x + this.var_5439.width));
                };
            };
            if (nameWindow != null)
            {
                if (!isRespect)
                {
                    nameWindow.text = (this.var_3389 + ": ");
                    nameWindow.y = (nameWindow.y + this.var_5443);
                    nameWindow.width = (nameWindow.textWidth + var_2353);
                }
                else
                {
                    nameWindow.text = "";
                    nameWindow.width = 0;
                };
                this.var_2731 = (this.var_2731 + nameWindow.width);
            };
            if (this.var_4968 == RoomWidgetChatUpdateEvent.var_543)
            {
                textWindow.text = this.var_1600.registerParameter("widgets.chatbubble.respect", "username", this.var_3389);
                this.var_2731 = var_2354;
            }
            else
            {
                if (this.var_4968 == RoomWidgetChatUpdateEvent.var_544)
                {
                    textWindow.text = this.var_1600.registerParameter("widget.chatbubble.petrespect", "petname", this.var_3389);
                    this.var_2731 = var_2354;
                }
                else
                {
                    if (this.var_5436 == null)
                    {
                        textWindow.text = this.message;
                    }
                    else
                    {
                        this.var_5437 = new Array();
                        lastLinkEndPos = -1;
                        i = 0;
                        while (i < this.var_5436.length)
                        {
                            filteredLink = this.var_5436[i][1];
                            placeHolder = (("{" + i) + "}");
                            placeholderPos = this._message.indexOf(placeHolder);
                            lastLinkEndPos = (placeholderPos + filteredLink.length);
                            this.var_5437.push([placeholderPos, lastLinkEndPos]);
                            this._message = this._message.replace(placeHolder, filteredLink);
                            i = (i + 1);
                        };
                        textWindow.text = this.message;
                        textWindow.immediateClickMode = true;
                        textWindow.setParamFlag(WindowParam.var_713, false);
                        textWindow.setParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING, true);
                        linkFormat = textWindow.getTextFormat();
                        linkFormat.color = 2710438;
                        linkFormat.underline = true;
                        i = 0;
                        while (i < this.var_5437.length)
                        {
                            linkPos = this.var_5437[i];
                            try
                            {
                                textWindow.setTextFormat(linkFormat, linkPos[0], linkPos[1]);
                            }
                            catch(e:RangeError)
                            {
                                Logger.log("Chat message links were malformed. Could not set TextFormat");
                            };
                            i = (i + 1);
                        };
                    };
                };
            };
            if (textWindow.visible)
            {
                textWindow.x = this.var_2731;
                if (nameWindow != null)
                {
                    textWindow.x = (nameWindow.x + nameWindow.width);
                    if (nameWindow.width > var_2353)
                    {
                        textWindow.x = (textWindow.x - (var_2353 - 1));
                    };
                };
                textWindow.y = (textWindow.y + this.var_5443);
                messageWidth = textWindow.textWidth;
                textWindow.width = (messageWidth + var_2355);
                this.var_2731 = (this.var_2731 + textWindow.width);
            };
            if (((!(pointerWindow == null)) && (pointerWindow.visible)))
            {
                pointerWindow.bitmap = pointerBitmapData;
                pointerWindow.disposesBitmap = false;
                pointerWindow.x = (this.var_2731 / 2);
                pointerWindow.y = (pointerWindow.y + this.var_5443);
            };
            var bitmap:BitmapData = this.buildBubbleImage((nameWindow.width + textWindow.width), background.height, this.var_5440, isRespect);
            this._window.width = bitmap.width;
            this._window.y = (this._window.y - this.var_5443);
            this.var_2731 = this._window.width;
            background.bitmap = bitmap;
            background.y = this.var_5443;
        }

        private function buildBubbleImage(param1:int, param2:int, param3:uint, param4:Boolean):BitmapData
        {
            var _loc13_:BitmapData;
            var _loc14_:uint;
            var _loc15_:uint;
            var _loc16_:uint;
            var _loc5_:BitmapData = (this._assetLibrary.getAssetByName("chat_bubble_left").content as BitmapData);
            var _loc6_:BitmapData = (this._assetLibrary.getAssetByName("chat_bubble_middle").content as BitmapData);
            var _loc7_:BitmapData = (this._assetLibrary.getAssetByName("chat_bubble_left_color").content as BitmapData);
            var _loc8_:BitmapData = (this._assetLibrary.getAssetByName("chat_bubble_right").content as BitmapData);
            var _loc9_:int;
            var _loc10_:Point = new Point();
            var _loc11_:BitmapData = new BitmapData(((_loc5_.width + param1) + _loc8_.width), param2, true, 0xFF00FF);
            _loc9_ = (_loc9_ + _loc5_.width);
            _loc11_.copyPixels(_loc5_, _loc5_.rect, _loc10_);
            if (param4)
            {
                _loc13_ = (this._assetLibrary.getAssetByName("chat_bubble_left_gen").content as BitmapData);
                _loc11_.copyPixels(_loc13_, _loc13_.rect, _loc10_, null, null, true);
            }
            else
            {
                _loc14_ = 232;
                _loc15_ = 177;
                _loc16_ = 55;
                if (param3 != 0)
                {
                    _loc14_ = ((param3 >> 16) & 0xFF);
                    _loc15_ = ((param3 >> 8) & 0xFF);
                    _loc16_ = ((param3 >> 0) & 0xFF);
                };
                _loc11_.draw(_loc7_, null, new ColorTransform((_loc14_ / 0xFF), (_loc15_ / 0xFF), (_loc16_ / 0xFF)), BlendMode.DARKEN);
            };
            var _loc12_:Matrix = new Matrix();
            _loc12_.scale((param1 / _loc6_.width), 1);
            _loc12_.translate(_loc9_, 0);
            _loc11_.draw(_loc6_, _loc12_);
            _loc9_ = (_loc9_ + param1);
            _loc10_.x = _loc9_;
            _loc11_.copyPixels(_loc8_, _loc8_.rect, _loc10_);
            _loc9_ = (_loc9_ + _loc8_.width);
            return (_loc11_);
        }

        public function enableTooltip():void
        {
            if (this._window != null)
            {
                this._window.toolTipCaption = "${chat.history.drag.tooltip}";
                this._window.toolTipDelay = 500;
            };
        }

        public function disableTooltip():void
        {
            if (this._window != null)
            {
                this._window.toolTipCaption = "";
            };
        }

        private function addEventListeners(param1:IWindowContainer):void
        {
            param1.setParamFlag(HabboWindowParam.var_158, true);
            param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBubbleMouseClick);
            param1.addEventListener(WindowMouseEvent.var_650, this.onBubbleMouseDown);
            param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onBubbleMouseOver);
            param1.addEventListener(WindowMouseEvent.var_624, this.onBubbleMouseOut);
            param1.addEventListener(WindowMouseEvent.var_655, this.onBubbleMouseUp);
        }

        private function testMessageLinkMouseClick(param1:int, param2:int):Boolean
        {
            var _loc5_:int;
            var _loc3_:ITextWindow = (this._window.getChildByName(var_2094) as ITextWindow);
            var _loc4_:int = _loc3_.getCharIndexAtPoint((param1 - _loc3_.x), (param2 - _loc3_.y));
            if (_loc4_ > -1)
            {
                _loc5_ = 0;
                while (_loc5_ < this.var_5437.length)
                {
                    if (((_loc4_ >= this.var_5437[_loc5_][0]) && (_loc4_ <= this.var_5437[_loc5_][1])))
                    {
                        if (this.var_5436[_loc5_][2] == 0)
                        {
                            HabboWebTools.openExternalLinkWarning(this.var_5436[_loc5_][0]);
                        }
                        else
                        {
                            if (this.var_5436[_loc5_][2] == 1)
                            {
                                HabboWebTools.openWebPage((this.var_5433 + this.var_5436[_loc5_][0]), "habboMain");
                            }
                            else
                            {
                                HabboWebTools.openWebPage((this.var_5433 + this.var_5436[_loc5_][0]));
                            };
                        };
                        return (true);
                    };
                    _loc5_++;
                };
            };
            return (false);
        }

        private function onBubbleMouseClick(param1:WindowMouseEvent):void
        {
            if (((this.var_5436) && (this.var_5436.length > 0)))
            {
                if (this.testMessageLinkMouseClick(param1.localX, param1.localY))
                {
                    return;
                };
            };
            this._widget.onItemMouseClick(this.var_3670, this.var_3389, this.var_5441, this._roomId, this._roomCategory, param1);
        }

        private function onBubbleMouseDown(param1:WindowMouseEvent):void
        {
            this._widget.onItemMouseDown(this.var_3670, this.var_5441, this._roomId, this._roomCategory, param1);
        }

        private function onBubbleMouseOver(param1:WindowMouseEvent):void
        {
            this._widget.onItemMouseOver(this.var_3670, this.var_5441, this._roomId, this._roomCategory, param1);
        }

        private function onBubbleMouseOut(param1:WindowMouseEvent):void
        {
            this._widget.onItemMouseOut(this.var_3670, this.var_5441, this._roomId, this._roomCategory, param1);
        }

        private function onBubbleMouseUp(param1:WindowMouseEvent):void
        {
            this._widget.mouseUp();
        }


    }
}