{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { inherit system; };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [ sculpin ];
        };

        cms = pkgs.mkShell {
          packages = with pkgs; [
            nodejs

            (pkgs.writeShellApplication {
              name = "start";

              text = "npx decap-server";
            })
          ];
        };
      };

      formatter.${system} = pkgs.nixfmt;
    };
}
