%%%-------------------------------------------------------------------
%%% @author hw
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 7月 2021 14:24
%%%-------------------------------------------------------------------
-module(obj_son_lib).
-author("hw").

-include("obj.hrl").
-include("common.hrl").

%% API
-export([
	new/0
	, print/0
]).

%% @doc new新对象
new() ->
	%% 基础obj_lib
	Obj = obj_lib:inherit(?MODULE, obj_lib),
	Obj.

%% @doc 打印
print() ->
	?DEBUG("print:~p~n", [?MODULE]).

























