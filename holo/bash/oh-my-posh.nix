{
    programs.oh-my-posh = {
        enable = true;
        enableBashIntegration = true;
        settings = builtins.fromJSON
            (builtins.unsafeDiscardStringContext
            (builtins.readFile "/home/emers/.config/home-manager/holo/bash/oh-my-posh.json"));
    };
}
