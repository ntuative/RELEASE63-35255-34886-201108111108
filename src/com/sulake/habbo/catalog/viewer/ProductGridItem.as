package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.enum.MouseCursorType;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.display.BitmapData;
    import flash.geom.Point;

    public class ProductGridItem implements IGridItem 
    {

        private static const var_1874:String = "bg";

        protected var _view:IWindowContainer;
        private var var_3306:IItemGrid;
        protected var _icon:IBitmapWrapperWindow;
        private var _disposed:Boolean = false;
        private var var_3258:Object;


        public function get view():IWindowContainer
        {
            return (this._view);
        }

        public function set grid(param1:IItemGrid):void
        {
            this.var_3306 = param1;
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            this.var_3306 = null;
            this._icon = null;
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function activate():void
        {
            this._view.getChildByName(var_1874).style = HabboWindowStyle.var_613;
        }

        public function deActivate():void
        {
            this._view.getChildByName(var_1874).style = 3;
        }

        public function set view(param1:IWindowContainer):void
        {
            if (!param1)
            {
                return;
            };
            this._view = param1;
            this._view.procedure = this.eventProc;
            this._icon = (this._view.findChildByName("image") as IBitmapWrapperWindow);
            var _loc2_:IWindow = this._view.findChildByName("multiContainer");
            if (_loc2_)
            {
                _loc2_.visible = false;
            };
        }

        public function setDraggable(param1:Boolean):void
        {
            if (((this._view) && (param1)))
            {
                (this._view as IInteractiveWindow).setMouseCursorForState(WindowState.var_1187, MouseCursorType.var_1173);
                (this._view as IInteractiveWindow).setMouseCursorForState((WindowState.var_1187 | WindowState.var_743), MouseCursorType.var_1173);
            };
        }

        private function eventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:Boolean;
            if (param1.type == WindowMouseEvent.var_655)
            {
                this.var_3258 = null;
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_650)
                {
                    Logger.log(this._view.state);
                    if (param2 == null)
                    {
                        return;
                    };
                    this.var_3306.select(this);
                    this.var_3258 = param2;
                }
                else
                {
                    if ((((param1.type == WindowMouseEvent.var_624) && (!(this.var_3258 == null))) && (this.var_3258 == param2)))
                    {
                        _loc3_ = this.var_3306.startDragAndDrop(this);
                        if (_loc3_)
                        {
                            this.var_3258 = null;
                        };
                    }
                    else
                    {
                        if (param1.type == WindowMouseEvent.var_655)
                        {
                            this.var_3258 = null;
                        }
                        else
                        {
                            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                            {
                                this.var_3258 = null;
                            }
                            else
                            {
                                if (param1.type == WindowMouseEvent.var_649)
                                {
                                    this.var_3258 = null;
                                };
                            };
                        };
                    };
                };
            };
        }

        protected function setIconImage(param1:BitmapData, param2:Boolean):void
        {
            var _loc3_:int;
            var _loc4_:int;
            if (param1 == null)
            {
                return;
            };
            if (((!(this._icon == null)) && (!(this._icon.disposed))))
            {
                _loc3_ = int(((this._icon.width - param1.width) / 2));
                _loc4_ = int(((this._icon.height - param1.height) / 2));
                if (this._icon.bitmap == null)
                {
                    this._icon.bitmap = new BitmapData(this._icon.width, this._icon.height, true, 0xFFFFFF);
                };
                this._icon.bitmap.fillRect(this._icon.bitmap.rect, 0xFFFFFF);
                this._icon.bitmap.copyPixels(param1, param1.rect, new Point(_loc3_, _loc4_), null, null, false);
                this._icon.invalidate();
            };
            if (param2)
            {
                param1.dispose();
            };
        }


    }
}