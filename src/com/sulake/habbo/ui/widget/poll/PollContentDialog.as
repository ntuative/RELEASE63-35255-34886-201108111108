package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;

    public class PollContentDialog implements IPollDialog 
    {

        private static const var_236:int = 1;
        private static const var_921:int = 2;
        private static const var_2528:int = 3;
        private static const var_2529:int = 4;

        private var _id:int = -1;
        private var _disposed:Boolean = false;
        private var var_5407:Array;
        private var var_3783:int = -1;
        private var _window:IFrameWindow;
        private var _widget:PollWidget;
        private var var_5408:IFrameWindow;
        private var var_5409:Boolean = false;

        public function PollContentDialog(param1:int, param2:String, param3:Array, param4:PollWidget)
        {
            var _loc6_:ITextWindow;
            var _loc7_:IWindow;
            var _loc8_:IWindow;
            var _loc9_:IWindow;
            super();
            this._id = param1;
            this.var_5407 = param3;
            this._widget = param4;
            var _loc5_:XmlAsset = (this._widget.assets.getAssetByName("poll_question") as XmlAsset);
            if (_loc5_ != null)
            {
                this._window = (this._widget.windowManager.buildFromXML((_loc5_.content as XML)) as IFrameWindow);
                _loc6_ = (this._window.findChildByName("poll_question_headline") as ITextWindow);
                if (_loc6_)
                {
                    _loc6_.text = param2;
                };
                this._window.center();
                _loc7_ = this._window.findChildByName("header_button_close");
                if (_loc7_ != null)
                {
                    _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
                };
                _loc8_ = this._window.findChildByName("poll_question_button_ok");
                if (_loc8_ != null)
                {
                    _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onOk);
                };
                _loc9_ = this._window.findChildByName("poll_question_cancel");
                if (_loc9_ != null)
                {
                    _loc9_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancel);
                };
            };
        }

        public function start():void
        {
            if (!this.var_5409)
            {
                this.var_5409 = true;
                this.nextQuestion();
            };
        }

        private function onClose(param1:WindowEvent):void
        {
            this.showCancelConfirm();
        }

        private function onOk(param1:WindowEvent):void
        {
            this.answerPollQuestion();
        }

        private function onCancel(param1:WindowEvent):void
        {
            this.showCancelConfirm();
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_5408)
            {
                this.var_5408.dispose();
                this.var_5408 = null;
            };
            this._widget = null;
            this.var_5407 = null;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        private function nextQuestion():void
        {
            var _loc1_:Dictionary;
            var _loc2_:ITextWindow;
            var _loc3_:int;
            var _loc4_:IWindowContainer;
            var _loc5_:IItemListWindow;
            var _loc6_:String;
            var _loc7_:int;
            this.var_3783++;
            if (this.var_3783 < this.var_5407.length)
            {
                _loc1_ = (this.var_5407[this.var_3783] as Dictionary);
                if (!_loc1_)
                {
                    Logger.log("ERROR; Poll question index out of range!");
                };
                if (this._window != null)
                {
                    _loc3_ = (_loc1_["type"] as int);
                    _loc2_ = (this._window.findChildByName("poll_question_text") as ITextWindow);
                    if (_loc2_ != null)
                    {
                        _loc2_.text = _loc1_["content"];
                    };
                    _loc2_ = (this._window.findChildByName("poll_question_number") as ITextWindow);
                    if (_loc2_ != null)
                    {
                        _loc2_.text = "${poll_question_number}";
                        _loc6_ = _loc2_.text;
                        _loc6_ = _loc6_.replace("%number%", _loc1_["number"]);
                        _loc6_ = _loc6_.replace("%count%", this.var_5407.length);
                        _loc2_.text = _loc6_;
                    };
                    _loc4_ = (this._window.findChildByName("poll_question_answer_container") as IWindowContainer);
                    if (_loc4_ != null)
                    {
                        while (_loc4_.numChildren > 0)
                        {
                            _loc4_.getChildAt(0).dispose();
                        };
                    };
                    switch (_loc3_)
                    {
                        case var_236:
                            this.populateRadionButtonType(_loc4_, _loc1_["selections"]);
                            break;
                        case var_921:
                            this.populateCheckBoxType(_loc4_, _loc1_["selections"]);
                            break;
                        case var_2528:
                            this.populateTextLineType(_loc4_);
                            break;
                        case var_2529:
                            this.populateTextAreaType(_loc4_);
                            break;
                        default:
                            throw (new Error((("Unknown poll question type: " + _loc3_) + "!")));
                    };
                    _loc5_ = (this._window.findChildByName("poll_content_wrapper") as IItemListWindow);
                    if (_loc5_ != null)
                    {
                        _loc7_ = (_loc5_.scrollableRegion.height - _loc5_.visibleRegion.height);
                        this._window.height = (this._window.height + _loc7_);
                        this._window.center();
                    };
                };
            }
            else
            {
                this._widget.pollFinished(this._id);
            };
        }

        private function populateRadionButtonType(param1:IWindowContainer, param2:Array):void
        {
            var _loc3_:XmlAsset = (this._widget.assets.getAssetByName("poll_answer_radiobutton_input") as XmlAsset);
            if (!_loc3_)
            {
                throw (new Error('Asset for poll widget hot found: "poll_answer_radiobutton_input"!'));
            };
            var _loc4_:IWindowContainer = (this._widget.windowManager.buildFromXML((_loc3_.content as XML)) as IWindowContainer);
            if (_loc4_ != null)
            {
                this.populateSelectionList(param2, _loc4_);
                param1.addChild(_loc4_);
            };
        }

        private function resolveRadionButtonTypeAnswer():Array
        {
            var _loc2_:ISelectorWindow;
            var _loc3_:ISelectableWindow;
            var _loc1_:Array = new Array();
            if (this._window != null)
            {
                _loc2_ = (this._window.findChildByName("poll_aswer_selector") as ISelectorWindow);
                if (_loc2_)
                {
                    _loc3_ = _loc2_.getSelected();
                    if (_loc3_)
                    {
                        _loc1_.push((_loc3_.id + 1));
                    };
                };
            };
            return (_loc1_);
        }

        private function populateCheckBoxType(param1:IWindowContainer, param2:Array):void
        {
            var _loc3_:XmlAsset = (this._widget.assets.getAssetByName("poll_answer_checkbox_input") as XmlAsset);
            if (!_loc3_)
            {
                throw (new Error('Asset for poll widget hot found: "poll_answer_checkbox_input"!'));
            };
            var _loc4_:IWindowContainer = (this._widget.windowManager.buildFromXML((_loc3_.content as XML)) as IWindowContainer);
            if (_loc4_ != null)
            {
                this.populateSelectionList(param2, _loc4_);
                param1.addChild(_loc4_);
            };
        }

        private function resolveCheckBoxTypeAnswer():Array
        {
            var _loc2_:IItemListWindow;
            var _loc3_:int;
            var _loc4_:IWindowContainer;
            var _loc5_:ICheckBoxWindow;
            var _loc1_:Array = new Array();
            if (this._window != null)
            {
                _loc2_ = (this._window.findChildByName("poll_answer_itemlist") as IItemListWindow);
                if (_loc2_ != null)
                {
                    _loc3_ = 0;
                    while (_loc3_ < _loc2_.numListItems)
                    {
                        _loc4_ = (_loc2_.getListItemAt(_loc3_) as IWindowContainer);
                        if (_loc4_ != null)
                        {
                            _loc5_ = (_loc4_.findChildByName("poll_answer_checkbox") as ICheckBoxWindow);
                            if (_loc5_ != null)
                            {
                                if (_loc5_.testStateFlag(WindowState.var_1186))
                                {
                                    _loc1_.push((_loc3_ + 1));
                                };
                            };
                        };
                        _loc3_++;
                    };
                };
            };
            return (_loc1_);
        }

        private function populateSelectionList(param1:Array, param2:IWindowContainer):void
        {
            var _loc4_:IWindowContainer;
            var _loc5_:int;
            var _loc6_:ITextWindow;
            var _loc7_:IWindow;
            var _loc3_:IItemListWindow = (param2.findChildByName("poll_answer_itemlist") as IItemListWindow);
            if (_loc3_ != null)
            {
                _loc4_ = (param2.findChildByName("poll_answer_entity") as IWindowContainer);
                if (_loc4_ != null)
                {
                    _loc5_ = 0;
                    while (_loc5_ < (param1.length - 1))
                    {
                        _loc5_++;
                        _loc3_.addListItem(_loc4_.clone());
                    };
                    _loc5_ = 0;
                    while (_loc5_ < param1.length)
                    {
                        _loc4_ = (_loc3_.getListItemAt(_loc5_) as IWindowContainer);
                        _loc6_ = (_loc4_.findChildByName("poll_answer_entity_text") as ITextWindow);
                        if (_loc6_)
                        {
                            _loc6_.text = param1[_loc5_];
                        };
                        _loc7_ = _loc4_.findChildByTag("POLL_SELECTABLE_ITEM");
                        if (_loc7_)
                        {
                            _loc7_.id = _loc5_;
                        };
                        _loc5_++;
                    };
                };
            };
        }

        private function populateTextLineType(param1:IWindowContainer):void
        {
            var _loc2_:XmlAsset = (this._widget.assets.getAssetByName("poll_answer_text_input") as XmlAsset);
            if (!_loc2_)
            {
                throw (new Error('Asset for poll widget hot found: "poll_answer_text_input"!'));
            };
            param1.addChild(this._widget.windowManager.buildFromXML((_loc2_.content as XML)));
        }

        private function resolveTextLineTypeAnswer():Array
        {
            var _loc2_:ITextWindow;
            var _loc1_:Array = new Array();
            if (this._window != null)
            {
                _loc2_ = (this._window.findChildByName("poll_answer_input") as ITextWindow);
                if (_loc2_ != null)
                {
                    _loc1_.push(_loc2_.text);
                };
            }
            else
            {
                throw (new Error("Invalid or disposed poll dialog!"));
            };
            return (_loc1_);
        }

        private function populateTextAreaType(param1:IWindowContainer):void
        {
            this.populateTextLineType(param1);
        }

        private function resolveTextAreaTypeAnswer():Array
        {
            return (this.resolveTextLineTypeAnswer());
        }

        private function cancelPoll():void
        {
            this._widget.pollCancelled(this._id);
        }

        private function answerPollQuestion():void
        {
            var answerArray:Array;
            var question:Dictionary = (this.var_5407[this.var_3783] as Dictionary);
            var type:int = (question["type"] as int);
            switch (type)
            {
                case var_236:
                    answerArray = this.resolveRadionButtonTypeAnswer();
                    if (answerArray.length < int(question["selection_min"]))
                    {
                        this._widget.windowManager.alert("${win_error}", "${poll_alert_answer_missing}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                        {
                            param1.dispose();
                        });
                        return;
                    };
                    if (answerArray.length > int(question["selection_max"]))
                    {
                        this._widget.windowManager.alert("${win_error}", "${poll_alert_invalid_selection}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                        {
                            param1.dispose();
                        });
                        return;
                    };
                    break;
                case var_921:
                    answerArray = this.resolveCheckBoxTypeAnswer();
                    if (answerArray.length < int(question["selection_min"]))
                    {
                        this._widget.windowManager.alert("${win_error}", "${poll_alert_answer_missing}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                        {
                            param1.dispose();
                        });
                        return;
                    };
                    if (answerArray.length > int(question["selection_max"]))
                    {
                        this._widget.windowManager.alert("${win_error}", "${poll_alert_invalid_selection}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                        {
                            param1.dispose();
                        });
                        return;
                    };
                    break;
                case var_2528:
                    answerArray = this.resolveTextLineTypeAnswer();
                    break;
                case var_2529:
                    answerArray = this.resolveTextAreaTypeAnswer();
                    break;
                default:
                    throw (new Error((("Unknown poll question type: " + type) + "!")));
            };
            var message:RoomWidgetPollMessage = new RoomWidgetPollMessage(RoomWidgetPollMessage.ANSWER, this._id);
            message.questionId = (question["id"] as int);
            message.answers = answerArray;
            this._widget.messageListener.processWidgetMessage(message);
            this.nextQuestion();
        }

        private function showCancelConfirm():void
        {
            var _loc1_:XmlAsset;
            var _loc2_:IWindow;
            var _loc3_:IWindow;
            var _loc4_:IWindow;
            if (!this.var_5408)
            {
                _loc1_ = (this._widget.assets.getAssetByName("poll_cancel_confirm") as XmlAsset);
                this.var_5408 = (this._widget.windowManager.buildFromXML((_loc1_.content as XML), 2) as IFrameWindow);
                this.var_5408.center();
                _loc2_ = this.var_5408.findChildByName("header_button_close");
                if (_loc2_ != null)
                {
                    _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancelPollClose);
                };
                _loc3_ = this.var_5408.findChildByName("poll_cancel_confirm_button_ok");
                if (_loc3_ != null)
                {
                    _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancelPollOk);
                };
                _loc4_ = this.var_5408.findChildByName("poll_cancel_confirm_button_cancel");
                if (_loc4_ != null)
                {
                    _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancelPollCancel);
                };
            };
        }

        private function hideCancelConfirm():void
        {
            if (this.var_5408 != null)
            {
                this.var_5408.dispose();
                this.var_5408 = null;
            };
        }

        private function onCancelPollClose(param1:WindowEvent):void
        {
            this.hideCancelConfirm();
        }

        private function onCancelPollOk(param1:WindowEvent):void
        {
            this.hideCancelConfirm();
            this.cancelPoll();
        }

        private function onCancelPollCancel(param1:WindowEvent):void
        {
            this.hideCancelConfirm();
        }


    }
}