package com.sulake.habbo.inventory.furni
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class FurniGridView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IWindowContainer;
        private var var_2533:FurniModel;
        private var _roomEngine:IRoomEngine;
        private var _category:String;
        private var var_3306:IItemGridWindow;
        private var var_3258:IWindow;

        public function FurniGridView(param1:FurniModel, param2:String, param3:IHabboWindowManager, param4:IAssetLibrary, param5:IRoomEngine)
        {
            this.var_2533 = param1;
            this._category = param2;
            this._assetLibrary = param4;
            this._windowManager = param3;
            this._roomEngine = param5;
            var _loc6_:XmlAsset = (this._assetLibrary.getAssetByName("inventory_furni_grid_xml") as XmlAsset);
            this._view = (this._windowManager.buildFromXML((_loc6_.content as XML)) as IWindowContainer);
            if (this._view != null)
            {
                this.var_3306 = (this._view.findChildByName("item_grid") as IItemGridWindow);
            };
        }

        public function dispose():void
        {
            this.var_2533 = null;
            this._windowManager = null;
            this._assetLibrary = null;
            this._roomEngine = null;
            this.var_3306 = null;
            this.var_3258 = null;
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
        }

        public function get window():IWindowContainer
        {
            if (this._view == null)
            {
                return (null);
            };
            if (this._view.disposed)
            {
                return (null);
            };
            return (this._view);
        }

        public function clearGrid():void
        {
            if (this.var_3306 != null)
            {
                this.var_3306.removeGridItems();
            };
        }

        public function updateItem(param1:int, param2:IWindowContainer):void
        {
            var _loc3_:IWindow = this.var_3306.getGridItemAt(param1);
            if (_loc3_)
            {
                _loc3_ = param2;
            };
        }

        public function addItemToBottom(param1:IWindowContainer):void
        {
            this.var_3306.addGridItem(param1);
            param1.procedure = this.itemEventProc;
        }

        public function addItemAt(param1:IWindowContainer, param2:int):void
        {
            this.var_3306.addGridItemAt(param1, param2);
            param1.procedure = this.itemEventProc;
        }

        public function removeItem(param1:int):IWindow
        {
            return (this.var_3306.removeGridItemAt(param1));
        }

        public function moveItemTo(param1:IWindowContainer, param2:int):void
        {
            this.var_3306.removeGridItem(param1);
            this.var_3306.addGridItemAt(param1, param2);
        }

        public function setLock(param1:Boolean):void
        {
            if (param1)
            {
                this.var_3306.autoArrangeItems = false;
                this.var_3306.lock();
            }
            else
            {
                this.var_3306.autoArrangeItems = true;
                this.var_3306.unlock();
            };
        }

        private function itemEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:Boolean;
            if (param1.type == WindowMouseEvent.var_655)
            {
                this.var_3258 = null;
                this.var_2533.cancelFurniInMover();
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_650)
                {
                    if (param2 == null)
                    {
                        return;
                    };
                    this.var_2533.toggleItemSelection(this._category, this.var_3306.getGridItemIndex(param1.window));
                    this.var_3258 = param2;
                }
                else
                {
                    if (((((param1.type == WindowMouseEvent.var_624) && (!(this.var_3258 == null))) && (this.var_3258 == param2)) && (!(this.var_2533.isTradingOpen))))
                    {
                        _loc3_ = this.var_2533.requestSelectedFurniPlacement(true);
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
                                    this.var_2533.requestCurrentActionOnSelection();
                                    this.var_3258 = null;
                                };
                            };
                        };
                    };
                };
            };
        }


    }
}