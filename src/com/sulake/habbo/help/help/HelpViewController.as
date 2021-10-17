package com.sulake.habbo.help.help
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class HelpViewController implements IHelpViewController 
    {

        private var var_4014:HelpUI;
        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _container:IWindowContainer;
        private var var_4015:Boolean = false;
        private var _disposed:Boolean = true;

        public function HelpViewController(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
        {
            this.var_4014 = param1;
            this._windowManager = param2;
            this._assetLibrary = param3;
        }

        public function dispose():void
        {
            if (this._container != null)
            {
                this._container.dispose();
                this._container = null;
            };
            this._disposed = true;
        }

        public function render():void
        {
            this._disposed = false;
        }

        public function update(param1:*=null):void
        {
        }

        public function get container():IWindowContainer
        {
            return (this._container);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get main():HelpUI
        {
            return (this.var_4014);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get assetLibrary():IAssetLibrary
        {
            return (this._assetLibrary);
        }

        public function get roomSessionActive():Boolean
        {
            return (this.var_4015);
        }

        public function set container(param1:IWindowContainer):void
        {
            this._container = param1;
        }

        public function set disposed(param1:Boolean):void
        {
            this._disposed = param1;
        }

        public function set roomSessionActive(param1:Boolean):void
        {
            this.var_4015 = param1;
        }

        public function getWindowContainer():IWindowContainer
        {
            return (this._container);
        }

        public function getText(param1:String):String
        {
            if (this.var_4014 == null)
            {
                return (null);
            };
            return (this.var_4014.getText(param1));
        }

        public function getConfigurationKey(param1:String, param2:String=null, param3:Dictionary=null):String
        {
            if (this.var_4014 == null)
            {
                return (null);
            };
            return (this.var_4014.getConfigurationKey(param1, param2, param3));
        }

        public function buildXmlWindow(param1:String):IWindow
        {
            var _loc2_:XmlAsset = XmlAsset(this._assetLibrary.getAssetByName((param1 + "_xml")));
            if (((_loc2_ == null) || (this._windowManager == null)))
            {
                return (null);
            };
            return (this._windowManager.buildFromXML(XML(_loc2_.content)));
        }

        protected function buildHelpCategoryListEntryItem(param1:String, param2:String, param3:Function=null):IWindowContainer
        {
            var _loc6_:IWindow;
            var _loc4_:IWindowContainer = (this.buildXmlWindow(param2) as IWindowContainer);
            if (_loc4_ == null)
            {
                return (null);
            };
            var _loc5_:ITextWindow = (_loc4_.findChildByTag("text") as ITextWindow);
            if (_loc5_ == null)
            {
                return (null);
            };
            _loc5_.text = param1;
            if (param3 != null)
            {
                _loc6_ = (_loc4_.findChildByName("item_bg") as IWindow);
                if (_loc6_ != null)
                {
                    _loc6_.setParamFlag(WindowParam.var_609);
                    _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, param3);
                };
            };
            return (_loc4_);
        }


    }
}