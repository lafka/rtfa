defmodule Spew.Instance do
  @moduledoc """
  Provides interface to create, start, stop, kill and communicate
  with instances
  """

  defmodule Item do
    defstruct [
      ref: nil,                       # string()
      name: nil,                      # string()
      appliance: nil,                 # the appliance ref
      runner: Spew.Runner.Systemd,    # module()
      command: "/bin/false",          # string()
      supervision: false,             # false | supspec()
      network: [],                    # [{:bridge, :tm} | :veth]
      rootfs: nil,                    # {type(), opts :: term()}
      mounts: [],                     # ["bind(-ro)?/[hostdir/]<rundir>" | "tmpfs/<rundir>"]
      env: [],                        # environment to set on startup
      state: {:waiting, {0, 0, 0}},   # {state(), now()}
      runtime: %{},                   # runtime specific state like logging, metrics
      tags: [],                       # [tag, ..]
    ]
  end
end