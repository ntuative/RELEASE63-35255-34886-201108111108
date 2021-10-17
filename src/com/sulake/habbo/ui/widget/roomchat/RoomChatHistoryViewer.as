package com.sulake.habbo.ui.widget.roomchat
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IScrollableWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.DisplayObject;
    import flash.display.Stage;
    import flash.events.MouseEvent;

    public class RoomChatHistoryViewer implements IDisposable 
    {

        private static const var_2344:int = 18;
        private static const SCROLLBAR_WIDTH:int = 20;
        public static const var_1665:int = 3;

        private var var_5426:RoomChatHistoryPulldown;
        private var var_5428:Boolean = false;
        private var var_5429:Number = -1;
        private var var_5427:IScrollbarWindow;
        private var var_5430:Number = 1;
        private var var_3931:Boolean = false;
        private var _widget:RoomChatWidget;
        private var var_1023:Boolean = false;
        private var var_5431:Boolean = false;
        private var var_5432:Boolean = false;

        public function RoomChatHistoryViewer(param1:RoomChatWidget, param2:IHabboWindowManager, param3:IWindowContainer, param4:IAssetLibrary)
        {
            this.var_1023 = false;
            this._widget = param1;
            this.var_5426 = new RoomChatHistoryPulldown(param1, param2, param3, param4);
            this.var_5426.state = RoomChatHistoryPulldown.var_2342;
            var _loc5_:IItemListWindow = (param3.getChildByName("chat_contentlist") as IItemListWindow);
            if (_loc5_ == null)
            {
                return;
            };
            param3.removeChild(_loc5_);
            param3.addChild(_loc5_);
            this.var_5427 = (param2.createWindow("chatscroller", "", HabboWindowType.var_232, HabboWindowStyle.var_157, (HabboWindowParam.var_159 | HabboWindowParam.var_157), new Rectangle((param3.rectangle.right - SCROLLBAR_WIDTH), param3.y, SCROLLBAR_WIDTH, (param3.height - RoomChatHistoryPulldown.var_1648)), null, 0) as IScrollbarWindow);
            param3.addChild(this.var_5427);
            this.var_5427.visible = false;
            this.var_5427.scrollable = (_loc5_ as IScrollableWindow);
        }

        public function set disabled(param1:Boolean):void
        {
            this.var_3931 = param1;
        }

        public function set visible(param1:Boolean):void
        {
            if (this.var_5426 == null)
            {
                return;
            };
            this.var_5426.state = ((param1 == true) ? RoomChatHistoryPulldown.var_2343 : RoomChatHistoryPulldown.var_2342);
        }

        public function get active():Boolean
        {
            return (this.var_5428);
        }

        public function get scrollbarWidth():Number
        {
            return ((this.var_5428) ? SCROLLBAR_WIDTH : 0);
        }

        public function get pulldownBarHeight():Number
        {
            return (RoomChatHistoryPulldown.var_1648);
        }

        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get visible():Boolean
        {
            if (this.var_5426 == null)
            {
                return (false);
            };
            return ((this.var_5426.state == RoomChatHistoryPulldown.var_2343) || (this.var_5426.state == RoomChatHistoryPulldown.var_1861));
        }

        public function dispose():void
        {
            this.hideHistoryViewer();
            if (this.var_5427 != null)
            {
                this.var_5427.dispose();
                this.var_5427 = null;
            };
            if (this.var_5426 != null)
            {
                this.var_5426.dispose();
                this.var_5426 = null;
            };
            this.var_1023 = true;
        }

        public function update(param1:uint):void
        {
            if (this.var_5426 != null)
            {
                this.var_5426.update(param1);
            };
            this.moveHistoryScroll();
        }

        public function toggleHistoryViewer():void
        {
            if (this.var_5428)
            {
                this.hideHistoryViewer();
            }
            else
            {
                this.showHistoryViewer();
            };
        }

        public function hideHistoryViewer():void
        {
            this.var_5430 = 1;
            this.cancelDrag();
            this.var_5428 = false;
            this.setHistoryViewerScrollbar(false);
            this.var_5426.state = RoomChatHistoryPulldown.var_2342;
            if (this._widget != null)
            {
                this._widget.resetArea();
                this._widget.enableDragTooltips();
            };
        }

        public function showHistoryViewer():void
        {
            var _loc1_:RoomChatItem;
            var _loc2_:int;
            var _loc3_:IWindowContainer;
            if (((!(this.var_5428)) && (!(this.var_3931))))
            {
                this.var_5428 = true;
                this.setHistoryViewerScrollbar(true);
                this.var_5426.state = RoomChatHistoryPulldown.var_2343;
                if (this._widget != null)
                {
                    this._widget.reAlignItemsToHistoryContent();
                    this._widget.disableDragTooltips();
                };
            };
        }

        private function setHistoryViewerScrollbar(param1:Boolean):void
        {
            if (this.var_5427 != null)
            {
                this.var_5427.visible = param1;
                if (param1)
                {
                    this.var_5427.scrollV = 1;
                    this.var_5430 = 1;
                }
                else
                {
                    this.var_5428 = false;
                    this.var_5429 = -1;
                };
            };
        }

        public function containerResized(param1:Rectangle, param2:Boolean=false):void
        {
            if (this.var_5427 != null)
            {
                this.var_5427.x = ((param1.x + param1.width) - this.var_5427.width);
                this.var_5427.y = param1.y;
                this.var_5427.height = (param1.height - RoomChatHistoryPulldown.var_1648);
                if (param2)
                {
                    this.var_5427.scrollV = this.var_5430;
                };
            };
            if (this.var_5426 != null)
            {
                this.var_5426.containerResized(param1);
            };
        }

        private function processDrag(param1:Number, param2:Boolean=false):void
        {
            var _loc3_:Number;
            var _loc4_:Number;
            var _loc5_:Number;
            var _loc6_:int;
            var _loc7_:Boolean;
            var _loc8_:Boolean;
            if (((this.var_5429 > 0) && (param2)))
            {
                if (this.var_5432)
                {
                    if (Math.abs((param1 - this.var_5429)) > var_1665)
                    {
                        this.var_5432 = false;
                    }
                    else
                    {
                        return;
                    };
                };
                if (!this.var_5428)
                {
                    this._widget.resizeContainerToLowestItem();
                    this.showHistoryViewer();
                    this.moveHistoryScroll();
                };
                if (this.var_5428)
                {
                    this.moveHistoryScroll();
                    _loc4_ = (this.var_5427.scrollable.scrollableRegion.height / this.var_5427.scrollable.visibleRegion.height);
                    _loc5_ = ((param1 - this.var_5429) / this.var_5427.height);
                    _loc3_ = (this.var_5430 - (_loc5_ / _loc4_));
                    _loc3_ = Math.max(0, _loc3_);
                    _loc3_ = Math.min(1, _loc3_);
                    _loc6_ = (param1 - this.var_5429);
                    _loc7_ = true;
                    _loc8_ = true;
                    if (this.var_5427.scrollV < (1 - (var_2344 / this.var_5427.scrollable.scrollableRegion.height)))
                    {
                        _loc8_ = false;
                    };
                    if (((_loc8_) || (this.var_5431)))
                    {
                        this._widget.stretchAreaBottomBy(_loc6_);
                        _loc7_ = false;
                        this.var_5427.scrollV = 1;
                    };
                    if (_loc7_)
                    {
                        this.var_5430 = _loc3_;
                    };
                    this.var_5429 = param1;
                };
            }
            else
            {
                this.var_5429 = -1;
            };
        }

        public function beginDrag(param1:Number, param2:Boolean=false):void
        {
            var _loc3_:DisplayObject;
            var _loc4_:Stage;
            this.var_5429 = param1;
            this.var_5431 = param2;
            this.var_5432 = true;
            if (this.var_5427 != null)
            {
                this.var_5430 = this.var_5427.scrollV;
            };
            if (this.var_5427 != null)
            {
                _loc3_ = this.var_5427.context.getDesktopWindow().getDisplayObject();
                if (_loc3_ != null)
                {
                    _loc4_ = _loc3_.stage;
                    if (_loc4_ != null)
                    {
                        _loc4_.addEventListener(MouseEvent.MOUSE_MOVE, this.onStageMouseMove);
                        _loc4_.addEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUp);
                    };
                };
            };
        }

        public function cancelDrag():void
        {
            var _loc1_:DisplayObject;
            var _loc2_:Stage;
            this.var_5429 = -1;
            if (this.var_5427 != null)
            {
                _loc1_ = this.var_5427.context.getDesktopWindow().getDisplayObject();
                if (_loc1_ != null)
                {
                    _loc2_ = _loc1_.stage;
                    if (_loc2_ != null)
                    {
                        _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE, this.onStageMouseMove);
                        _loc2_.removeEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUp);
                    };
                };
            };
        }

        private function moveHistoryScroll():void
        {
            if (!this.var_5428)
            {
                return;
            };
            if (this.var_5429 == -1)
            {
                return;
            };
            if (this.var_5431)
            {
                return;
            };
            var _loc1_:Number = (this.var_5430 - this.var_5427.scrollV);
            if (_loc1_ == 0)
            {
                return;
            };
            if (Math.abs(_loc1_) < 0.01)
            {
                this.var_5427.scrollV = this.var_5430;
            }
            else
            {
                this.var_5427.scrollV = (this.var_5427.scrollV + (_loc1_ / 2));
            };
        }

        private function onStageMouseUp(param1:MouseEvent):void
        {
            this.cancelDrag();
            if (this._widget != null)
            {
                this._widget.mouseUp();
            };
        }

        private function onStageMouseMove(param1:MouseEvent):void
        {
            this.processDrag(param1.stageY, param1.buttonDown);
        }


    }
}