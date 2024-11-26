{ inputs, pkgs, ... }:

{
    programs.spicetify =
    let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplayMod
        autoSkipVideo
        shuffle
        fullAlbumDate
        wikify
        songStats
        history
        hidePodcasts
        adblock
        fullScreen
        beautifulLyrics
        ];
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
    };


}
