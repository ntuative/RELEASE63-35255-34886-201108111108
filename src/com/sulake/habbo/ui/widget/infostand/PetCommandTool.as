package com.sulake.habbo.ui.widget.infostand
{
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.utils.Map;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPetCommandMessage;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import flash.geom.Rectangle;

    public class PetCommandTool 
    {

        private static const var_1728:Point = new Point(100, 30);

        private const var_5355:int = 1100;

        private var _widget:InfostandWidget;
        private var var_5357:IFrameWindow;
        private var var_5358:IFrameWindow;
        private var var_3833:Map;
        private var var_5328:int;
        private var var_5359:String;
        private var var_5356:Timer;

        public function PetCommandTool(param1:InfostandWidget)
        {
            this._widget = param1;
            this.var_3833 = new Map();
            this.var_5356 = new Timer(this.var_5355);
            this.var_5356.addEventListener(TimerEvent.TIMER, this.onButtonDisableTimeout);
        }

        public static function hideChildren(param1:IWindowContainer):void
        {
            var _loc2_:int;
            while (_loc2_ < param1.numChildren)
            {
                param1.getChildAt(_loc2_).visible = false;
                _loc2_++;
            };
        }

        public static function getLowestPoint(param1:IWindowContainer):int
        {
            var _loc4_:IWindow;
            var _loc2_:int;
            var _loc3_:int;
            while (_loc3_ < param1.numChildren)
            {
                _loc4_ = param1.getChildAt(_loc3_);
                if (_loc4_.visible)
                {
                    _loc2_ = Math.max(_loc2_, (_loc4_.y + _loc4_.height));
                };
                _loc3_++;
            };
            return (_loc2_);
        }


        public function dispose():void
        {
            if (this.var_5356)
            {
                this.var_5356.stop();
                this.var_5356 = null;
            };
            if (this._widget)
            {
                this._widget = null;
            };
            if (this.var_5357)
            {
                this.var_5357.dispose();
            };
            this.var_5357 = null;
            if (this.var_5358)
            {
                this.var_5358.dispose();
            };
            this.var_5358 = null;
        }

        public function getPetId():int
        {
            return (this.var_5328);
        }

        public function isVisible():Boolean
        {
            if (this.var_5357 == null)
            {
                return (false);
            };
            return (this.var_5357.visible);
        }

        public function showCommandToolForPet(param1:int, param2:String, param3:BitmapData=null):void
        {
            var _loc7_:BitmapData;
            var _loc8_:Point;
            if (this.var_5328 == param1)
            {
                return;
            };
            this.var_5328 = param1;
            this.var_5359 = param2;
            if (this.var_5357 == null)
            {
                return;
            };
            var _loc4_:ITextWindow = (this.var_5357.findChildByName("pet_name") as ITextWindow);
            if (_loc4_ != null)
            {
                _loc4_.text = param2;
            };
            var _loc5_:IBitmapWrapperWindow = (this.var_5357.findChildByName("avatar_image") as IBitmapWrapperWindow);
            if (_loc5_ != null)
            {
                if (param3 != null)
                {
                    _loc7_ = new BitmapData(_loc5_.width, _loc5_.height, true, 0);
                    _loc8_ = new Point(0, 0);
                    _loc8_.x = Math.round(((_loc5_.width - param3.width) / 2));
                    _loc8_.y = Math.round(((_loc5_.height - param3.height) / 2));
                    _loc7_.copyPixels(param3, param3.rect, _loc8_);
                    _loc5_.bitmap = _loc7_;
                }
                else
                {
                    _loc5_.bitmap = null;
                };
                _loc5_.invalidate();
            };
            var _loc6_:CommandConfiguration = (this.var_3833.getValue(param1) as CommandConfiguration);
            if (_loc6_ == null)
            {
                this.disableAllButtons();
                this.requestEnabledCommands(this.var_5328);
            }
            else
            {
                this.updateCommandButtonsViewState(_loc6_);
            };
        }

        private function onButtonDisableTimeout(param1:TimerEvent):void
        {
            var _loc2_:CommandConfiguration = (this.var_3833.getValue(this.var_5328) as CommandConfiguration);
            this.updateCommandButtonsViewState(_loc2_);
            this.var_5356.stop();
        }

        public function setEnabledCommands(param1:int, param2:CommandConfiguration):void
        {
            this.var_3833.remove(param1);
            this.var_3833.add(param1, param2);
            if (param1 != this.var_5328)
            {
                return;
            };
            this.updateCommandButtonsViewState(param2);
            this.var_5356.stop();
        }

        public function showWindow(param1:Boolean):void
        {
            if (param1)
            {
                if (this.var_5357 == null)
                {
                    this.createCommandWindow();
                };
                this.var_5357.visible = true;
            }
            else
            {
                if (this.var_5357 != null)
                {
                    this.var_5357.visible = false;
                };
            };
            this.var_5356.stop();
        }

        private function requestEnabledCommands(param1:int):void
        {
            var _loc2_:RoomWidgetPetCommandMessage = new RoomWidgetPetCommandMessage(RoomWidgetPetCommandMessage.var_2309, param1);
            this._widget.messageListener.processWidgetMessage(_loc2_);
        }

        private function createCommandWindow():void
        {
            var _loc1_:XmlAsset = (this._widget.assets.getAssetByName("pet_commands") as XmlAsset);
            this.var_5357 = (this._widget.windowManager.buildFromXML((_loc1_.content as XML)) as IFrameWindow);
            if (this.var_5357 == null)
            {
                throw (new Error("Failed to construct command window from XML!"));
            };
            this.var_5357.setParamFlag(WindowParam.var_711, true);
            this.var_5357.context.getDesktopWindow().addEventListener(WindowEvent.var_589, this.onWindowDesktopResized);
            this.var_5357.procedure = this.onCommandWindowProcedure;
            this.var_5357.position = var_1728;
        }

        private function updateCommandButtonsViewState(param1:CommandConfiguration):void
        {
            var _loc9_:IButtonWindow;
            var _loc10_:int;
            var _loc11_:XmlAsset;
            if (this.var_5357 == null)
            {
                return;
            };
            var _loc2_:IWindowContainer = IWindowContainer(this.var_5357.findChildByName("commands_container"));
            hideChildren(_loc2_);
            var _loc3_:Array = param1.allCommandIds;
            var _loc4_:int = 25;
            var _loc5_:int;
            var _loc6_:int = 86;
            var _loc7_:int;
            var _loc8_:int;
            while (_loc8_ < _loc3_.length)
            {
                _loc9_ = IButtonWindow(_loc2_.getChildAt(_loc8_));
                if (_loc9_ == null)
                {
                    _loc11_ = (this._widget.assets.getAssetByName("pet_command") as XmlAsset);
                    _loc9_ = (this._widget.windowManager.buildFromXML((_loc11_.content as XML)) as IButtonWindow);
                    _loc9_.procedure = this.onTrainButton;
                    _loc2_.addChild(_loc9_);
                };
                _loc9_.visible = true;
                _loc10_ = _loc3_[_loc8_];
                _loc9_.id = _loc10_;
                _loc9_.caption = this._widget.localizations.getKey(("pet.command." + _loc10_));
                if (param1.isEnabled(_loc10_))
                {
                    _loc9_.enable();
                }
                else
                {
                    _loc9_.disable();
                };
                _loc9_.y = _loc7_;
                if ((_loc8_ % 2) == 1)
                {
                    _loc7_ = (_loc7_ + _loc4_);
                    _loc9_.x = _loc6_;
                }
                else
                {
                    _loc9_.x = _loc5_;
                };
                _loc8_++;
            };
            _loc2_.height = getLowestPoint(_loc2_);
            this.var_5357.height = (_loc2_.height + 160);
            this.var_5356.stop();
        }

        private function disableAllButtons():void
        {
            var _loc3_:IButtonWindow;
            if (this.var_5357 == null)
            {
                return;
            };
            var _loc1_:IWindowContainer = IWindowContainer(this.var_5357.findChildByName("commands_container"));
            var _loc2_:int;
            while (_loc2_ < _loc1_.numChildren)
            {
                _loc3_ = IButtonWindow(_loc1_.getChildAt(_loc2_));
                _loc3_.disable();
                _loc2_++;
            };
        }

        private function openInfoWindow():void
        {
            var _loc1_:XmlAsset;
            if (this.var_5358 == null)
            {
                _loc1_ = (this._widget.assets.getAssetByName("pet_commands_info") as XmlAsset);
                this.var_5358 = (this._widget.windowManager.buildFromXML((_loc1_.content as XML)) as IFrameWindow);
                if (this.var_5358 == null)
                {
                    throw (new Error("Failed to construct command info window from XML!"));
                };
                this.var_5358.x = 200;
                this.var_5358.procedure = this.onInfoWindowProcedure;
            }
            else
            {
                this.var_5358.visible = true;
            };
        }

        private function onInfoWindowProcedure(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:WindowMouseEvent = (param1 as WindowMouseEvent);
            if (((!(_loc3_ == null)) && (_loc3_.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)))
            {
                if (param2.name == "header_button_close")
                {
                    this.var_5358.visible = false;
                };
            };
        }

        private function onCommandWindowProcedure(param1:WindowEvent, param2:IWindow):void
        {
            var _loc4_:int;
            var _loc5_:String;
            var _loc6_:String;
            var _loc7_:RoomWidgetPetCommandMessage;
            var _loc3_:WindowMouseEvent = (param1 as WindowMouseEvent);
            if (((!(_loc3_ == null)) && (_loc3_.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)))
            {
                if (param2.name == "header_button_close")
                {
                    this.var_5357.visible = false;
                }
                else
                {
                    if (param2.name == "description_link")
                    {
                        this.openInfoWindow();
                    }
                    else
                    {
                        if (param2.name == "avatar_image")
                        {
                            this._widget.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.var_1708, this.var_5328));
                        }
                        else
                        {
                            if (param2.name.indexOf("btn_cmd_") > -1)
                            {
                                _loc4_ = int(param2.name.substring(8));
                                _loc5_ = ("pet.command." + _loc4_);
                                _loc6_ = this._widget.localizations.getKey(_loc5_);
                                _loc7_ = new RoomWidgetPetCommandMessage(RoomWidgetPetCommandMessage.var_2308, this.var_5328, ((this.var_5359 + " ") + _loc6_));
                                this._widget.messageListener.processWidgetMessage(_loc7_);
                                this.disableAllButtons();
                                this.var_5356.start();
                            };
                        };
                    };
                };
            };
        }

        private function onTrainButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:int = param2.id;
            var _loc4_:String = ("pet.command." + _loc3_);
            var _loc5_:String = this._widget.localizations.getKey(_loc4_);
            var _loc6_:RoomWidgetPetCommandMessage = new RoomWidgetPetCommandMessage(RoomWidgetPetCommandMessage.var_2308, this.var_5328, ((this.var_5359 + " ") + _loc5_));
            this._widget.messageListener.processWidgetMessage(_loc6_);
            this.disableAllButtons();
            this.var_5356.start();
        }

        private function onWindowDesktopResized(param1:WindowEvent):void
        {
            var _loc2_:IWindow;
            var _loc3_:Rectangle;
            if (((this.var_5357) && (!(this.var_5357.disposed))))
            {
                _loc2_ = param1.window;
                _loc3_ = new Rectangle();
                this.var_5357.getGlobalRectangle(_loc3_);
                if (_loc3_.x > _loc2_.width)
                {
                    this.var_5357.x = (_loc2_.width - this.var_5357.width);
                    this.var_5357.getGlobalRectangle(_loc3_);
                };
                if ((_loc3_.x + _loc3_.width) <= 0)
                {
                    this.var_5357.x = 0;
                    this.var_5357.getGlobalRectangle(_loc3_);
                };
                if (_loc3_.y > _loc2_.height)
                {
                    this.var_5357.y = 0;
                    this.var_5357.getGlobalRectangle(_loc3_);
                };
                if ((_loc3_.y + _loc3_.height) <= 0)
                {
                    this.var_5357.y = 0;
                    this.var_5357.getGlobalRectangle(_loc3_);
                };
            };
        }


    }
}