{ inputs, pkgs, ... }:

{
    programs.spicetify =
    let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
            fullAppDisplayMod
            beautifulLyrics
            adblock
        ];
        enabledCustomApps = with spicePkgs.apps; [
            marketplace
            newReleases
        ];
        theme = spicePkgs.themes.lucid;
    };
}
