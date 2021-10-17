package com.sulake.habbo.help.cfh
{
    import com.sulake.habbo.help.help.HelpViewController;
    import com.sulake.habbo.help.help.IHelpViewController;
    import com.sulake.habbo.help.help.HelpUI;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class CallForHelpSentView extends HelpViewController implements IHelpViewController 
    {

        private var var_3286:String = "";

        public function CallForHelpSentView(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary, param4:String)
        {
            super(param1, param2, param3);
            this.var_3286 = param4;
        }

        override public function render():void
        {
            super.render();
            if (container != null)
            {
                container.dispose();
            };
            container = (buildXmlWindow(this.var_3286) as IWindowContainer);
            if (container == null)
            {
                return;
            };
            var _loc1_:IWindow = container.findChildByTag("close");
            if (_loc1_ != null)
            {
                _loc1_.setParamFlag(WindowParam.var_609);
                _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
        }

        private function onClose(param1:WindowMouseEvent):void
        {
            main.hideUI();
        }


    }
}