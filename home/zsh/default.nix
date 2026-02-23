{ ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
      styles = {
        comment = "fg=#9e9e9e";
      };
    };
    initContent = builtins.readFile ./initContent.sh;
  };
}
