%%%-------------------------------------------------------------------
%%% @author hw
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 7月 2021 10:42
%%%-------------------------------------------------------------------
-module(obj_lib).
-author("hw").

-include("obj.hrl").
-include("common.hrl").

%% API
-export([
	new/0
	, inherit/2
	, run_fun/2
	, run_fun/3
	, print/0
	, print_1/0
]).


%% @doc new新对象
new() ->
	New = #obj{
		mod = ?MODULE
		, fun_map = #{}
	},
	New.

%% @doc 继承
inherit(SonMod, ParentMod) ->
	#obj{
		fun_map = ParentFunMap
	} = ParentMod:new(),
	%% 继承obj_lib
	%% 重定义函数
	NewFunMap = init_fun(ParentFunMap, SonMod),
	New = #obj{
		mod = SonMod
		, fun_map = NewFunMap
	},
	New.

%% @doc 重定义函数
init_fun(ParentFunMap, SonMod) ->
	Exports = SonMod:module_info(exports),
	init_fun(Exports, ParentFunMap, SonMod).
init_fun([], ParentFunMap, _SonMod) -> ParentFunMap;
init_fun([{Fun, _} | T], ParentFunMap, SonMod) ->
	ParentFunMap1 = ParentFunMap#{Fun => #obj_fun{fun_name = Fun, mod = SonMod}},
	init_fun(T, ParentFunMap1, SonMod).


%% obj_lib:run_fun(obj_son_lib:new(), print_1).
%% @doc 没有参数
run_fun(#obj{
	fun_map = FunMap
}, Fun) ->
	%% 是否被重定义过函数
	case maps:get(Fun, FunMap, undefined) of
		undefined ->
			try
				obj_lib:Fun()
			catch T:E:S ->
				?ERROR("apply ~p,~p, error ~p,~p,stacktrace ~p ~n", [obj_lib, Fun, T, E, S])
			end;
		#obj_fun{mod = FunMod} ->
			try
				FunMod:Fun()
			catch T:E:S ->
				?ERROR("apply ~p,~p, error ~p,~p,stacktrace ~p ~n", [FunMod, Fun, T, E, S])
			end
	end.
%% @doc 有参数
run_fun(#obj{
	mod = Mod
	, fun_map = FunMap
}, Fun, Param) ->
	%% 是否被重定义过函数
	case maps:get(Fun, FunMap, undefined) of
		undefined ->
			try
				Mod:Fun(Param)
			catch T:E:S ->
				?ERROR("apply ~p,~p,~p, error ~p,~p,stacktrace ~p ~n", [Mod, Fun, Param, T, E, S])
			end;
		#obj_fun{mod = FunMod} ->
			try
				FunMod:Fun(Param)
			catch T:E:S ->
				?ERROR("apply ~p,~p,~p, error ~p,~p,stacktrace ~p ~n", [FunMod, Fun, Param, T, E, S])
			end
	end.




%% @doc 打印
print() ->
	?DEBUG("print:~p~n", [?MODULE]).

%% @doc 打印
print_1() ->
	?DEBUG("print:~p~n", [1]).

























