{
    programs.oh-my-posh = {
        enable = true;
        enableBashIntegration = true;
        settings = builtins.fromJSON
            (builtins.unsafeDiscardStringContext
            (builtins.readFile "/home/emers/.config/home-manager/default/bash/oh-my-posh.json"));
    };
}
