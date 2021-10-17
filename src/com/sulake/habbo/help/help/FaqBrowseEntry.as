package com.sulake.habbo.help.help
{
    import com.sulake.habbo.help.help.data.FaqItem;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import com.sulake.habbo.communication.messages.outgoing.help.GetFaqTextMessageComposer;
    import com.sulake.habbo.help.help.data.FaqCategory;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;

    public class FaqBrowseEntry extends HelpViewController 
    {

        private var var_3808:FaqItem;

        public function FaqBrowseEntry(param1:HelpUI, param2:IHabboWindowManager, param3:IAssetLibrary)
        {
            super(param1, param2, param3);
        }

        override public function render():void
        {
            if (container != null)
            {
                container.dispose();
            };
            container = (buildXmlWindow("help_faq_entry") as IWindowContainer);
            if (container == null)
            {
                return;
            };
            var _loc1_:IWindow = container.findChildByTag("help_faq_back_link");
            if (_loc1_ != null)
            {
                _loc1_.setParamFlag(WindowParam.var_609);
                _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBack);
            };
            var _loc2_:IWindow = container.findChildByTag("help_faq_next_entry");
            if (_loc2_ != null)
            {
                _loc2_.setParamFlag(WindowParam.var_609);
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNextEntry);
            };
            super.render();
            if (this.var_3808 != null)
            {
                this.update();
            };
        }

        override public function update(param1:*=null):void
        {
            var _loc4_:ITextWindow;
            var _loc5_:FaqItem;
            var _loc2_:FaqIndex = main.getFaq();
            if (_loc2_ == null)
            {
                return;
            };
            if (param1 != null)
            {
                this.var_3808 = FaqItem(param1);
            };
            if (this.var_3808 == null)
            {
                return;
            };
            if (!this.var_3808.hasAnswer)
            {
                main.sendMessage(new GetFaqTextMessageComposer(this.var_3808.questionId));
                return;
            };
            var _loc3_:FaqCategory = this.var_3808.category;
            if (_loc3_ == null)
            {
                return;
            };
            _loc4_ = (container.findChildByTag("faq_category_title") as ITextWindow);
            if (_loc4_ != null)
            {
                _loc4_.text = _loc3_.categoryTitle;
            };
            _loc4_ = (container.findChildByTag("faq_question_text") as ITextWindow);
            if (_loc4_ != null)
            {
                _loc4_.text = this.var_3808.questionText;
            };
            _loc4_ = (container.findChildByTag("faq_answer_text") as ITextWindow);
            if (_loc4_ != null)
            {
                _loc4_.htmlText = this.hackHTML(this.var_3808.answerText);
            };
            if (_loc3_ != null)
            {
                _loc5_ = _loc3_.getItemByIndex((this.var_3808.index + 1));
            };
            var _loc6_:ILabelWindow = (container.findChildByTag("help_faq_next_entry_title") as ILabelWindow);
            if (_loc6_ != null)
            {
                if (_loc5_ != null)
                {
                    _loc6_.text = _loc5_.questionText;
                    _loc6_.setParamFlag(WindowParam.var_609);
                    _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNextEntry);
                    _loc6_.mouseThreshold = 0;
                }
                else
                {
                    _loc6_.text = "";
                };
            };
            _loc4_ = (container.findChildByTag("help_faq_next_entry") as ITextWindow);
            if (_loc4_ != null)
            {
                if (_loc5_ != null)
                {
                    _loc4_.text = "${help.button.faq.next.entry}";
                }
                else
                {
                    _loc4_.text = "";
                };
            };
            super.update(param1);
        }

        private function hackHTML(param1:String):String
        {
            var _loc4_:String;
            var _loc2_:String = param1;
            var _loc3_:int;
            while (_loc3_ < (_loc2_.length - 4))
            {
                _loc4_ = _loc2_.slice(_loc3_, (_loc3_ + 4));
                if (_loc4_ == "<img")
                {
                    _loc2_ = ((_loc2_.slice(0, _loc3_) + '<img checkPolicyFile="true"') + _loc2_.slice((_loc3_ + 4), _loc2_.length));
                };
                _loc3_++;
            };
            return (_loc2_);
        }

        private function onBack(param1:WindowMouseEvent):void
        {
            var _loc2_:FaqCategory;
            if (this.var_3808 != null)
            {
                _loc2_ = this.var_3808.category;
                main.showUI(HabboHelpViewEnum.var_1395);
                main.tellUI(HabboHelpViewEnum.var_1395, _loc2_);
            };
        }

        private function onNextEntry(param1:WindowMouseEvent):void
        {
            if (this.getNextItem() != null)
            {
                main.tellUI(HabboHelpViewEnum.var_1396, this.getNextItem());
            };
        }

        private function getNextItem():FaqItem
        {
            var _loc1_:FaqIndex = main.getFaq();
            if (((_loc1_ == null) || (this.var_3808 == null)))
            {
                return (null);
            };
            var _loc2_:FaqCategory = this.var_3808.category;
            if (_loc2_ == null)
            {
                return (null);
            };
            return (_loc2_.getItemByIndex((this.var_3808.index + 1)));
        }


    }
}