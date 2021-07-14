%%%-------------------------------------------------------------------
%%% @author hw
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 7月 2021 10:42
%%%-------------------------------------------------------------------
-author("hw").

-ifndef(OBJ_H_H_).
-define(OBJ_H_H_, 1).

%% 基础对象
-record(obj, {
	mod = null              %% 所属模块
	, fun_map = #{}         %% 函数属性，不存在用mod的
}).

%% 基础对象
-record(obj_fun, {
	fun_name = null
	, mod = null      %% 函数所属模块
}).

-endif.































