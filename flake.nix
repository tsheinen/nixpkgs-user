{
  description =
    "Nix packages which are not, for whatever reason, ready to be merged into nixpkgs";

  outputs = { self, nixpkgs }: {
    overlay = final: prev: {
      binaryninja = prev.pkgs.callPackage ./pkgs/binaryninja.nix { };
      radius2 = prev.pkgs.callPackage ./pkgs/radius2.nix { };
      signal-desktop-twitter =
        prev.pkgs.callPackage ./pkgs/signal-desktop-twitter.nix { };
    };

    packages.x86_64-linux =
      let pkgs = import nixpkgs { system = "x86_64-linux"; };
      in {
        binaryninja = pkgs.callPackage ./pkgs/binaryninja.nix { };
        radius2 = pkgs.callPackage ./pkgs/radius2.nix { };
        signal-desktop-twitter =
          pkgs.callPackage ./pkgs/signal-desktop-twitter.nix { };
      };

  };
}
