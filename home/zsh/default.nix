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
        precommand = "fg=#863e7f";
        arg0 = "fg=#5a418a";
        comment = "fg=#969555";
        single-quoted-argument = "fg=#9c792a";
        double-quoted-argument = "fg=#9c792a";
        path = "fg=#9c792a,underline";
        autodirectory = "fg=#9c792a,underline";
      };
    };
    initContent = builtins.readFile ./initContent.sh;
  };
}
