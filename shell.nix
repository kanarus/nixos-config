{ config, pkgs, ... }: {
  prgorams.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      styles = {
        comment = "fg=#9e9e9e";
      };
    };
    initContent = ''
      setopt INTERACTIVE_COMMENTS

      bindkey ";5C" forward-word
      bindkey ";5D" backward-word

      function maybe_git_branch() {
        git_output=$(git symbolic-ref --short HEAD 2>&1)
        if [[ $git_output =~ '^fatal: ' ]]; then
          echo ""
        else
          echo '(%F{124}'$git_output'%F{153})'
        fi
      }      
      setopt PROMPT_SUBST
      export PS1='%F{153}[%n%F{111}@%m%F{153}:%~]$(maybe_git_branch)%f '

      alias helix='hx'
      alias la='ls -al'

      typeset -Ag abbreviations
      abbreviations=(
        "ns"   "sudo nixos-rebuild switch --flake ~/nixos-config"
        "com"  "git add . && git commit -m"
        "po"   "git push origin"
        "push" "git push"
        "x"    "helix"
      )
      function expand_abbreviation() {
        local MATCH
        # empty quotes: workaround to avoid nix's interpretation on the $-brace syntax,
        # which here leads to an syntax error on nix side
        setopt EXTENDED_GLOB
        LBUFFER=''${LBUFFER%%(#m)[_a-zA-Z0-9]#}
        unsetopt EXTENDED_GLOB
        LBUFFER+=''${abbreviations[$MATCH]:-$MATCH}
        zle self-insert
      }
      zle -N expand_abbreviation
      bindkey " " expand_abbreviation
      bindkey -M isearch " " self-insert
    '';
  };
}

