{
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
    initContent = builtins.readFile ./initContent.sh;
}

