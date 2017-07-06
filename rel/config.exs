# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"cGY~0g`UQkDrm*`}:kD;U,SWr78I:]RX(?[i:$ij(^T<x)s`sTJ$4N5tZ`oe3@Tc"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"a*<[1[*YrEVJ2)fEg5dzSWp]51~CWf|dW@Eob$ii7V%;KC7imD3,d%dr,_[(Td@^"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :phoenix_presentation do
  set version: current_version(:phoenix_presentation)
  set applications: [
    :runtime_tools
  ]
end

