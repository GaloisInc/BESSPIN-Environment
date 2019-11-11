{ lib, fetchFromGitHub, besspinConfig }:

let
  gitSrcs = besspinConfig.gitSrcs;
  maybeTrace = msg: x:
    if besspinConfig.traceFetch then builtins.trace msg x else x;

  cleanArgs = args: lib.filterAttrs (n: v: n != "context") args;

  forContextStr = args:
    if (args.context or "") != "" then " for ${args.context}" else "";

in {
  fetchGit2 = args: let
    override =
      gitSrcs."${args.url}#${args.rev or "HEAD"}%${args.context or ""}" or
      gitSrcs."${args.url}%${args.context or ""}" or
      gitSrcs."${args.url}#${args.rev or "HEAD"}" or
      gitSrcs."${args.url}" or
      null;
    args' =
      if override == null then cleanArgs args
      else if builtins.typeOf override == "string" then {
        url = override;
      } // lib.optionalAttrs (args ? name) { inherit (args) name; }
      else override;
  in
    maybeTrace "fetch ${args'.rev or "HEAD"} from ${args'.url}${forContextStr args}"
    builtins.fetchGit args';

  fetchFromGitHub2 = args: let
    url = "https://github.com/${args.owner}/${args.repo}.git";
    override =
      gitSrcs."${url}#${args.rev or "HEAD"}%${args.context or ""}" or
      gitSrcs."${url}%${args.context or ""}" or
      gitSrcs."${url}#${args.rev or "HEAD"}" or
      gitSrcs."${url}" or
      null;
    overrideArgs =
      if override == null then null
      else if builtins.typeOf override == "string" then {
        url = override;
      } // lib.optionalAttrs (args ? name) { inherit (args) name; }
      else override;
  in
    if overrideArgs == null then
      maybeTrace "fetch ${args.rev or "HEAD"} from github ${args.owner}/${args.repo}${forContextStr args}"
      fetchFromGitHub (cleanArgs args)
    else
      maybeTrace "fetch ${overrideArgs.rev or "HEAD"} from ${overrideArgs.url}${forContextStr args}"
      builtins.fetchGit overrideArgs;
}
