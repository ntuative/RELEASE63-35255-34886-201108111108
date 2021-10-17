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
    import com.sulake.habbo.communication.messages.outgoing.help.DeletePendingCallsForHelpMessageComposer;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;

    public class CallForHelpPendingItemView extends HelpViewController implements IHelpViewController 
    {

        public function CallForHelpPendingItemView(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
        {
            super(param1, param2, param3);
        }

        override public function render():void
        {
            super.render();
            if (container != null)
            {
                container.dispose();
            };
            container = (buildXmlWindow("help_cfh_pending") as IWindowContainer);
            if (container == null)
            {
                return;
            };
            var _loc1_:IWindow = container.findChildByName("cfh_delete");
            if (_loc1_ != null)
            {
                _loc1_.setParamFlag(WindowParam.var_609);
                _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onDelete);
            };
            var _loc2_:IWindow = container.findChildByName("cfh_cancel");
            if (_loc2_ != null)
            {
                _loc2_.setParamFlag(WindowParam.var_609);
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancel);
            };
        }

        private function onDelete(param1:WindowMouseEvent):void
        {
            main.sendMessage(new DeletePendingCallsForHelpMessageComposer());
        }

        private function onCancel(param1:WindowMouseEvent):void
        {
            main.showUI(HabboHelpViewEnum.var_1393);
        }


    }
}