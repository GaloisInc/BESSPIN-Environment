{ lib, fetchFromGitHub, besspinConfig }:

let
  gitSrcs = besspinConfig.gitSrcs;
  maybeTrace = msg: x:
    if besspinConfig.traceFetch then builtins.trace msg x else x;

in {
  fetchGit2 = args: let
    override =
      gitSrcs."${args.url}#${args.rev or "HEAD"}" or
      gitSrcs."${args.url}" or
      null;
    args' =
      if override == null then args
      else if builtins.typeOf override == "string" then {
        url = override;
      } // lib.optionalAttrs (args ? name) { inherit (args) name; }
      else override;
  in
    maybeTrace "fetch ${args'.rev or "HEAD"} from ${args'.url}"
    builtins.fetchGit args';

  fetchFromGitHub2 = args: let
    url = "https://github.com/${args.owner}/${args.repo}.git";
    override =
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
      maybeTrace "fetch ${args.rev or "HEAD"} from github ${args.owner}/${args.repo}"
      fetchFromGitHub args
    else
      maybeTrace "fetch ${overrideArgs.rev or "HEAD"} from ${overrideArgs.url}"
      builtins.fetchGit overrideArgs;
}
